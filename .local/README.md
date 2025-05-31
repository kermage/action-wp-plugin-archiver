# Local Action

...using [Docker](https://www.docker.com) engine and [act](https://github.com/nektos/act) CLI tool

## Usage

Build the image

```bash
docker build -t action-wp-plugin-archiver .
```

Prepare variables

```bash
cp .env.example .env
cp .secrets.example .secrets
```

Run the workflow

```bash
act -W 'test.yml'
```

### Simulate

Use `--eventpath=payload.json`

```json
{
	"ref": "refs/tags/1.2.3"
}
```

### Customize

Copy [`test.yml`](./test.yml) file to the [`.github/workflows`](./.github/workflows) directory.

Modify it as needed, then run:

```bash
act
```

*For more details, read the [act usage guide](https://nektosact.com/usage).*
