local modem = peripheral.find("modem") or error("No modem attached", 0)
while true do
  if modem.isOpen(11) then
    sleep(2)
    local redstoneInput = rs.getAnalogueInput("back")
    modem.transmit(11, 11, redstoneInput)
  else
    modem.open(11)
  end
end
