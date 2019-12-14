%{
//incluimos librerias y cabeceras
#include<stdio.h>
#include<string.h>
#include<ctype.h>
#include<stdlib.h>


char lexema[64];
void yyerror(char *);
int yylex();
%}

%token ID NUM MAS MENOS MUL CORCHETE_ABRE_CODIGO CORCHETE_CIERRA_CODIGO CORCHETE_ABRE CORCHETE_CIERRA
%%

programa:programa '[' '[' expresion ']' ']' |;

expresion: expresion MAS valor | expresion MENOS valor | expresion MUL valor |valor ;
valor: NUM | ID | '(' expresion ')' | '[' expresion ']';


%% 

//codigo, scanner, parser
void yyerror(char *mgs){
	printf("error: %s", mgs);
}
int yylex(){ //esto retorna un token es decir numeros 
//analizador lexico hecho a mano
	char c;
	while(1){
		c=getchar();
		if(c=='\n') continue;
		if(isspace(c)) continue;
		if(c=='+') return MAS;
		if(c=='-') return MENOS;
		if(c=='X') return MUL;
			
		if(isalpha(c) && c!='X') {//verifica si es un caracter
			int i=0;
			do {
				lexema[i++]=c;
				c=getchar();
			}while(isalnum(c) && c !='X');
			
         	ungetc(c,stdin);//devuelve el caracter a la entrada estandar
		lexema[i]=0;
		return ID;//devuelve una palabra reservada
		}
		
		if(isdigit(c) && (c != '8') && (c != '9')){//verifica si es un nro. entero
			int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
			}while(isdigit(c) && (c != '8') && (c != '9'));
		ungetc(c,stdin);//devuelve el caracter a la entrada estandar
		lexema[i]=0;
		return NUM; //devuelve el token
		}
		
		return c;
	}
}

void main(){
//llamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico
//yyparse
	printf("Los numeros a operar deben estar separados en almenos un espacio\n");
	if(!yyparse())
		printf("cadena es valida\n");
	else
		printf("cadena invalida\n");
}
	
			
			
