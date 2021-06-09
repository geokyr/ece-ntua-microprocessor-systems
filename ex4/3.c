#include <avr/io.h>
unsigned char x = 0x01;				// default value for output

int main(void) {
	DDRC = 0x00;					// input
	DDRA = 0xFF;					// output
	
	PORTA = x;						// send lsb 1 to output
    while (1) {
		if(PINC == 0x01) {			// if SW0 is pressed
			while(PINC == 0x01) {}	// loop until it turns off
			if(x == 0x80) {			// if the led is on the leftmost
				x = 0x01;			// position, send it to lsb
			}
			else {
				x = x << 1;			// else shift output left once
			}
		}
		else if(PINC == 0x02) {		// if SW1 is pressed
			while(PINC == 0x02) {}	// loop until it turns off
			if(x == 0x01) {			// if the led is on the rightmost
				x = 0x80;			// position, send it to msb
			}
			else {
				x = x >> 1;			// else shift output right once
			}
		}
		else if(PINC == 0x04) {		// if SW2 is pressed
			while(PINC == 0x04) {}	// loop until it turns off
			x = 0x80;				// send led to msb
		}
		else if(PINC == 0x08) {		// if SW3 is pressed
			while(PINC == 0x08) {}	// loop until it turns off
			x = 0x01;				// send led to lsb
		}
		PORTA = x;					// send led to output
	}
}