# Ferret Language Support

Zed language support for the current Ferret language revision.

This extension currently provides:

- Tree-sitter based parsing
- syntax highlighting
- bracket matching
- indentation rules
- `.fer` file recognition
- LSP wiring (`ferret lsp`)

## LSP command resolution

The extension resolves the language server command in this order:

1. `lsp.ferretls.binary.path` (if configured)
2. `ferret` from your PATH (`worktree.which("ferret")`)

The extension passes `lsp` as default args. You can override args with `lsp.ferretls.binary.arguments`.

Example Zed settings:

```json
{
	"lsp": {
		"ferretls": {
			"binary": {
				"path": "/home/fuad/Dev/Ferret-Language/Ferret/bin/ferret",
				"arguments": ["lsp"]
			}
		}
	}
}
```

## LSP settings key

Zed LSP settings are read from `ferretls` via:

- `initialization_options`
- `settings`

Command launch configuration is read separately from `lsp.ferretls.binary`.

The current `Ferret-compiler-v2/compiler/cmd/ferret` CLI exposes an `lsp` subcommand, so no external server binary is required by default.


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
git submodule status

# Update submodule
git submodule update --remote extensions/ferret

# Update version in extensions.toml (if needed)
# Edit extensions.toml to bump version

# Stage and commit
git add extensions.toml extensions/ferret
git commit -m "Update ferret to vX.X.X"

# Push
git push
```

## Notes
- Always check `git submodule status` first to see what needs updating
- The submodule path is `extensions/[extension-name]`
- Version numbers should match what's in the extension's own repository
- Test locally before pushing if possible
