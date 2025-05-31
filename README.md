# WordPress Plugin Archiver ![GitHub License](https://img.shields.io/github/license/kermage/action-wp-plugin-archiver) ![GitHub Release](https://img.shields.io/github/v/release/kermage/action-wp-plugin-archiver) [![Actual Test](https://github.com/kermage/action-wp-plugin-archiver/actions/workflows/test.yml/badge.svg)](https://github.com/kermage/action-wp-plugin-archiver/actions/workflows/test.yml)

> Build an archive of a tagged version in ZIP format

## Usage

```yaml
- uses: kermage/action-wp-plugin-archiver@latest

  with:
    # Custom plugin slug
    # Default: ${GITHUB_REPOSITORY#*/}
    slug: ''
```

### Outputs:

- `export-dir` (string): Path to the export directory
- `plugin-zip` (string): Path to the generated plugin zip
- `plugin-slug` (string): Passed value from the input provided

### Test?

Check out [`.local`](./.local) to try it on your local machine.

## Example

Ready-to-use workflows to get started:

- [Pre-Release](./examples/pre-release.yml)

  - Triggered by a push to a specific branch where the next version is being prepared, then attaches an archived copy as an artifact for manual testing.

- [Release](./examples/release.yml)

  - Triggered by a `vX.X.X` tag push then creates a GitHub release with the plugin zip file as an asset.
