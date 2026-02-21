use zed_extension_api as zed;

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
        let command = worktree
            .which("ferret")
            .ok_or_else(||"ferret binary not found in PATH".to_string())?;
        // For Local Development
        //let command = "/home/fuad/Dev/Ferret-Language/Ferret/bin/ferret".to_string();
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
        Ok(settings.settings)
    }
}

zed::register_extension!(FerretExtension);
