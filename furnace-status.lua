local modem = peripheral.find("modem") or error("No modem attached", 0)
local monitor = peripheral.find("monitor")

monitor.setTextScale(0.5)
monitor.clear()
monitor.setCursorPos(4,1)
monitor.write("Furnace 1")
monitor.setCursorPos(4,2)
monitor.write("Fill Lvl")
monitor.setCursorPos(6,3)
monitor.write("loading")

while true do
  if modem.isOpen(11) then
    sleep(5)
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")

    if message == 15.0 then
      monitor.setBackgroundColor(colors.green)
    elseif message == 10.0 then
      monitor.setBackgroundColor(colors.yellow)
    elseif message == 5.0 then
      monitor.setBackgroundColor(colors.orange)
    elseif message == 0.0 then
      monitor.setBackgroundColor(colors.red)
    end
    monitor.clear()
    monitor.setCursorPos(4,1)
    monitor.write("Furnace 1")
    monitor.setCursorPos(4,2)
    monitor.write("Fill Lvl")
    monitor.setCursorPos(6,3)
    monitor.write(message)
    
    
    
  else
    modem.open(11)
  end
end
