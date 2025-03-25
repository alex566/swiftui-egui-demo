use font_kit::source::SystemSource;

pub fn load_font_data_by_name(font_name: &str) -> Result<Vec<u8>, String> {
    let font = SystemSource::new()
        .select_by_postscript_name(font_name)
        .map_err(|e| e.to_string())?
        .load()
        .map_err(|e| e.to_string())?;

    if let Some(data) = font.copy_font_data() {
        Ok(data.to_vec())
    } else {
        Err("Failed to get font data".to_string())
    }
}