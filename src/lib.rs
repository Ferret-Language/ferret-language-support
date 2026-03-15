use zed_extension_api as zed;
use zed::serde_json::Value;

struct FerretExtension;

impl zed::Extension for FerretExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<zed::Command> {
        let settings =
            zed::settings::LspSettings::for_worktree("ferret-lsp", worktree).unwrap_or_default();

        // let mut command = worktree
        //     .which("ferret")
        //     .ok_or_else(||"ferret binary not found in PATH".to_string())?;

        // For local extension/compiler development, you can force a fixed path:
        let mut command = "/home/fuad/Dev/Ferret-compiler-v2/compiler/bin/ferret".to_string();

        let mut args = vec!["lsp".to_string()];
        if let Some(Value::Object(obj)) = settings.settings.as_ref() {
            if let Some(Value::String(path)) = obj.get("binary_path") {
                if !path.trim().is_empty() {
                    command = path.clone();
                }
            }
            if let Some(Value::Array(user_args)) = obj.get("args") {
                let parsed_args: Vec<String> = user_args
                    .iter()
                    .filter_map(|v| v.as_str().map(ToString::to_string))
                    .collect();
                if !parsed_args.is_empty() {
                    args = parsed_args;
                }
            }
        }
        let env = worktree.shell_env();

        Ok(zed::Command { command, args, env })
    }

    fn language_server_initialization_options(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<Option<zed::serde_json::Value>> {
        let settings =
            zed::settings::LspSettings::for_worktree("ferret-lsp", worktree).unwrap_or_default();
        Ok(settings.initialization_options)
    }

    fn language_server_workspace_configuration(
        &mut self,
        _language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> zed::Result<Option<zed::serde_json::Value>> {
        let settings =
            zed::settings::LspSettings::for_worktree("ferret-lsp", worktree).unwrap_or_default();
        Ok(settings.settings)
    }
}

zed::register_extension!(FerretExtension);
