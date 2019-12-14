%{
//incluimos librerias y cabeceras
#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include<stdlib.h>


char lexema[64];
void yyerror(char *);
%}

%token	A B

//x:=4;
//en la zona de produccion %% ... %% no debe haber comentarios sino genera errores

%%

cadena: A cadena | B cadena | A | B;
%%

//codigo, scanner, parser
void yyerror(char *mgs){
	printf("error: %s",mgs);
}
int yylex(){	//esto retorna un token es decir numeros
//analizador lexico hecho a mano
	char c;

	while(1){
		c=getchar();
		if(c=='\n') continue;
		if(isspace(c)) continue;
        if(c=='a') return A;
        if(c=='b') return B;
			return c;

}
}


void main(){
//llamar al scaner o analizador lexico esto lo inicia el parser o analizador sintactico(yyparse)
//yyparse

	if(!yyparse())
		printf("cadena es valida\n");
	else
		printf("cadena invalida\n");
}






/*
		if(isalnum(c)){//verifica si es un nro. entero
			int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
				if(isalpha(c)){
					char_detector ++;	
				}
			}while(isalnum(c));
		if(strlen(lexema) == 8 && char_detector==0){
				printf("DNI\n");
				ungetc(c,stdin);//devuelve el caracter a la entrada estandar
				lexema[i]=0;
				return DNI; // devuelve el token
		}

		if(strlen(lexema) == 9 && char_detector==1){
				printf("CODIGO UNI\n");
				ungetc(c,stdin);//devuelve el caracter a la entrada estandar
				lexema[i]=0;
				return CODIGO; // devuelve el token
		}

*/
