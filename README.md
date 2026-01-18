# Obsidian Mobile Test

A dummy repository for installing plugins via BRAT (Beta Reviewers Auto-update Tool).

## Overview

This repository is used to install and test Obsidian plugins in development on mobile devices via BRAT.

It builds the plugin in the specified source directory and copies the generated `main.js` and `styles.css` to this repository to create a release.

> **Note:** `manifest.json` is not copied because it contains repository-specific information (plugin ID, name, etc.). Using the same `manifest.json` as the original plugin would cause conflicts.

## Getting Started

Clone this repository:

```bash
git clone https://github.com/takeshy/obsidian-mobile-test.git
cd obsidian-mobile-test
```

## Requirements

- Node.js
- Git
- Source plugin must be buildable with `npm run build`

## Usage

### 1. Sync from Source Plugin

```bash
./sync-from.sh /path/to/source/plugin
```

This script performs the following:

1. Runs `npm run build` in the specified directory
2. Copies the generated `main.js` and `styles.css` to this repository
3. Commits with the source directory name as the commit message
4. Bumps version with `npm version patch`
5. Pushes to GitHub

### 2. Automatic Release

After pushing, GitHub Actions automatically creates a release.

### 3. Install via BRAT

> ⚠️ **IMPORTANT:** Before installing via BRAT, you must **disable the original plugin** in Obsidian's Community Plugins settings. Having both plugins enabled simultaneously will cause conflicts.

1. **Disable the original plugin** in Obsidian Settings → Community Plugins
2. Install the BRAT plugin in Obsidian
3. Select "Add Beta plugin" in BRAT settings
4. Enter your repository URL:
   ```
   https://github.com/xxxx/obsidian-mobile-test
   ```
5. The plugin will be installed

> Replace `xxxx` with your GitHub username.

### 4. Revert to Original Plugin

After testing, to switch back to the original plugin:

1. **Disable this test plugin** in Obsidian Settings → Community Plugins
2. **Enable the original plugin**

## File Structure

```
.
├── main.js           # Built plugin code
├── styles.css        # Stylesheet
├── manifest.json     # Plugin manifest (specific to this repository)
├── versions.json     # Version history
├── sync-from.sh      # Sync script
├── package.json      # For version management
├── version-bump.mjs  # Version update script
└── LICENSE
```

## Workflow

```
Source Plugin                       This Repository
     │                                   │
     │  ./sync-from.sh /path/to/src      │
     │ ─────────────────────────────────>│
     │                                   │
     │  1. npm run build                 │
     │  2. copy main.js, styles.css      │
     │  3. git commit & version bump     │
     │  4. git push                      │
     │                                   │
     │              GitHub Actions       │
     │                    │              │
     │                    v              │
     │              Create Release       │
     │                    │              │
     │                    v              │
     │              Available via BRAT
```

## Notes

- This repository is for testing and development purposes
- Use the original plugin repository for production
- The `id` and `name` in `manifest.json` differ from the original plugin

## License

MIT License
