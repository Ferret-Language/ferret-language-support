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

1. `lsp.ferretls.settings.binary_path` (if configured)
2. `ferret` from your PATH (`worktree.which("ferret")`)
3. fallback dev path: `/home/fuad/Dev/Ferret-compiler-v2/compiler/bin/ferret`

The extension passes `lsp` as default args. You can override args with `lsp.ferretls.settings.args`.

Example Zed settings:

```json
{
	"lsp": {
		"ferretls": {
			"settings": {
				"binary_path": "/home/fuad/Dev/Ferret-Language/Ferret/bin/ferret",
				"args": ["lsp"]
			}
		}
	}
}
```

## LSP settings key

Zed LSP settings are read from `ferretls` via:

- `initialization_options`
- `settings`

The current `Ferret-compiler-v2/compiler/cmd/ferret` CLI exposes an `lsp` subcommand, so no external server binary is required by default.
