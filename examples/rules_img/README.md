# rules_buildx with rules_img

This example builds a Debian Trixie image with BuildX, exports a multi-platform OCI layout, and imports it into `rules_img`.

The Dockerfile installs `git`; the image entrypoint runs:

```sh
git --version
```

Build the imported `rules_img` image index:

```sh
bazel build //:git_image
```

Load one platform into a local container daemon:

```sh
bazel run //:load -- --platform linux/amd64
```
