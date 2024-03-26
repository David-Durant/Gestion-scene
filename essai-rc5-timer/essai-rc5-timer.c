/*
 * essai-rc5-timer.c
 *
 * Created: 21/05/2018 11:03:25
 * Author: durant
 */

#include <mega8535.h>
#include <alcd.h>
#include <delay.h>
#include <interrupt.h>

char  v=0;

interrupt [TIM1_COMPA] void itTimer1(void) {
    v++;                
    PORTB= (4-(v%4));   // permet d avoir signal 1/4 sur bit 2
}

void main(void){
    DDRB='\x07';
    OCR1A=110;     // un entier 
    TCCR1B='\x08';      // WG12 a 1 pour mode timer CTC clear timer on compare
    TIMSK='\x10';       // OCIE1A a 1 pour interruption sur compare match OCR1A    
    sei();              // autorise les iT
    PORTB='\x01';       // met le bit 0 � 1
    TCCR1B='\x09';      // WG12 toujours a 1 ET demarre le timer avec CS=1 pas de diviseur
    while(1)
        ;    
}
