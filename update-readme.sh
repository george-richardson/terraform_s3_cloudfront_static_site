docker run \
  --rm \
  -v "$(pwd):/terraform-docs" -w "/terraform-docs" \
    quay.io/terraform-docs/terraform-docs:latest markdown . --output-file README.md --header-from .terraform-docs.header.md
