"buildx rules"

load("@aspect_bazel_lib//lib:copy_file.bzl", "copy_file")
load("@aspect_bazel_lib//lib:run_binary.bzl", "run_binary")

def buildx(
        name,
        dockerfile,
        path = ".",
        srcs = [],
        build_context = [],
        execution_requirements = {"local": "1"},
        builder_name = "rules_buildx_builder",
        outs = None,
        out_dirs = None,
        output_type = "oci",
        tags = ["manual"],
        visibility = []):
    """
    Run BuildX to produce OCI base image using a Dockerfile.

    Args:
        name: name of the target
        dockerfile: label to the dockerfile to use for this build
        srcs: additional srcs to read during build
        path: path to build context where all will be relative to under Dockerfile
        build_context: a dictionary for custom build contexes. https://docs.docker.com/reference/cli/docker/buildx/build/#build-context
        execution_requirements: execution requirements for the action, we recommend using local as BuildX wants to read files outside of the sandbox.
        builder_name: name of the builder to use. https://docs.docker.com/reference/cli/docker/buildx/build/#builder
        outs: list of output files
        out_dirs: list of output directories
        output_type: BuildX output type ("oci" or "local")
        tags: tags for the target
        visibility: visibility for the target
    """
    if "requires-docker" not in tags:
        tags = tags + ["requires-docker"]

    context_args = []
    context_srcs = []
    for context in build_context:
        context_srcs = context_srcs + context["srcs"]
        context_args.append("--build-context={}={}".format(context["replace"], context["store"]))

    copy_file(
        name = name + "_dockerfile",
        src = dockerfile,
        out = "Dockerfile." + name,
        visibility = visibility,
    )

    valid_output_types = [ "oci", "local" ]
    if output_type not in valid_output_types:
        fail("Invalid output type `{}`. Expected one of {}".format("output_type", ", ".join(valid_output_types)))

    output_arg = None
    if output_type == "oci":
        output_arg = "--output=type=oci,tar=false,dest=$@"

    if output_type == "local":
        output_arg = "--output=type=local,dest=$(RULEDIR)"

    if outs == None and out_dirs == None:
        out_dirs = [name]

    run_binary(
        name = name,
        srcs = [name + "_dockerfile"] + srcs + context_srcs,
        args = [
            "build",
            path,
            "--file",
            "$(location {}_dockerfile)".format(name),
            "--builder",
            builder_name,
            output_arg,
            # Set the source date epoch to 0 for better reproducibility.
            "--build-arg SOURCE_DATE_EPOCH=0",
        ] + context_args,
        execution_requirements = execution_requirements,
        mnemonic = "BuildX",
        outs = outs,
        out_dirs = out_dirs,
        tool = "@aspect_rules_buildx//buildx:resolved_toolchain",
        tags = tags,
        visibility = visibility,
    )
