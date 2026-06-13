# transitions

This example demonstrates how `rules_buildx` respects platform transitions.

Load the image:

```bash
bazel run //:load
```

Inspect the image:

```bash
docker inspect bazel/rules_buildx_transitions:latest | jq
```
