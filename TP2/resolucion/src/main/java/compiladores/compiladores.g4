grammar Compiladores;

@header {
package compiladores;
}

programa : instrucciones EOF ;

instrucciones : instruccion instrucciones
              | instruccion
              ;

instruccion : asignacion PYC
            | declaracion PYC
            | bloque
            ;

bloque : LLA instrucciones LLC ;

asignacion : ID ASIGN expresion ;

declaracion : INT listaVariables ;

listaVariables : variableInicializada listaVariablesAux ;

listaVariablesAux : COMA variableInicializada listaVariablesAux
                  | 
                  ;

variableInicializada : ID inicializacion ;

inicializacion : ASIGN NUMERO
               |
               ;

expresion : termino expAux ;

expAux : SUMA termino expAux
       | RESTA termino expAux
       | 
       ;

termino : factor termAux ;

termAux : MULT factor termAux
        | DIV factor termAux
        | MOD factor termAux
        |
        ;

factor : NUMERO
       | ID
       | PA expresion PC
       ;

// Tokens
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
INT : 'int' ;
ID : (LETRA | '_')(LETRA | DIGITO | '_')* ;
NUMERO : DIGITO+ ;
WS : [ \t\n\r] -> skip ;

fragment LETRA : [A-Za-z] ;
fragment DIGITO : [0-9] ;
