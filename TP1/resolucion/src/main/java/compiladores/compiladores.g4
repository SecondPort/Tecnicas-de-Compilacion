grammar Compiladores;

@header {
package compiladores;
}

programa : instrucciones EOF ;

instrucciones : instruccion instrucciones
              | instruccion
              ;

instruccion : asignacion
            | declaracion
            | bloque
            | condicion
            | bucle
            | llamadaFunc PYC
            | retorno PYC
            ;

bloque : LLA instrucciones LLC ;

asignacion : ID ASIGN expresion PYC;

declaracion : tipo ID inicializacion listaid PYC
            | tipo ID PA argumentos PC bloque
            ;

tipo : INT
     | VOID
     ;

inicializacion : ASIGN expresion
               |
               ;

listaid : COMA ID inicializacion listaid
        | COMA ID inicializacion
        ;

condicion : IF PA condicion_expr PC bloque (ELSE bloque)?
          ;

bucle : FOR PA inicializacion PYC condicion_expr PYC asignacion PC bloque
      | WHILE PA condicion_expr PC bloque
      ;

llamadaFunc : ID PA argumentos_llamada PC ;

argumentos_llamada : expresion listaid
                   |
                   ;

argumentos : tipo ID listaid
           |
           ;

retorno : RETURN expresion?

expresion : condicion_expr
          | termino expresion_aux ;  

condicion_expr : termino (EQ | NEQ | LTE | GTE | LT | GT) termino
               | termino
               ;

expresion_aux : (SUMA | RESTA) termino expresion_aux
              |
              ;

termino : factor termino_aux ;

termino_aux : (MULT | DIV | MOD) factor termino_aux
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
EQ : '==' ;
NEQ : '!=' ;
LTE : '<=' ;
GTE : '>=' ;
LT  : '<' ;
GT  : '>' ;
ID : (LETRA | '_')(LETRA | DIGITO | '_')* ;
IF  : 'if' ;
ELSE: 'else' ;
FOR : 'for' ;
WHILE: 'while' ;
RETURN: 'return' ;
NUMERO : DIGITO+ ;
INT : 'int' ;
VOID: 'void' ;
WS : [ \t\n\r] -> skip ;

fragment LETRA : [A-Za-z] ;
fragment DIGITO : [0-9] ;
