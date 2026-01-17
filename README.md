# Ferret Language – Zed Extension

Zed syntax highlighting, indentation, and brackets for the Ferret programming language.

## Local install (dev)
1. Open Zed.
2. Run `zed: install dev extension` from the command palette and select this `zed-ferret` folder.
3. Open a `.fer` file to verify highlighting.

## Publishing
1. Ensure `extension.toml` points at the correct grammar repo/revision.
2. From this directory run `zed extension publish`




# Updating Zed Extension Submodules

This guide shows how to update extension submodules in the Zed extensions registry.

## Steps to Update an Extension Submodule

### 1. Check Current Status
```bash
git submodule status
```
This shows which submodules have updates available.

### 2. Update the Submodule
```bash
git submodule update --remote extensions/ferret
```
This pulls the latest changes from the submodule's remote repository.

### 3. Update Version in extensions.toml
If the extension version changed, update the version number in `extensions.toml`:

```toml
[extension-name]
submodule = "extensions/extension-name"
version = "x.x.x"  # Update this
```

### 4. Stage and Commit Changes
```bash
git add extensions.toml extensions/[extension-name]
git commit -m "Update [extension-name] extension to version x.x.x"
```

### 5. Push Changes
```bash
git push
```

## Example: Updating Ferret Extension

```bash
# Check status
git submodule status extensions/ferret

# Update submodule
git submodule update --remote extensions/ferret

# Update version in extensions.toml (if needed)
# Edit extensions.toml to bump version

# Stage and commit
git add extensions.toml extensions/ferret
git commit -m "Update ferret extension to version 0.0.4"

# Push
git push
```

## Notes
- Always check `git submodule status` first to see what needs updating
- The submodule path is `extensions/[extension-name]`
- Version numbers should match what's in the extension's own repository
- Test locally before pushing if possible