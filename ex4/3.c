/*
 * lab3.c
 *
 * Created: 19-May-21 01:07:02
 * Author : george
 */ 

#include <avr/io.h>
unsigned char x = 1;

int main(void) {
	DDRC = 0x00;
	DDRA = 0xFF;
	
    while (1) {
		if(PINC == 0x01) {
			while(PINC == 0x01) {}
			if(x == 0x80) {
				x = 0x01;
			}
			else {
				x = x << 1;
			}
		}
		else if(PINC == 0x02) {
			while(PINC == 0x02) {}
			if(x == 0x01) {
				x = 0x80;
			}
			else {
				x = x >> 1;
			}
		}
		else if(PINC == 0x04) {
			while(PINC == 0x04) {}
			x = 0x80;
		}
		else if(PINC == 0x08) {
			while(PINC == 0x08) {}
			x = 0x01;
		}
		PORTA = x;
	}
}