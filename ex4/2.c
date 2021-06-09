#include <avr/io.h>
unsigned char A, B, C, D, notC, temp, F0, F1, ans;

int main(void) {
	DDRA = 0x00;			// input
	DDRB = 0xFF;			// output
 
    while (1) {
		A = PINA & 0x01;	// keep lsb only
		B = PINA & 0x02;	// keep 2nd lsb 
		B = B >> 1;			// and shift it to lsb
		C = PINA & 0x04;	// keep 3rd lsb
		C = C >> 2;			// and shift it to lsb
		D = PINA & 0x08;	// keep 4th lsb
		D = D >> 3;			// and shift it to lsb
	
		notC = C ^ 0x01;	// C complement
		temp = ((A & B & notC) | (C & D));
		
		F0 = temp ^ 0x01;	
		F1 = (A | B) & (C | D);
		
		F1 = F1 << 1;		// shift F1 to 2nd lsb
		ans = F0 + F1;		// add F1 and F0 for output
		PORTB = ans;		// send it to PORTB
    }
}