/*
 * prog-final-V4.c
 *
 * Created: 05/05/2018 17:13:12
 * Author: m
 */
#include <mega8535.h>
#include <alcd.h>
#include <delay.h>
#include <stdlib.h>

#define MAXIRECU    30

char tabCaracteresRecus[MAXIRECU];
char aiToutRecu=0;
char compteurRecu=0;
char affValeur[20];

// dans dmx.c
void initDmx(void);
void couleurDmx(char,char,char);         
void lyreDmx(char,char);

// dans rc5.c
void rc5CmdOn(void);
void rc5CmdOff(void);
void rc5CmdMute(void);
void rc5CmdNomute(void);
void rc5CmdSoundUp(void);
void rc5CmdSoundDown(void);
void rc5CmdPlay(void);
void rc5CmdStop(void);
void rc5CmdPause(void);
void rc5CmdNext(void);
void rc5CmdPrev(void);

interrupt [USART_RXC] void itPortSerieReception(void) {
    char data;
      
    data=UDR;                   // recupere la donnee recue sur le port serie
   
        if( data=='#' ) {       // si recu le carac # alors fin du message entier
            aiToutRecu=1;
        }
    
    tabCaracteresRecus[compteurRecu]=data;
    compteurRecu++;
}

void initLCD( void ) {
    PORTA=0x00;         // lcd sur le port A
    DDRA=0xFF;      
    lcd_init(16);
    lcd_clear();
    lcd_putsf( "LCD OK" );      
}

void initPortSerieBluetooth( void ) {
    UCSRB='\x90';       // autorise les interruptions en reception
    UCSRC='\x86';       // 8 bits de donn�es, pas de parit�, 1 bit de stop
    UBRRH='\x00';
    UBRRL='\x67';       // 0x67 = 9600 Bauds pour 16MHz
}


void afficheOctet( char c ) {
    int valeur;
    
    valeur=c;
    itoa(valeur,affValeur);
    lcd_puts(affValeur);
}

void decodeCouleur( void ) {
    lcd_putsf( "C R" );
    afficheOctet( tabCaracteresRecus[1] );
    lcd_putsf( " V" );
    afficheOctet( tabCaracteresRecus[2] );
    lcd_putsf( " B" );
    afficheOctet( tabCaracteresRecus[3] );
    lcd_putsf( "\n" );

    couleurDmx( tabCaracteresRecus[1], tabCaracteresRecus[2], tabCaracteresRecus[3] ); 
    
    initPortSerieBluetooth();
}

void decodeLight( void ) {
    lcd_putsf( "L X" );
    afficheOctet( tabCaracteresRecus[1] );
    lcd_putsf( " Y" );
    afficheOctet( tabCaracteresRecus[2] );
    lcd_putsf( "\n" );
    
    lyreDmx( tabCaracteresRecus[1], tabCaracteresRecus[2] );
                
    initPortSerieBluetooth();
}

void decodeMusic( void ) {
    lcd_putsf( "M " );
    afficheOctet( tabCaracteresRecus[1] );
    lcd_putsf( " " );
    afficheOctet( tabCaracteresRecus[2] );
    lcd_putsf( "\n" );
    
    switch( tabCaracteresRecus[1] ) {
        case '\0' : if( tabCaracteresRecus[2]=='\0' )  {
                        lcd_putsf("Music OFF");
                        rc5CmdOff();         
        }
                    else {
                        lcd_putsf("Music ON");
                        rc5CmdOn();
                    } 
                    break;
        case '\1' : lcd_putsf("PLAY");
                    rc5CmdPlay();
                    break;
        case '\2' : lcd_putsf("PAUSE"); 
                    rc5CmdPause();
                    break;
        case '\3' : lcd_putsf("STOP"); 
                    rc5CmdStop();
                    break;
        case '\4' : lcd_putsf("PREV"); 
                    rc5CmdPrev();
                    break;
        case '\5' : lcd_putsf("NEXT");
                    rc5CmdNext();
                    break;
        case '\6' : if( tabCaracteresRecus[2]=='\0' ) {
                        lcd_putsf("Music UNMUTE");     
                        rc5CmdNomute();
        }
                    else {
                        lcd_putsf("Music MUTE");
                        rc5CmdMute();
                    }    
                    break;
        case '\7' : lcd_putsf("MOINS");   
                    rc5CmdSoundDown();
                    break;
        case '\8' : lcd_putsf("PLUS");
                    rc5CmdSoundUp();
                    break;                        
    };
}

void main(void) {
    
    initLCD();
    initDmx();
    initPortSerieBluetooth(); 
    
    #asm("sei")                             // autorise les interruptions
    
    while (1) { 
         if( aiToutRecu==1 ) {              // on a recu une commande depuis le smartphone ?
            #asm("cli")                     // interdit les interruptions pour eviter le remplissage avant affichage
            lcd_clear();
                
            switch(tabCaracteresRecus[0]) {
                case 'C' :  decodeCouleur();
                            break;
                case 'L' :  decodeLight();
                            break;
                case 'M' :  decodeMusic();
                            break;
            }
             
            compteurRecu=0;                 // on recommence a remplir le tab a partir du premier
            aiToutRecu=0;    
            #asm("sei")                     // re autorise les interruptions
        }
    }            
}
