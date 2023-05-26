# pre-commit-docker-kustomize

pre-commit hook which runs kustomize docker image. Container image is based on <https://github.com/lyft/kustomizer>, but added github.com into known hosts and not running this image as root. This modification allows for remote refs in your kustomize. Other git providers will probably won't work and require further changes. Please raise an issue.

## Example of .pre-commit-config.yaml that verifies that 3 overlays are not broken

```yaml
# See https://pre-commit.com for more information
# See https://pre-commit.com/hooks.html for more hooks
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v2.4.0
    hooks:
    -   id: check-yaml
        args: [--allow-multiple-documents]
    -   id: check-added-large-files
-   repo: https://github.com/b4mad/pre-commit-kustomize
    rev: f3a8533
    hooks:
    -   id: kustomize
        name: kustomize-development
        args: [overlays/development]
        verbose: true
    -   id: kustomize
        name: kustomize-staging
        args: [overlays/staging]
        verbose: false
    -   id: kustomize
        name: kustomize-production
        args: [overlays/production]
        verbose: false
