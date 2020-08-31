#line 1 "C:/Users/Pitias/Desktop/PROJECTS/remote controlled motor/Remote Controlled motor.c"






sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4 at RD2_bit;
sbit LCD_D5 at RD3_bit;
sbit LCD_D6 at RD4_bit;
sbit LCD_D7 at RD5_bit;
sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD2_bit;
sbit LCD_D5_Direction at TRISD3_bit;
sbit LCD_D6_Direction at TRISD4_bit;
sbit LCD_D7_Direction at TRISD5_bit;


unsigned short ir_read, j, command=0;
short i = 0;
bit dr;
unsigned dt, dt0;
unsigned char *text, mytext[4];
void Interrupt(){

 delay_us(370);
 if(PORTB.F0==0){
 delay_us(889);
 if(PORTB.F0==1){
 delay_us(889);
 if(PORTB.F0==0){
 ir_read = 1;
 INTCON = 0;
 }}}
 INTF_bit = 0;
}
void display_results (){
 Lcd_Cmd(_LCD_CLEAR);
 text = "Direction:   " ;
 Lcd_Out(1, 2, text);
 if(dr == 0){
 text = "CW" ;
 Lcd_Out(1, 12, text);}
 else {
 text = "CCW" ;
 Lcd_Out(1, 12, text);}
 text = "Speed(%)=" ;
 Lcd_Out(2, 3, text);
 ByteToStr(i, mytext);
 Lcd_Out(2, 12, Ltrim(mytext));
 }
void main() {
 OPTION_REG = 0;
 PORTB = 0;
 TRISB = 1;
 PORTC = 0;
 TRISC = 0;
 PORTD = 0;
 TRISD = 0;
 PWM1_Init(10000);
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 text = "Remote" ;
 Lcd_Out(1, 6, text);
 text = "Controlled DCM" ;
 Lcd_Out(2, 2, text);
 delay_ms(1000);
 while(1){
ret:
INTCON = 0x90;
while(!ir_read);
ir_read = 0;
delay_us(12446);
for(j = 0; j < 6; j++)
{
if (PORTB.F0 == 0) command|= (1<<( 5 - j));
else command&=~(1<<(5 - j));
 delay_us(1778);
 }
 if (command == 12) {
 PORTC = 0;
 PWM1_Stop();
 Lcd_Cmd(_LCD_CLEAR);
 text = "Motor is OFF" ;
 Lcd_Out(1, 3, text);
 goto ret; }
 if (command == 16){ dr = 1;
 display_results();
 PORTC = 1;
 PWM1_Start();
 goto ret; }
 if (command == 17){ dr = 0;
 display_results();
 PORTC = 2;
 PWM1_Start();
 goto ret; }
 if (command == 32){ i++;
 if(i > 100) i = 100;}
 if (command == 33) {i--;
 if(i < 1) i = 0;}
 PWM1_Set_Duty(i * 255 / 100);
 PWM1_Start();
 display_results();
 }
}
