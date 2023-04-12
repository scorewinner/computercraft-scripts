local monitor = peripheral.find("monitor")

local function coloring(text, fg, bg)
	monitor.setTextColor(fg or colors.white)
	monitor.setBackgroundColor(bg or colors.blue)
	monitor.write(text)
end

local function make_section(name, x, y, w, h)
	for row = 1, h do
		monitor.setCursorPos(x, y + row - 1)
		local char = (row == 1 or row == h) and "\127" or " "
		colored("\127" .. string.rep(char, w - 2) .. "\127", colors.gray)
	end

	monitor.setCursorPos(x + 2, y)
	colored(" " .. name .. " ")

	return window.create(term.current(), x + 2, y + 2, w - 4, h - 4)
end




local function update_info()
	local prev_mon = term.redirect(info_window)

	term.clear()
	term.setCursorPos(1, 1)

	colored("REACTOR: ")
	colored(data.reactor_on and "ON " or "OFF", data.reactor_on and colors.green or colors.red)
	colored("  LEVER: ")
	colored(data.lever_on and "ON " or "OFF", data.lever_on and colors.green or colors.red)
	colored("  R. LIMIT: ")
	colored(string.format("%4.1f", data.reactor_burn_rate), colors.blue)
	colored("/", colors.lightGray)
	colored(string.format("%4.1f", data.reactor_max_burn_rate), colors.blue)

	term.setCursorPos(1, 3)

	colored("STATUS: ")
	if state == STATES.READY then
		colored("READY, flip lever to start", colors.blue)
	elseif state == STATES.RUNNING then
		colored("RUNNING, flip lever to stop", colors.green)
	elseif state == STATES.ESTOP and not all_rules_met() then
		colored("EMERGENCY STOP, safety rules violated", colors.red)
	elseif state == STATES.ESTOP then
		colored("EMERGENCY STOP, toggle lever to reset", colors.red)
	end -- STATES.UNKNOWN cases handled above

	term.redirect(prev_mon)
end




local function main_loop()
  
  local monitor = peripheral.find("monitor")

	-- Update info and rules windows
	pcall(update_info)

	sleep() -- Other calls should already yield, this is just in case
	return main_loop()
end

monitor.setPaletteColor(colors.black, 0x000000)
monitor.setPaletteColor(colors.gray, 0x343434)
monitor.setPaletteColor(colors.lightGray, 0xababab)
monitor.setPaletteColor(colors.red, 0xb80d0d)
monitor.setPaletteColor(colors.orange, 0xed5807)
monitor.setPaletteColor(colors.green, 0x06d66e)
monitor.setPaletteColor(colors.blue, 0x2c1894)

monitor.clear()
local width = monitor.getSize()
info_window = make_section("INFORMATION", 2, 2, width - 2, 7)

parallel.waitForAny(main_loop, function()
	os.pullEventRaw("terminate")
end)

os.reboot()
