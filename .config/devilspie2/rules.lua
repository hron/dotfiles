debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name());

if get_application_name() == "Loading..." or get_application_name() == "YouTube Music" then
    pin_window()
end

if string.match(get_application_name(), "- Discord$") then
    set_window_geometry(721, 215, 2399, 1651)
end