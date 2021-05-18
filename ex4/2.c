/*
 * lab2.c
 *
 * Created: 19-May-21 00:32:13
 * Author : george
 */ 

#include <avr/io.h>
unsigned char a, b, c, d, notc, temp, f0, f1, ans;

int main(void) {
	DDRA = 0x00;
	DDRB = 0xFF;
 
    while (1) {
		a = PINA & 0x01;
		b = PINA & 0x02;
		b = b >> 1;
		c = PINA & 0x04;
		c = c >> 2;
		d = PINA & 0x08;
		d = d >> 3;
	
		notc = c ^ 0x01;	
		temp = ((a & b & notc) | (c & d));
		
		f0 = temp ^ 0x01;
		f1 = (a | b) & (c | d);
		
		f1 = f1 << 1;
		ans = f0 + f1;
		PORTB = ans;
    }
}