local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(11)
