# WordPress Plugin Archiver ![GitHub License](https://img.shields.io/github/license/kermage/action-wp-plugin-archiver)

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
