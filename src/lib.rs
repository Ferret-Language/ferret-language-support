use zed_extension_api as zed;

struct FerretExtension;

impl zed::Extension for FerretExtension {
    fn new() -> Self {
        Self
    }
}

zed::register_extension!(FerretExtension);
