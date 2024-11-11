debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name());

if get_application_name() == "Loading..." or get_application_name() == "YouTube Music" then
    debug_print("pinning!!")
    pin_window()
end