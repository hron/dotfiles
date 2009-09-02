-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Notification library
-- require("naughty")

-- TODO:
--
--  * replace xterm with something more robust and light (urxvt)

--{{{ dbg function
function dbg(vars)
    local a = nil
    local text = "<span color = \"#FF004D\">dbg </span>"
    for i,j in pairs(vars) do
        a = "<span color='#333333'>" .. i .. " </span>"
        if type(j) == "string" or type(j) == "number" then a = a .. j 
        elseif type(j) == "boolean" then 
            if j then a = a .. "true" else a = a.. " false" end
        elseif type(j) == "table" then a = a .. "table #" .. #j
        else a = a .. tostring(j) or "nil"
        end
        text = text .. " \n" .. a
    end
    naughty.notify{ text = text, timeout = 0, hover_timeout = 0.2 }
end
--}}}

require("shifty")

--{{{ vars 

--{{{ vars / common
theme_path = awful.util.getdir("config") .. "/themes/hron/theme.lua"
beautiful.init(theme_path)
modkey = "Mod4"
if screen.count() == 2 then LCD = 2 else LCD = 1 end

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
--    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
    awful.layout.suit.floating,
--    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier,
}

--custom
config = {}
config.terminal = "gnome-terminal --hide-menubar "

-- step for scrolling
config.step = 15

-- screen offset it scrolls within
config.scroll_offset = 2

--}}}

--{{{ vars / shifty

--{{{ vars / shifty / config.tags
shifty.config.tags = {
   ["1"] = { postition = 0, init = true },
   ["9:mail"] = { position = 9, init = true }
}
--}}}

--{{{ vars / shifty / config.apps
shifty.config.apps = {
   
    -- all
   { match = { "", },
     honorsizehints = false,
     smart_placement = true,
     slave = true,
     buttons = {
   	button({ }, 1, function (c) client.focus = c; c:raise() end),
   	button({ modkey }, 1, function (c) awful.mouse.client.move() end),
   	button({ modkey }, 3, awful.mouse.client.resize ),},
   },

   { match = {
				"stardict",
				"gcolor2",
				"Evolution",
				"Gnome-rdp",
				"totem",
				"Celetania.*",
				"Update Manager",
				"Firefox Preferences",
				"*VLC*"
   }, float = true, },

   { match = { "gtkvncviewer.py", },
     float = true,
     geometry = { 190, 120, 800, 600 }, },
   
   { match = { ".* - Conkeror" },
     float = true,
     slave = false,
     geometry = { 90, 80, 1024, 650 } },

   { match = { "Gnus" },
     tag = "9:mail" },

   { match = { "Emacs" },
     slave = false, },

   { match = { "conversation" },
     float = true,
     sticky = true },
   
   { match = { "buddy_list", "Gajim.py" },
     float = true,
     smart_placement = false,
     sticky = true,
     honorsizehints = true, },

   { match = { "Skype" },
     float = true,
     smart_placement = false },
}
--}}}

shifty.config.defaults = { 
   layout = awful.layout.suit.tail,
   leave_kills = true,
   floatBars = true,
    --run = function(tag) naughty.notify({ text = tag.name }) end,
    --run = function(tag) naughty.notify({ text = "Shifty Created: "    ..(awful.tag.getproperty(tag,"position") or shifty.tag2index(mouse.screen,tag)).. " : "..tag.name }) end
}

shifty.config.default_name = "?"
shifty.init()
--}}}

--{{{ vars / naughty

-- --  naughty settings
-- naughty.config.border_color = 'black'
-- naughty.config.font = 'Monospace 7.5'
-- naughty.config.icon_size = 32
-- naughty.config.width = 300
-- naughty.config.position = "top_left"
-- naughty.config.spacing = 3
-- naughty.config.padding = 5
-- naughty.config.margin = 5
-- naughty.config.presets.normal.height = 16
-- --naughty.config.timeout = 0
-- --naughty.config.hover_timeout = 0.2
-- naughty.config.screen = LCD
-- --}}}

--}}}

awful.util.spawn( "killall gnome-panel")

--{{{ functions

--{{{ functions / run
function run(command, class)
   for a,b in ipairs(awful.client.visible(1)) do
      print(b)
      if b.class then if b.class:match(class) then
	    b.focus()
	 else
	    awful.util.spawn(command)
	 end
      end
   end
end
--}}}

--{{{ functions / run_or_raise
--- wikipaste ---
--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients.  Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
   local clients = client.get()
   for i, c in pairs(clients) do
      if match(properties, c) then
         local ctags = c:tags()
         if table.getn(ctags) == 0 then
            -- ctags is empty, show client on current tag
            local curtag = awful.tag.selected()
            awful.client.movetotag(curtag, c)
         else
            -- Otherwise, pop to first tag client is visible on
            awful.tag.viewonly(ctags[1])
         end
         -- And then focus the client
         client.focus = c
         c:raise()
         return
      end
   end
   awful.util.spawn(cmd)
end
--}}}

--{{{ functions / match
-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v then
         return false
      end
   end
   return true
end
--}}}

--{{{ functions / scrollclient
-- scrolling clients bigger than workspace
function scrollclient()
   local c = client.focus
   if not c then return end

   local ss = screen[c.screen].geometry
   local ws = screen[c.screen].workarea
   local cc = c:geometry()
   local mc = mouse.coords()
   local step = 0

   -- left edge
   if mc.x < config.scroll_offset and cc.x < 0 then
      step = math.min(config.step, -cc.x)
      awful.client.moveresize(step,0,0,0,c)
   end
   
   -- right edge
   if mc.x > ws.width - config.scroll_offset and cc.x + cc.width > ws.width + 1 then
      step = math.min(config.step, cc.x + cc.width-ws.width)
      awful.client.moveresize(-step,0,0,0,c)
   end

   -- top edge
   if mc.y < config.scroll_offset and cc.y < ss.height - ws.height then
      step = math.min(config.step, ss.height - ws.height - cc.y - 1) -- FIXME: -1 is for the frame to hide under panels BROKEN
      awful.client.moveresize(0,step,0,0,c)
   end

   -- bottom edge
   if mc.y > ws.height - config.scroll_offset and cc.y + cc.height > ss.height then
      step = math.min(config.step, cc.y + cc.height - ss.height)
      awful.client.moveresize(0,-step,0,0,c)
   end

end
--}}}

--{{{ functions / lua completion
function lua_completion (line, cur_pos, ncomp)
   -- Only complete at the end of the line, for now
   if cur_pos ~= #line + 1 then
      return line, cur_pos
   end

   -- We're really interested in the part following the last (, [, comma or space
   local lastsep = #line - (line:reverse():find('[[(, ]') or #line)
   local lastidentifier
   if lastsep ~= 0 then
      lastidentifier = line:sub(lastsep + 2)
   else
      lastidentifier = line
   end

   local environment = _G

   -- String up to last dot is our current environment
   local lastdot = #lastidentifier - (lastidentifier:reverse():find('.', 1, true) or #lastidentifier)
   if lastdot ~= 0 then
      -- We have an environment; for each component in it, descend into it
      for env in lastidentifier:sub(1, lastdot):gmatch('([^.]+)') do
         if not environment[env] then
            -- Oops, no such subenvironment, bail out
            return line, cur_pos
         end
         environment = environment[env]
      end
   end

   local tocomplete = lastidentifier:sub(lastdot + 1)
   if tocomplete:sub(1, 1) == '.' then
      tocomplete = tocomplete:sub(2)
   end

   local completions = {}
   for k, v in pairs(environment) do
      if type(k) == "string" and k:sub(1, #tocomplete) == tocomplete then
         table.insert(completions, k)
      end
   end

   if #completions == 0 then
      return line, cur_pos
   end
   
   while ncomp > #completions do
      ncomp = ncomp - #completions
   end

   local str = ""
   if lastdot + lastsep ~= 0 then
      str = line:sub(1, lastsep + lastdot + 1)
   end
   str = str .. completions[ncomp]
   cur_pos = #str + 1
   return str, cur_pos
end
--}}}

--{{{ functions / terminal
-- runs terminal
function terminal(args)
   if args then
      awful.util.spawn(config.terminal .. ' ' .. args)
   else
      awful.util.spawn(config.terminal)
   end
end
--}}}

--{{{ functions / jointables
-- join two tables 
function jointables(t1,t2)
   local tmp={}
   for i,v in pairs(t1) do	table.insert(tmp,v) end
   for i,v in pairs(t2) do	table.insert(tmp,v) end
   return tmp
end
--}}}

--{{{ functions / splitbywhitespace
function splitbywhitespace(str)
   values = {}
   start = 1
   splitstart, splitend = string.find(str, ' ', start)
   
   while splitstart do
      m = string.sub(str, start, splitstart-1)
      if m:gsub(' ','') ~= '' then
	 table.insert(values, m)
      end

      start = splitend+1
      splitstart, splitend = string.find(str, ' ', start)
   end

   m = string.sub(str, start)
   if m:gsub(' ','') ~= '' then
      table.insert(values, m)
   end

   return values
end
--}}}

--{{{ functions / taginfo
function ti()
   local v = ""
   local t = awful.tag.selected() 
   local i = 1

   for op, val in pairs(awful.tag.getdata(t)) do
      v =  v .. "\n" .. i .. ": " .. op .. " = " .. tostring(val)
      i = i + 1
   end

   naughty.notify{ text = "<span font_desc=\"Verdana Bold 20\">&lt; " .. t.name .. " &gt;</span>\n"..tostring(t).."\nclients: " .. #t:clients() .. "\n" .. v, timeout = 0, width = "230"}
end
--}}}

--{{{ functions / clientinfo
function ci()
   local v = ""
   local c = client.focus
   local inf = {
      "id", "group_id", "leader_id", "name", "icon_name",
      "skip_taskbar", "type", "class", "role", "instance", "pid",
      "machine", "icon_name", "screen", "hide", "minimize",
      "size_hints_honor", "titlebar", "urgent", "focus", "opacity",
      "ontop", "above", "below", "fullscreen", "transient_for", "smart_placement"
   }

   for i = 1, #inf do
      v =  v .. "\n" .. i .. ": " .. inf[i] .. " = " .. tostring(c[inf[i]])
   end

   naughty.notify{ text = v, timeout = 0, width = 230}
end
--}}}

--{{{ functions / widgettext
-- format widget output
function widgettext(label, value, labelcolor, valuecolor)
   local lc = labelcolor or beautiful.widget_label
   local vc = valuecolor or beautiful.widget_value
   return 	'<span color="' .. lc .. '">' .. label .. ' </span><span color="' .. vc .. '">'  .. value .. '</span>' .. config.widgets.space
end
--}}}

--{{{ functions / islidclosed
function islidclosed()
   local f = io.open("/proc/acpi/button/lid/LID/state")
   state = f:read()
   f:close()
   if state:find("closed") then
      return true
   else
      return false
   end
end
lidclosed = islidclosed()
--}}}

--}}}

--{{{ widgets / prompt
mypromptbox = widget({ type = "textbox",
		       name = "mypromptbox",
		       align = "left" })
--}}}

--{{{ widgets / systray
mysystray = widget({ type = "systray",
		     name = "mysystray",
		     align = "right" })
--}}}

--{{{ widgets / layoutbox
mylayoutbox = {}
for s = 1, screen.count() do
   mylayoutbox[s] = widget({ type = "imagebox", align = "left" })
   mylayoutbox[s]:buttons({
        button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        button({ }, 5, function () awful.layout.inc(layouts, -1) end)
     })
end
--}}}

--{{{ widgets / initialize separators, widget tables

-- separator widgets
sep_l = widget({
	type = 'textbox',
	name = 'sep_l',
	align = 'left',
})
sep_l.text='<span font_desc="verdana 4"> </span>'

sep_r = widget({
	type = 'textbox',
	name = 'sep_r',
	align = 'right',
})
sep_r.text='	'

--{{{ panels / taglist+tasklist
mytaglist = {}
mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
                      button({ modkey }, 1, awful.client.movetotag),
                      button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      button({ modkey }, 3, awful.client.toggletag),
                      button({ }, 4, awful.tag.viewnext),
                      button({ }, 5, awful.tag.viewprev) }
mytasklist = {}
mytasklist.buttons = { button({ }, 1, function (c)
                                          if not c:isvisible() then
                                              awful.tag.viewonly(c:tags()[1])
                                          end
                                          client.focus = c
                                          c:raise()
                                      end),
		       button({ }, 3,
			      function ()
				 if instance then
				    instance:hide() instance = nil
				 else
				    instance = awful.menu.clients({ width=250 })
				 end
			      end),
                       button({ }, 4, function ()
                                          awful.client.focus.byidx(1)
                                          if client.focus then client.focus:raise() end
                                      end),
                       button({ }, 5, function ()
                                          awful.client.focus.byidx(-1)
                                          if client.focus then client.focus:raise() end
                                      end) }


for s = 1, screen.count() do
    -- Create a promptbox for each screen
    -- Create an imagebox widget which will contains an icon
    --   indicating which layout we're using.
    -- We need one layoutbox per screen.
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s,
					    awful.widget.taglist.label.all,
					    mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)
    -- Create the wibox
end
shifty.taglist = mytaglist

tabbar = {}
for s = 1, screen.count() do
    tabbar[s] = wibox({ position = "top", name = "tabbar" .. s,
                                 fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters
    tabbar[s].widgets = {
        mylayoutbox[s],
	mypromptbox,
        mytaglist[s],
        mytasklist[s],
	s == 1 and mysystray
	
    }
    tabbar[s].screen = s
--    tabbar[s].ontop = true
end
-- }}}

--}}}

-- {{{ bindings 

-- {{{ bindings / menus
menukeys = {}
menukeys.down = "j"
menukeys.up = "k"
menukeys.exec = "Return"
menukeys.back = "h"
menukeys.close = "Escape"

awful.menu.setkeys( menukeys)
-- }}}

-- {{{ bindings / global
globalkeys = {

-- {{{ bindings / global / spawns
  key({ modkey }, "t", function () terminal() end),
  key({ modkey }, "b", function () awful.util.spawn("conkeror") end),
  key({ modkey }, "e", function () awful.util.spawn("emacsclient -nc") end),
  key({ modkey }, "q",
			function ()
				 awful.util.spawn( "stardict '" .. selection() .. "'")
			end),
  -- key({ modkey }, "q", function () awful.util.spawn("sh -c 'stardict \"`xclip -o`\"'") end),
  key({ modkey }, "Backspace", function () awful.util.spawn("gmpc") end),
  key({ }, "Print", function () awful.util.spawn("gnome-screenshot -i") end),
-- }}}

-- {{{ bindings / global / tag manipulation
  key({ }, "XF86Back",    awful.tag.viewprev),
  key({ }, "XF86Forward", awful.tag.viewnext),

  key({  modkey }, "XF86Forward", shifty.shift_next),
  key({  modkey }, "XF86Back", shifty.shift_prev),
  key({  "Shift" }, "XF86Forward", shifty.send_next),
  key({  "Shift" }, "XF86Back", shifty.send_prev),

  key({ modkey }, "w", function()
			  shifty.add({ rel_index = 1 })
		       end),
  key({ modkey, "Control" }, "w", function()
				     shifty.add({ rel_index = 1,
						  nopopup = true })
				  end),
  key({ modkey, "Shift" }, "a", shifty.del),
  key({ modkey }, "a", shifty.rename),

  -- ti (taginfo)
  key({ modkey }, 'i', ti),
-- }}}

-- {{{ bindings / global / client manipulation
  key({ "Control" }, "XF86Back",
      function ()
	 awful.client.focus.byidx(-1);
	 if client.focus then
	    client.focus:raise()
	 end
      end),
  key({ "Control" }, "XF86Forward",
      function ()
	 awful.client.focus.byidx(1);
	 if client.focus then
	    client.focus:raise()
	 end
      end),
  key({ modkey, "Shift" }, "XF86Forward",
      function () awful.client.swap.byidx(1) end),
  key({ modkey, "Shift"   }, "XF86Back",
      function () awful.client.swap.byidx(-1) end),
-- }}}

-- {{{ bindings / global / default rc.lua keys

  key({ modkey }, "Escape", awful.tag.history.restore),

  key({ modkey,           }, "j",
      function ()
	 awful.client.focus.byidx( 1)
	 if client.focus then client.focus:raise() end
      end),
  key({ modkey,           }, "k",
      function ()
	 awful.client.focus.byidx(-1)
	 if client.focus then client.focus:raise() end
      end),

  key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
  key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
  key({ modkey, "Control" }, "j", function () awful.screen.focus(1) end),
  key({ modkey, "Control" }, "k", function () awful.screen.focus(-1) end),

  key({ modkey }, "Tab",
      function ()
	 awful.client.focus.history.previous();
	 if client.focus then
	    client.focus:raise()
	 end
      end),

  key({ modkey }, "\\",
      function ()
	 m = awful.menu.clients()
	 m:hide()
	 m:show( true)
      end),
	 
  key({ modkey }, "u", awful.client.urgent.jumpto),

-- Standard program

  key({ modkey, "Shift" }, "r",
      function ()
	 mypromptbox.text = awful.util.escape(awful.util.restart())
      end),
  -- key({ modkey, "Shift" }, "q", awesome.quit),

-- Layout manipulation
  key({ modkey }, "l", function () awful.tag.incmwfact(0.05) end),
  key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end),
  key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster(1) end),
  key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1) end),
  key({ modkey, "Control" }, "h", function () awful.tag.incncol(1) end),
  key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1) end),
  key({ modkey }, "space", function () awful.layout.inc(layouts, 1) end),
  key({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end),
--}}}

-- {{{ bindings / global / prompts

-- {{{ bindings / global / prompts / run
  key({ modkey }, "r",
  function ()
     info = true
     awful.prompt.run({
       fg_cursor = "orange", bg_cursor=beautiful.bg_normal, ul_cursor = "single",
       prompt = "<span color='orange'>Run:</span> " 
    },
    mypromptbox,
    awful.util.spawn,
    awful.completion.shell,
    os.getenv("HOME") .. "/.cache/awesome/history") 
  end),
-- }}}

-- {{{ bindings / global / prompts / lua
  key({ modkey }, "F1",
  function ()
     info = true
     awful.prompt.run({
      fg_cursor="#D1FF00", bg_cursor=beautiful.bg_normal, ul_cursor = "single",
      prompt = "<span color = '#D1FF00'>Lua:</span> "
    },
    mypromptbox,
    awful.util.eval,
    lua_completion,
    os.getenv("HOME") .. "/.cache/awesome/history_eval") 
  end),
-- }}}


-- {{{ bindings / global / prompts / client infobox
  key({ modkey, "Ctrl"    }, "i", 
      function ()
	 if mypromptbox.text then
	    info = nil
	    mypromptbox.text = nil
	 else
	    info = true

	    local c = client.focus
	    local cc = c:geometry()
	    mypromptbox.text = nil
	    local tmp = " "
	    local format = "<span color='#ffffff'>%s</span> <span color='orange'>%s</span>" .. config.widgets.space
	    
	    if c.class then
	       tmp = tmp .. string.format(format,'class', client.focus.class) end
	    if c.instance then
	       tmp = tmp .. string.format(format,'inst', client.focus.instance) end
	    if c.role then
	       tmp = tmp .. string.format(format,'role', client.focus.role) end
	    if c.pid then
	       tmp = tmp .. string.format(format,'pid', client.focus.pid) end
	    
	    local signx = '+'
	    if cc.x < 0 then signx = '' end
	    local signy = '+'
	    if cc.y < 0 then signy = '' end
	    tmp = tmp .. string.format(format,'geom', cc.width .. 'x' .. cc.height .. signx .. cc.x .. signy .. cc.y)
	    
	    if c.type then
	       tmp = tmp .. string.format(format,'type', client.focus.type)
	    end

	    mypromptbox.text = tmp
	 end
      end),
-- }}}

-- }}}

}

-- {{{ bindings / global / shifty.getpos
for i=1, ( shifty.config.maxtags or 9 ) do
  table.insert(globalkeys, key({ modkey }, i,
  function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  table.insert(globalkeys, key({ modkey, "Control" }, i,
  function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  table.insert(globalkeys, key({ modkey, "Control", "Shift" }, i,
  function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  -- move clients to other tags
  table.insert(globalkeys, key({ modkey, "Shift" }, i,
    function ()
      if client.focus then
        t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
      end
    end))
end
-- }}}


-- }}}

--{{{ bindings / client
clientkeys = {
  key({ modkey }, "m",
      function (c)
	 c.maximized_horizontal = not c.maximized_horizontal
	 c.maximized_vertical = not c.maximized_vertical
      end),
  key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen end),
  key({ modkey, "Shift" }, "m",
      function (c)
	 c.minimized = not c.minimized
      end),
  key({ modkey }, "/",
      function (c)
	 c.sticky = not c.sticky
      end),
  key({ modkey, "Shift"   }, "c", function (c) c:kill() end),
  -- key({ modkey }, "v", awful.client.floating.toggle),
  key({ modkey }, "v",
      function (c)
	 if awful.client.floating.get(c) then
	    awful.titlebar.remove(c)
	 else
	    awful.titlebar.add( c, { modkey = modkey,  height = 16})
	 end
	 awful.client.floating.toggle( c)
      end),
  key({ modkey, "Shift" }, "v",
      function (c)
	 if c.titlebar then
	    awful.titlebar.remove( c)
	 else
	    awful.titlebar.add( c, { modkey = modkey, height = 16 })
	 end
      end),
  key({ modkey }, "Return",
      function (c) c:swap(awful.client.getmaster()) end),
  key({ modkey }, "o", awful.client.movetoscreen),
  key({ modkey, "Shift" }, "i", ci),
}
--}}}

-- {{{ bindings / set keys and buttons
root.buttons({
    button({ }, 3, function () mymainmenu:toggle() end),
    button({ }, 4, awful.tag.viewnext),
    button({ }, 5, awful.tag.viewprev)
})
root.keys(globalkeys)
shifty.config.clientkeys = clientkeys
shifty.config.globalkeys = globalkeys
-- }}}

-- }}}

-- {{{ hooks 

-- {{{ hooks / focus
awful.hooks.focus.register(function (c)
  -- see if the client needs scrolling
  local ws = screen[c.screen].workarea
  local geom = c:geometry()
  if geom.width > ws.width or geom.height > ws.height then
    awful.hooks.timer.register(0.01, scrollclient)
  end
  -- change border color
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_focus
  end
end)
-- }}}

-- {{{ hooks / unfocus
awful.hooks.unfocus.register(function (c)
  -- kill scrolling timer
  awful.hooks.timer.unregister(scrollclient)
  -- change border color
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_normal
  end
end)
-- }}}

-- {{{ hooks / marked
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)
-- }}}

-- {{{ hooks / unmarked 
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)
-- }}}

-- {{{ hooks / mouse_enter
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    -- if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
    --     and awful.client.focus.filter(c) then
    --     client.focus = c
    -- end
end)
-- }}}

-- {{{ hooks / manage DISABLED
awful.hooks.manage.register(function (c, startup)
    -- If we are not managing this application at startup,
    -- move it to the screen where the mouse is.
    -- We only do it for filtered windows (i.e. no dock, etc).
    if true then return end
    if not startup and awful.client.focus.filter(c) then
        c.screen = mouse.screen
    end

    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey, height = 16 })
    end
    -- Add mouse bindings
    c:buttons({
        button({ }, 1, function (c) client.focus = c; c:raise() end),
--        button({ modkey }, 1, awful.mouse.client.move),
--        button({ modkey }, 3, awful.mouse.client.resize)
	button({ "Mod1" }, 1, awful.mouse.client.move),
	button({ "Mod1" }, 3, awful.mouse.client.resize)
    })
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

    -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
    client.focus = c

    -- Set key bindings
    c:keys(clientkeys)

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)
    --
    
--    awful.placement.centered(c, c.transient_for)
--   awful.placement.no_offscreen(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.size_hints_honor = false
--    if c.type== "utility" then awful.client.floating.set( c, false) end
end)
-- }}}

-- {{{ hooks / arrange 
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.getname(awful.layout.get(screen))
    if layout and beautiful["layout_" ..layout] then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end)
-- }}}

--{{{ hooks / timers
-- awful.hooks.timer.register(1, hook_1s)
-- awful.hooks.timer.register(30, hook_1m)
-- awful.hooks.timer.register(3, hook_3s)
-- awful.hooks.timer.register(5, hook_5s)
-- awful.hooks.timer.register(600, hook_10m)
-- }}}

-- }}}

-- vim: foldmethod=marker:filetype=lua:expandtab:shiftwidth=2:tabstop=2:softtabstop=2:encoding=utf-8:textwidth=80
