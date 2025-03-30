debug_print("Application: " .. get_application_name())
debug_print("Window: " .. get_window_name());

if get_application_name() == "Loading..." or get_application_name() == "YouTube Music" then
    pin_window()
end

if string.match(get_application_name(), "- Discord$") then
    set_window_geometry(721, 215, 2399, 1651)
end

if get_application_name() == "TelegramDesktop" then
    set_window_geometry(900, 236, 2040, 1680)
end

if get_application_name() == "KeePassXC" then
    set_window_geometry(729, 213, 2382, 1650)
end

-- if string.match(get_application_name(), "Factorio") then
--     local cmd = "sleep 1; xdotool windowsize " ..  get_window_xid() .. " 1920 1080"
--     local handle = io.popen(cmd .. " 2>&1") -- Объединяем stderr и stdout
--     local output = handle:read("*a")       -- Читаем весь вывод
--     handle:close()
--     debug_print("Factorio resize: " .. output)
-- end

if get_application_name() == "System Monitor" then
    set_window_geometry(764, 161, 2312, 1926)
end