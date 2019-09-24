require 'muhkuh_cli_init'

local tempsensor = require 'tempsensor'

local i = 1
local temp		-- Measured temperature
local sensorCnt		-- Number of sensors connected to PC
local sensorNr		-- Number of sensor measuring temperature

function hexdump(strData, uiBytesPerRow)
    local uiCnt
    local uiByteCnt
    local aDump


    if not uiBytesPerRow then
	uiBytesPerRow = 16
    end

    uiByteCnt = 0
    for uiCnt=1,strData:len() do
	if uiByteCnt==0 then
	    aDump = { string.format("%08X :", uiCnt-1) }
	end
	table.insert(aDump, string.format(" %02X", strData:byte(uiCnt)))
	uiByteCnt = uiByteCnt + 1
	if uiByteCnt==uiBytesPerRow then
	    uiByteCnt = 0
	    print(table.concat(aDump))
	end
    end
    if uiByteCnt~=0 then
	print(table.concat(aDump))
    end
end

-- Open tempsensor
iResult = tempsensor.rawhid_open(1, 0x16C0, 0x0480, 0xFFAB, 0x0200)

if iResult <= 0 then
    print(string.format('%d tempsensor found', iResult))
else
    print(string.format('%d tempsensor found', iResult))
end

-- Read temperature
while i do
    iResult, buf = tempsensor.rawhid_recv(0, 64, 220);

    if iResult < 0 then
	print('Error reading tempsensor')
	tempsensor.rawhid_close(0)
    end

    if iResult == 64 then
	-- Dump 64byte
	--hexdump(buf)

	-- Get temp bytes 5 and 6 of 64byte string
	byte0, byte1 = string.byte(buf, 5, 6)
	temp = (byte0 + (byte1*255))/10

	-- Get Number of sensors connected to PC
	sensorCnt = string.byte(buf, 2)

	-- Get Number of sensor measuring temperature
	sensorNr = string.byte(buf, 1)

	print(string.format('Sensor nr %d of %d temp: %0.1f*C',sensorNr, sensorCnt, temp))
    end
end