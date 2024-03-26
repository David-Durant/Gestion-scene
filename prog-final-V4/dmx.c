// dmx.c
// fonctions d'envoi sur le dmx

#include <mega8535.h>
#include <delay.h>

char tabEnvoiDmx[6];      // start-code + 24 canaux dmx

void initDmx( void ) {
    char i;
    DDRD ='\x02';
    PORTD='\x02';                   // pour dmx etat repos
    for( i=0; i<7; i++)           // raz tabEnvoiDmx
        tabEnvoiDmx[i]='\0';
}

void initPortSerieDmx( void ) {
    UCSRB='\x08';           // active transmission
    UCSRC='\x8E';           // asynchrone 2 bits de stop 8 bits de données
    UBRRH='\x00';
    UBRRL='\x03';           // 0x03 = 250000 Bauds
}

void debutTrameDmx( void ) {
    UCSRB='\x00';           // disable Tx port serie pour avoir controle port D
    PORTD='\x00';           // bit1 portD etait a 1 -> passe a 0
    delay_us(150);           // temps mini dmx break  
    PORTD='\x02';           // bit1 portD passe a 1
    delay_us(8);            // temps mini dmx mark after break   
                            // pret pour envoi serie
}  

void envoiTrameDmx( void ) {
    char i;   
    
    for( i=0; i<7; i++ ) {  
        while ( !( UCSRA & (1<<UDRE)) )     // port serie dispo pour envoi ?
            ;                               // non alors attend
        UDR = tabEnvoiDmx[i];               // oui alors charge la valeur dans port serie
    }
}
  
void finTrameDmx( void ) {
    UCSRB='\x00';           // arret port serie pour envoi
    PORTD='\x02';           // passe le bit1 a 1 pour etat repos dmx fin de trame     
}

void envoiDmx( void ) {     // show must go on
    debutTrameDmx();
    initPortSerieDmx();
    envoiTrameDmx();    
    finTrameDmx();
}

void couleurDmx( char rouge, char vert, char bleu) {
    tabEnvoiDmx[0]='\0';    // toujours 0 pour start code dmx
    tabEnvoiDmx[1]=rouge;
    tabEnvoiDmx[2]=vert;
    tabEnvoiDmx[3]=bleu;
    envoiDmx();    
}

void lyreDmx( char x, char y) {
    tabEnvoiDmx[0]='\0';    // toujours 0 pour start code dmx
    tabEnvoiDmx[4]=x;
    tabEnvoiDmx[5]=y;
    envoiDmx();    
}

