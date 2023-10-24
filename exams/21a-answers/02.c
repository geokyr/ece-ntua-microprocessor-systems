#include <avr/io.h>

int main(void){
    DDRC=0xFF; // output on PORTC
    DDRA=0x00; // input on PORTA
    
    while((PINA & 0x04) == 0){ // if not on floor go there (output down = 1)
        PORTC = 1;
    }
    
    while(1) {
        if ((PINA & 0x01) == 1){ // if M is pressed
            if ((PINA & 0x10) == 16){ // must move to floor
                while ((PINA & 0x04) != 4){
                    PORTC = 1; // if not on floor move till you are there
                }
            }
            if ((PINA & 0x08) == 8){ // must move to 1st floor
                while ((PINA & 0x02) != 2){
                    PORTC = 2; // if not on 1st floor move till you are there
                }
            }
        }
    }
}