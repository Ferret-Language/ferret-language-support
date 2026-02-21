use zed_extension_api as zed;

struct FerretExtension;

const FERRET_BIN: &str = "/home/fuad/Dev/Ferret-Language/Ferret/bin/ferret";

impl zed::Extension for FerretExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<zed::Command> {
        let settings = zed::settings::LspSettings::for_worktree("ferret-lsp", worktree)
            .unwrap_or_default();

        if !lsp_enabled(&settings) {
            return Err("ferret-lsp disabled in settings".to_string());
        }

        let command = FERRET_BIN.to_string();
        let args = vec!["lsp".to_string()];
        let env = worktree.shell_env();

        Ok(zed::Command { command, args, env })
    }

    fn language_server_initialization_options(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<Option<zed::serde_json::Value>> {
        let settings = zed::settings::LspSettings::for_worktree("ferret-lsp", worktree)
            .unwrap_or_default();
        Ok(settings.initialization_options)
    }

    fn language_server_workspace_configuration(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<Option<zed::serde_json::Value>> {
        let settings = zed::settings::LspSettings::for_worktree("ferret-lsp", worktree)
            .unwrap_or_default();

        let value = settings.settings.and_then(|mut value| {
            if let zed::serde_json::Value::Object(ref mut map) = value {
                map.remove("enabled");
            }
            Some(value)
        });

        Ok(value)
    }
}

fn lsp_enabled(settings: &zed::settings::LspSettings) -> bool {
    let enabled = settings
        .settings
        .as_ref()
        .and_then(|value| value.get("enabled"))
        .and_then(|value| value.as_bool());
    enabled.unwrap_or(true)
}

zed::register_extension!(FerretExtension);
