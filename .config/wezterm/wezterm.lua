local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe', '-NoLogo' }
  config.mux_enable_ssh_agent = false
end

config.initial_cols = 117
config.initial_rows = 55

config.font = wezterm.font_with_fallback {
    {family='JetBrainsMono Nerd Font', weight="Regular"},
    'Monospace'
}
config.font_size = 10

config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = true

local modus_videndi = wezterm.color.get_builtin_schemes()['Modus Videndi (Gogh)']
local modus_opernadi = wezterm.color.get_builtin_schemes()['Modus Operandi (Gogh)']
modus_opernadi.tab_bar = {
    background = 'red'
}

config.color_schemes = {
    ['Modus Videndi (Gogh)'] = modus_videndi,
    ['Modus Operandi (Gogh)'] = modus_opernadi
}
-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
    if appearance:find 'Dark' then
        return 'Modus Videndi (Gogh)'
    else
        return 'Modus Operandi (Gogh)'
    end
end

config.color_scheme = scheme_for_appearance(get_appearance())

config.disable_default_key_bindings = true

config.keys = {
  { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = ')', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  -- { key = 'F', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  -- { key = 'F', mods = 'CTRL', action = act.Search { CaseInSensitiveString = 'CurrentSelectionOrEmptyString' } },
  { key = 'f', mods = 'CTRL', action = act.Search { CaseInSensitiveString = '' } },
  { key = 'F', mods = 'CTRL', action = act.Search { CaseInSensitiveString = '' } },
  { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
  { key = 'U', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
  { key = 'l', mods = 'CTRL', action = act.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'L', mods = 'CTRL', action = act.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'x', mods = 'ALT|CTRL', action = act.ShowDebugOverlay },
  { key = 'X', mods = 'ALT|CTRL', action = act.ShowDebugOverlay },
  { key = 'x', mods = 'ALT', action = act.ActivateCommandPalette },
  { key = 'X', mods = 'ALT', action = act.ActivateCommandPalette },
  { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'T', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'u', mods = 'ALT', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
  { key = 'U', mods = 'ALT', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'w', mods = 'CTRL', action = act.CloseCurrentTab{ confirm = true } },
  { key = 'W', mods = 'CTRL', action = act.CloseCurrentTab{ confirm = true } },
  { key = 'Space', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
  { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
  { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
  { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
  { key = 'UpArrow', mods = 'ALT', action = act.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'ALT', action = act.ScrollToPrompt(1) },
  { key = 'Backspace', mods = 'CTRL', action = act.SendKey { key = 'Backspace', mods = 'ALT' } },
}

config.key_tables = {
    copy_mode = {
        { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
        { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
        { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
        { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
        { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
        { key = 'LeftArrow', mods = 'CTRL', action = act.CopyMode 'MoveBackwardWord' },
        { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
        { key = 'RightArrow', mods = 'CTRL', action = act.CopyMode 'MoveForwardWord' },
        { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
        { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
        { key = 'Home', mods = 'CTRL', action = act.CopyMode 'MoveToScrollbackTop' },
        { key = 'End', mods = 'CTRL', action = act.CopyMode 'MoveToScrollbackBottom' },
        { key = 'Enter', mods = 'NONE', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { Multiple = { 'ScrollToBottom', { CopyMode = 'ClearSelectionMode'}, { CopyMode =  'Close' } } } } },
        { key = 'Space', mods = 'CTRL|SHIFT', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { Multiple = { 'ScrollToBottom', { CopyMode = 'ClearSelectionMode'}, { CopyMode =  'Close' } } } } },
        { key = 'c', mods = 'CTRL', action = act.Multiple{ { CopyTo =  'ClipboardAndPrimarySelection' }, { CopyMode =  'ClearSelectionMode' } } },
        { key = 'Space', mods = 'CTRL', action = act.CopyMode{ SetSelectionMode =  'Cell' } },
        { key = 'Enter', mods = 'CTRL|SHIFT', action = act.CopyMode{ SetSelectionMode =  'Block' } },
        { key = 'Escape', mods = 'NONE', action = act.CopyMode 'ClearSelectionMode' },
        { key = 'UpArrow', mods = 'CTRL|ALT', action = act.Multiple { {CopyMode = 'PriorMatch'}, { CopyMode = 'ClearSelectionMode'}} },
        { key = 'DownArrow', mods = 'CTRL|ALT', action = act.Multiple { {CopyMode = 'NextMatch'}, { CopyMode = 'ClearSelectionMode'}} },
        { key = 'UpArrow', mods = 'ALT', action = act.CopyMode { MoveBackwardZoneOfType = 'Prompt' } },
        { key = 'DownArrow', mods = 'ALT', action = act.CopyMode  { MoveForwardZoneOfType = 'Prompt' } },
    },

  search_mode = {
    { key = 'Enter', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 's', mods = 'ALT', action = act.CopyMode 'CycleMatchType' },
    { key = 'S', mods = 'ALT', action = act.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'U', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
    { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
    { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    { key = 'UpArrow', mods = 'CTRL|ALT', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'CTRL|ALT', action = act.CopyMode 'NextMatch' },
    { key = 'Space', mods = 'SHIFT|CTRL', action = act.Multiple { 'ActivateCopyMode', { CopyMode = 'ClearSelectionMode'}} },
  },
}

-- Until https://github.com/wezterm/wezterm/issues/6645 is sorted (patched by myself for now)
-- Also, settings this to true prevent KDE from applying the window rule to set proper geometry
config.enable_wayland = true


-- Finally, return the configuration to wezterm:
return config
