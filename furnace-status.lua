local modem = peripheral.find("modem") or error("No modem attached", 0)
local monitor = peripheral.find("monitor")

monitor.setTextScale(0.5)

while true do
  if modem.isOpen(11) then
    sleep(5)
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    monitor.clear()
    monitor.setCursorPos(3,1)
    monitor.write("Furnace 1")
    monitor.setCursorPos(4,2)
    monitor.write("Fill Lvl")
    monitor.setCursorPos(6,3)
    monitor.write(message)
    
    if message == 5.0 then
      monitor.setBackgroundColor(colors.orange)
    end
    if message == 0.0 then
      monitor.setBackgroundColor(colors.red)
    end
    
  else
    modem.open(11)
  end
end
