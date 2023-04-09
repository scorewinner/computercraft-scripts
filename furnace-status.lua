local modem = peripheral.find("modem") or error("No modem attached", 0)
local monitor = peripheral.find("monitor")
while true do
  if modem.isOpen(11) then
    sleep(5)
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write("Furnace 1")
    monitor.setCursorPos(2,1)
    monitor.write("Fill Lvl")
    monitor.setCursorPos(3,2)
    monitor.write(message)
  else
    modem.open(11)
  end
end
