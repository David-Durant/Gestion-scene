/*
 * essai-rc5-3.c
 *
 * Created: 30/04/2018 18:43:12
 * Author: durant
 */

#include <mega8535.h>
#include <alcd.h>
#include <delay.h>

int basculeBitValeur=0;

void rc5Bit1L( void ) {
    char i;
    
//  PORTB='\0';
    delay_us( 889 );
    for( i=0 ; i<32 ; i++ ) {   // 889us mesurees
          PORTB = 1;
          delay_us(7);          // 7us  mesurees
          PORTB = 0;
          delay_us(21);         // plus 21 us mesurees
    }  
}

void rc5Bit0L( void ) {
    char i;
    
    for( i=0 ; i<32 ; i++ ) {   // 889us mesurees 
          PORTB = 1;
          delay_us(7);          // 7us  mesurees
          PORTB = 0;
          delay_us(21);         // plus 21 us mesurees
    }  
    delay_us( 889 );
}

void rc5BasculeBit( void ) {
    char i;
    
    if( basculeBitValeur%2==0 ) {   // modulo a 2 = reste de la division par 2 : soit 0 soit 1 soit 0 soit 1 etc 
        delay_us( 889 );
        for( i=0 ; i<32 ; i++ ) {   // 889us mesurees
           PORTB = 1;
           delay_us(7);             // 7us  mesurees
           PORTB = 0;
           delay_us(21);            // plus 21 us mesurees
        }  
    } else {
        for( i=0 ; i<32 ; i++ ) {   // 889us mesurees 
              PORTB = 1;
              delay_us(7);          // 7us  mesurees
              PORTB = 0;
              delay_us(21);         // plus 21 us mesurees
        }  
        delay_us( 889 );
    }                               
    basculeBitValeur++;
}
    

// adresse = 0x14   pour lecteur CD
// adresse = 0x10   pour ampli

                  
void rc5CmdOn( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();    // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en d�cimal)
    rc5Bit0L();     // adresse bit 3
    rc5Bit1L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit0L();     // commande bit 5   commande=0x0C
    rc5Bit0L();     // commande bit 4
    rc5Bit1L();     // commande bit 3
    rc5Bit1L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit0L();     // commande bit 0
}

void rc5CmdOff( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();    // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en d�cimal)
    rc5Bit0L();     // adresse bit 3
    rc5Bit1L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit0L();     // commande bit 5   commande=0x0C
    rc5Bit0L();     // commande bit 4
    rc5Bit1L();     // commande bit 3
    rc5Bit1L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit0L();     // commande bit 0
}

void rc5CmdMute( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x10
    rc5Bit0L();     // adresse bit 3
    rc5Bit0L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit0L();     // commande bit 5   commande=0x0D
    rc5Bit0L();     // commande bit 4
    rc5Bit1L();     // commande bit 3
    rc5Bit1L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit1L();     // commande bit 0
}

void rc5CmdNomute( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x10
    rc5Bit0L();     // adresse bit 3
    rc5Bit0L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit0L();     // commande bit 5   commande=0x0D
    rc5Bit0L();     // commande bit 4
    rc5Bit1L();     // commande bit 3
    rc5Bit1L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit1L();     // commande bit 0
}

void rc5CmdSoundUp( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x10
    rc5Bit0L();     // adresse bit 3
    rc5Bit0L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit0L();     // commande bit 5   commande=0x10
    rc5Bit1L();     // commande bit 4
    rc5Bit0L();     // commande bit 3
    rc5Bit0L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit0L();     // commande bit 0
}

void rc5CmdSoundDown( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x10
    rc5Bit0L();     // adresse bit 3
    rc5Bit0L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit0L();     // commande bit 5   commande=0x11
    rc5Bit1L();     // commande bit 4
    rc5Bit0L();     // commande bit 3
    rc5Bit0L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit1L();     // commande bit 0
}

void rc5CmdPlay( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x14 
    rc5Bit0L();     // adresse bit 3
    rc5Bit1L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit1L();     // commande bit 5   commande=0x35
    rc5Bit1L();     // commande bit 4
    rc5Bit0L();     // commande bit 3
    rc5Bit1L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit1L();     // commande bit 0
}

void rc5CmdStop( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x14
    rc5Bit0L();     // adresse bit 3
    rc5Bit1L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit1L();     // commande bit 5   commande=0x36
    rc5Bit1L();     // commande bit 4
    rc5Bit0L();     // commande bit 3
    rc5Bit1L();     // commande bit 2
    rc5Bit1L();     // commande bit 1
    rc5Bit0L();     // commande bit 0
}

void rc5CmdPause( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x14 
    rc5Bit0L();     // adresse bit 3
    rc5Bit1L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit1L();     // commande bit 5   commande=0x35
    rc5Bit1L();     // commande bit 4
    rc5Bit0L();     // commande bit 3
    rc5Bit1L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit1L();     // commande bit 0
}

void rc5CmdNext(void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en d�cimal)
    rc5Bit0L();     // adresse bit 3
    rc5Bit1L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit1L();     // commande bit 5   commande=0x20
    rc5Bit0L();     // commande bit 4
    rc5Bit0L();     // commande bit 3
    rc5Bit0L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit0L();     // commande bit 0
}

void rc5CmdPrev( void ) {
    rc5Bit1L();     // bit start 1er
    rc5Bit1L();     // bit start 2sd
    rc5BasculeBit();     // bit commutation
    rc5Bit1L();     // adresse bit 4    adresse=0x14 (20 en d�cimal)
    rc5Bit0L();     // adresse bit 3
    rc5Bit1L();     // adresse bit 2
    rc5Bit0L();     // adresse bit 1
    rc5Bit0L();     // adresse bit 0
    rc5Bit1L();     // commande bit 5   commande=0x21
    rc5Bit0L();     // commande bit 4
    rc5Bit0L();     // commande bit 3
    rc5Bit0L();     // commande bit 2
    rc5Bit0L();     // commande bit 1
    rc5Bit1L();     // commande bit 0
}


void LCDinit( void ) {
    PORTA=0x00;         // lcd sur le port A
    DDRA=0xFF;      
    lcd_init(16);
    lcd_clear();
}

void main(void) {
    LCDinit();  
    
    DDRB = '\xFF';
    PORTB = '\0';
    lcd_putsf( "test rc5 cmd " );
    
    while (1) {
        rc5CmdOff();   
        delay_ms(4000);
    }
}