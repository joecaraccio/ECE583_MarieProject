# Serial interface for FPGA implementation of UART controlled stopwatch
import serial                   
PORT = 'COM4' 
BAUD = 9600
s = serial.Serial(PORT, BAUD)
s.flush()

def bitstring_to_bytes(sq):
    return int(sq, 2).to_bytes(len(sq) // 8, byteorder='big')
testModeEnable = True
counter = 0
#Read one bit at a time
prevVar = 0
while(True):
	bytesWritten = s.read(1)
	if(prevVar != bytesWritten):
		counter = counter + 1
		print(bytesWritten)
		print('----------')
		prevVar = bytesWritten
		if(prevVar == b'\00'):
			print('good')


		if(testModeEnable):
			if(counter == 3):
				if(prevVar == b'\01'):
					print('MATCHED: b01')

			if(counter == 4):
				if(prevVar == b'\03'):
					print('MATCHED: b03')

			if(counter == 5):
				if(prevVar == b'\07'):
					print('MATCHED: b07')



