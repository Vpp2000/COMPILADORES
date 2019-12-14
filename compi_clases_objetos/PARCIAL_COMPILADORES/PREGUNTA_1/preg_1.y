%{
//incluimos librerias y cabeceras
#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include<stdlib.h>


char lexema[64];
void yyerror(char *);
int yylex();
%}

%token	MATRIZ

//x:=4;
//en la zona de produccion %% ... %% no debe haber comentarios sino genera errores

%%
lista : MATRIZ ;
%%

//codigo, scanner, parser
void yyerror(char *mgs){
	printf("error: %s",mgs);
}
int yylex(){	//esto retorna un token es decir numeros
//analizador lexico hecho a mano
	char c;
	int char_detector = 0;
	while(1){
		c=getchar();
		if(c=='\n') continue;
		if(isspace(c)) continue;
        if(c=='('){
        c=getchar();
		if(isdigit(c)){//verifica si es un nro. entero
		    int i = 0;
			int decimalFlag = 0;
			int decimal_detectado=0;
			int puntcom_Flag = 0;
			int puntcom_detectado = 0;
			int numero_detectado = 0; 
			do{

			    if (decimalFlag){decimal_detectado = 1;}
			    if (puntcom_Flag){puntcom_detectado = 1;}
			   
				lexema[i++]=c;
				c=getchar();

				if( c == ',' ){decimalFlag = 1;numero_detectado=0;}
			    if( c == ';' ){puntcom_Flag = 1;numero_detectado=0;}
				if(isdigit(c)){numero_detectado=1;decimalFlag = 0; decimal_detectado=0; puntcom_detectado = 0 ; puntcom_Flag = 0 ;}
			}while(isdigit(c) || (( c == ',' )&&(!decimal_detectado && !puntcom_detectado)) || (( c == ';' )&&(!puntcom_detectado && !decimal_detectado)));
					    if(c==')' && numero_detectado==1){	
		ungetc(c,stdin);//devuelve el caracter a la entrada estandar
		lexema[i]=0;
		return MATRIZ; //devuelve el token
		}
		}}
		
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
