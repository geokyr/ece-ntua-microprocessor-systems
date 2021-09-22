#include <mega16.h>

int main(void) {
    DDRA = 0x00;
    DDRC = 0xFF;
    char a1, a0, reset, in, out;
    int counter = 30;

    PORTC = 0x91;

    while(1) {
        in = PINA & 0x07;
        reset = in & 0x01;
        if(reset == 0x01) {
            counter = 30;
            PORTC = 0x91;
        }
        else {
            a0 = in & 0x02;
            a1 = in & 0x04;
            if (a0 != 0x02) {
                counter--;
                if(counter < 10) {
                    out = counter << 4;
                    out = out & 0xF0;
                }
                else {
                    out = 0x91;
                }
                PORTC = out;
            }
            else if(a1 != 0x04) {
                counter++;
                if(counter < 10) {
                    out = counter << 4;
                    out = out & 0xF0;
                }
                else {
                    out = 0x91;
                }
                PORTC = out;
            }
        }
    }
}