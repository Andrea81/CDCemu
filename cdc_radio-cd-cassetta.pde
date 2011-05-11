#include <WString.h>
#include <SoftwareSerial.h>

#define rxPin 2
#define txPin 3
unsigned long duration;
char someChar;
String comando;

int durations[] = {210, 840, 210, 210, 110, 110, 110, 110, 110, 110, 1035, 1035, 1035, 110};
int someChars[] = {0x78, 0x1B, 0xFF, 0x58, 0x7C, 0xFE, 0xA7, 0xC4, 0x58, 0x7C, 0x00, 0x00, 0x00, 0x58};
int delays[] = {6, 8, 6, 8, 30, 3, 5, 5, 3, 30, 5, 5, 7, 3, 3, 3, 3, 33, 3, 3, 3, 3, 3, 350, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4200, 3, 3, 3, 290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3, 290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3, 290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3 ,290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3 ,290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3, 290, 3, 3, 3, 3, 3, 3, 3, 3, 3, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3,  290, 3, 3, 3, 3, 3, 3, 3, 3, 3, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3};

int times[] = {0xFF, 0x7F, 0xFE, 0x3F, 0xFD };

// set up a new serial port
SoftwareSerial mySerial =  SoftwareSerial(rxPin, txPin);
//byte pinState = 0;


void setup()  {
  // define pin modes for tx, rx, led pins:
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
    // set the data rate for the SoftwareSerial port
  mySerial.begin(4800);
  Serial.begin(9600);  //serial HW
  //digitalWrite(txPin, LOW); //metto la linea tx a 0
  
}

void loop()
{
  RX();
 
  //Serial.print (someChar, HEX);
  switch (someChar) {
    
    case 0x06:     {
                   break;
                  }
    case 0x58:    {
                   //TX();
                   delay (23);
                   //digitalWrite(13,HIGH);
                   int i;
                    for (i = 0; i < 4; i = i + 1) {
                    delay (delays[i]);
                    duration= (durations[i]);
                    someChar= (someChars[i]);
                    TX();
                    }
                    //delay (5);
                    
                    for (i = 0; i < 5; i = i + 1) {
                    RX();
                    TX();
                    }
                    
                    
                    //mySerial.end;
                    mySerial.begin(9600);
                    
                    RX();
                    TX();
                    RX();
                    TX();
                    
                    //delay (30);
                    
                    for (i = 4; i < 9; i = i + 1) {
                    delay (delays[i]);
                    duration= (durations[i]);
                    someChar= (someChars[i]);
                    TX();
                    }
                    
                    delay(4);
                    
                     for (i = 0; i < 4; i = i + 1) {
                    RX();
                    TX();
                    }
                    
                    for (i = 9; i < 14; i = i + 1) {
                    delay (delays[i]);
                    duration= (durations[i]);
                    someChar= (someChars[i]);
                    TX();
                    }
                    
                    delay(1000);
                    
                    
                    for (i = 0; i < 9; i = i + 1) {
                    RX();
                    if (someChar=!0x58) {
                    TX();}
                    }
                    digitalWrite(13,HIGH);
                    
                    
                    
                    /*delay (3);
                    
                    for (i = 12; i < 17; i = i + 1) {
                    delay (delays[i]);
                    duration= (durations[i]);
                    someChar= (someChars[i]);
                    TX();
                    }*/
                    
                   
                    
                    //delay (5);
                    
                    int t;
                    do{
                    
                    for (t = 0; t < 4; t = t + 1) {
                    
                    duration= 210;
                    someChar= 0x7B;
                    TX();
                    delay(3);
                    duration= 2000;
                    someChar= 0x00;
                    TX();
                    delay(3); 
                    duration= 420;                     
                    someChar= (times[t]);
                    TX();
                    delay(3);
                    duration= 210;
                    someChar= 0x58;
                    TX();
                    delay(970);
                    }
                    t=0;
                    }  while (t<10);
                    
                    
                    
                    
                    

                   /*
                   
                   duration = 420;
                   someChar = 0x3C;
                   TX();
                   delay(4);
                   duration = 210;
                   someChar = 0xFB;
                   TX();
                   delay(4);
                   duration = 210;
                   someChar = 0xFC;
                   TX();
                   delay(4);
                   duration = 210;
                   someChar = 0x58;
                   TX();*/
                   break;
                  }
                 
    default:      {
                   TX();
                  } 
    }


}



void RX()        //ricevo
{
                 duration = pulseIn(rxPin, HIGH, 100000000);  //rileva lunghezza bit di start, timeout 100 secondi
                 if (duration < 1500) {
                                        someChar = mySerial.read();            //leggo bit - NB: la libreria è modificata e non attende lo start bit       
                                        }
                 else {
                        someChar = NULL;
                       }
}
     

      

void TX()
                  {
                  if (duration > 1900) {                      // se il bit di inizio è troppo lungo non scrivere dati
                                         delayMicroseconds(400);                     //simulo ritardo di risposta cdc
                                         digitalWrite(txPin, HIGH);                  //
                                         delayMicroseconds(duration);                //replico lo start bit di lunghezza corretta
                                         digitalWrite(txPin, LOW);
                                         //mySerial.print(someChar);                       //scrivo il byte
                                         }
                  else if (duration > 1500) {                      // se il bit di inizio è troppo lungo non scrivere dati
                                         delayMicroseconds(810);                     //simulo ritardo di risposta cdc
                                         digitalWrite(txPin, HIGH);                  //
                                         delayMicroseconds(duration);                //replico lo start bit di lunghezza corretta
                                         digitalWrite(txPin, LOW);
                                         //mySerial.print(someChar);                       //scrivo il byte
                                         }
                            
                  else {   
                                         //delayMicroseconds(180);                     //simulo ritardo di risposta cdc
                                         digitalWrite(txPin, HIGH);                  //
                                         delayMicroseconds(duration);                //replico lo start bit di lunghezza corretta
                                         digitalWrite(txPin, LOW);
                                         if (someChar!=0x00){
                                         mySerial.print(someChar);}
                                         }                   //
                }
 
  
  

