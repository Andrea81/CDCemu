//Emulatore cd chager Blaupunkt per Fiat Stilo - Connect NAV+
//Andrea Colma 2010 - www.stiloclub.it

#include <WString.h>
#include <SoftwareSerial.h>

#define rxPin 2
#define txPin 3
unsigned long duration;
char someChar;
String comando;

int durations[] = {420, 210, 210, 210, 210, 1240, 420, 1000, 2000, 210, 600, 210, 210, 210, 210, 210, 210, 210, 1200, 210, 1000, 2000, 210, 210, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 210, 210, 420, 210, 210, 210, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 210, 210, 210, 1000, 210, 210, 210, 210, 210, 210, 210, 210, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 210, 210, 210, 1000, 210, 210, 210, 210, 210, 210, 210, 210, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 210, 210, 210, 1000, 210, 210, 210, 210, 210, 210, 210, 210, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 1200, 210, 210, 210, 1000, 210, 210, 210, 210, 210, 210, 210};
int someChars[] = {0x3C, 0xFB, 0xFC, 0x58, 0x7E, 0x07, 0x7D, 0x0F, 0x00, 0x58, 0x1E, 0xFF, 0x58, 0x7F, 0xFF, 0xFF, 0x58, 0x7E, 0x07, 0xFB, 0x0F, 0x00, 0x58, 0x7A, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x58, 0x7F, 0x7F, 0xFF, 0x58, 0x7A, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x58, 0x79, 0xFF, 0x0F, 0xDC, 0xF7, 0x58, 0x7F, 0xFE, 0xFF, 0x58, 0x7A, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x58, 0x79, 0xFF, 0x0F, 0xDC, 0xF7, 0x58, 0x7F, 0xFD, 0xFF, 0x58, 0x7A, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x58, 0x79, 0xFF, 0x0F, 0xDC, 0xF7, 0x58, 0x7F, 0xFF, 0xFF, 0x58, 0x7A, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x58, 0x79, 0xFF, 0x7A, 0x1A, 0x7B, 0x58, 0x7F, 0xFF, 0xFF, 0x58, 0x7A, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x58, 0x79, 0xFF, 0x7A, 0x1A, 0x7B, 0x58, 0x7B, 0x00, 0x0E, 0x58};
int delays[] = {33, 3, 3, 3, 30, 3, 3, 3, 3, 3, 30, 3, 3, 30, 3, 3, 3, 33, 3, 3, 3, 3, 3, 350, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4200, 3, 3, 3, 290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3, 290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3, 290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3 ,290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3 ,290, 4, 4, 4, 4, 4, 4, 4, 4, 4, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3, 290, 3, 3, 3, 3, 3, 3, 3, 3, 3, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3,  290, 3, 3, 3, 3, 3, 3, 3, 3, 3, 33, 3, 3, 3, 3, 3, 285, 3, 3, 3};

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
  digitalWrite(txPin, LOW); //metto la linea tx a 0
  
}

void loop()
{
  RX();
 
  //Serial.print (someChar, HEX);
  switch (someChar) {
    
    case 0x58:    {
                   break;
                  }
    case 0xEF:    {
                   TX();
                   digitalWrite(13,HIGH);
                   int i;
                    for (i = 0; i < 13; i = i + 1) {
                    delay (delays[i]);
                    duration= (durations[i]);
                    someChar= (someChars[i]);
                    TX();
                    }
                    delay (5);
                    RX();
                    TX();
                    RX();
                    TX();
                    
                    for (i = 13; i < 153; i = i + 1) {
                    delay (delays[i]);
                    duration= (durations[i]);
                    someChar= (someChars[i]);
                    TX();
                    }
                    
                    delay (1000);
                    
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
                    
                             

                   
                   
                   /*duration = 420;
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
                                         mySerial.print(someChar);
                                         }                   //
                }
 
  
  

