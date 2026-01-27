# Homebrew Tap

Homebrew formulae for my tools.

## Installation

```bash
brew tap NoorXLabs/tap
brew install devbox
```

Or as a one-liner:

```bash
brew install NoorXLabs/tap/devbox
```

## Available Formulae

| Formula | Description |
|---------|-------------|
| devbox | Local-first development container manager |

## Updating Formulae

After creating a new DevBox release:

```bash
# Run from this repo's root
./scripts/update-formula.sh 0.5.0
```

This downloads the release artifacts, computes SHA256 hashes, and updates the formula automatically.
