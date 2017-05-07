# Serial interface for FPGA implementation of UART controlled stopwatch
import serial                   
PORT = 'COM4' 
BAUD = 9600
s = serial.Serial(PORT, BAUD)
s.flush()

def bitstring_to_bytes(sq):
    return int(sq, 2).to_bytes(len(sq) // 8, byteorder='big')

while(True):
	#Get User Input
	print('Input 8 Bits')
	c = input()
	#remove white space
	c = c.replace(" ", "")
	#add zeros on the right end if not at length 8
	while( len(c) != 8):
		c = '0' + c

	firstEight = c[0:8]
	print("Inputed bit value: ", firstEight )
	hexVal = bitstring_to_bytes(firstEight)
	bytesWritten = s.write(hexVal)
	print("Bytes Written:  ", bytesWritten)


