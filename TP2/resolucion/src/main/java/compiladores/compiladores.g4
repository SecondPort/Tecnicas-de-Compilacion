grammar compiladores;

@header {
package compiladores;
}

fragment LETRA : [A-Za-z] ;
fragment DIGITO : [0-9] ;

PYC : ';' ;
PA  : '(' ;
PC  : ')' ;
LLA : '{' ;
LLC : '}' ;
ASIGN : '=' ;
COMA  : ',' ;
SUMA  : '+' ;
RESTA : '-' ;
MULT  : '*' ;
DIV   : '/' ;
MOD   : '%' ;
EQ : '==' ;

NUMERO : DIGITO+ ;
INT : 'int' ;
ID : (LETRA | '_')(LETRA | DIGITO | '_')* ;

WS : [ \t\n\r] -> skip ;

errorSintactico: 'Falta de un punto y coma'
               | 'Falta de apertura de paréntesis'
               | 'Formato incorrecto en lista de declaración de variables';

errorSemantico: 'Doble declaración del mismo identificador'
              | 'Uso de un identificador no declarado'
              | 'Uso de un identificador sin inicializar'
              | 'Identificador declarado pero no usado'
              | 'Tipos de datos incompatibles';

programa : instrucciones EOF ;

instrucciones : instruccion instrucciones
              |
              ;

instruccion : asignacion
            | declaracion
            | bloque
            ;

bloque : LLA instrucciones LLC ;

asignacion : ID ASIGN expresion PYC;

declaracion : INT ID inicializacion listaid PYC ;

inicializacion : ASIGN NUMERO
               |
               ;

listaid : COMA ID inicializacion listaid
        |
        ;

expresion : termino exp ;

exp : SUMA  termino exp
    | RESTA termino exp
    |
    ;

termino : factor term ;

term : MULT factor term
     | DIV  factor term
     | MOD  factor term
     |
     ;

factor : NUMERO
       | ID
       | PA expresion PC 
       ; 
