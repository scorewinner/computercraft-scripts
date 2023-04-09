local modem = peripheral.find("modem") or error("No modem attached", 0)
while true do
  if modem.isOpen(11) then
    sleep(5)
  else
    modem.open(11)
  end
end
