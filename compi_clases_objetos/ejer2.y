%{
//incluimos librerias y cabeceras
#include<stdio.h>
#include<ctype.h>
#include<string.h>
char lexema[64];
void yyerror(char *);
int yylex();
%}

%token	HEREDA NUM MAS MENOS DIV MULT POR PARI PARD SIGNO INT FLOAT STRING IGUAL ID TIPO MAYOR MENOR CLASS PERMISO LLAVEI LLAVED NEW COMA MAIN PUNTO

//x:=4;
//en la zona de produccion %% ... %% no debe haber comentarios sino genera errores

%%
codigo: clases clase_main;

clases: clases clase | ;
clase: PERMISO CLASS ID LLAVEI cuerpoClase LLAVED | PERMISO CLASS ID HEREDA ID LLAVEI  cuerpoClase LLAVED;
cuerpoClase: cuerpoClase declaracion | cuerpoClase asignacion | cuerpoClase objetoNew | cuerpoClase metodos | ;
metodos: PERMISO TIPO ID PARI argumentos PARD LLAVEI cuerpo LLAVED ;


clase_main: PERMISO CLASS ID LLAVEI cuerpoClase main LLAVED;

main: PERMISO TIPO MAIN PARI PARD LLAVEI cuerpo LLAVED ;
cuerpo: cuerpo declaracion |cuerpo asignacion |cuerpo objetoNew |cuerpo callMethod |;

argumentos: TIPO ID COMA argumentos| TIPO ID ; 
paramObjeto: valor COMA paramObjeto | valor |;


declaracion:TIPO ID IGUAL expresion ;
objetoNew: TIPO ID IGUAL NEW ID PARI paramObjeto PARD;
asignacion: ID IGUAL expresion;
callMethod: ID PUNTO ID PARI paramObjeto PARD;

expresion: expresion signo termino | termino;
signo: MAS | MENOS;
termino: valor muldiv termino | valor;
muldiv: MULT | DIV;
valor: ID| NUM | SIGNO NUM | PARI expresion PARD;



%%
//codigo, scanner, parser
void yyerror(char *mgs){
	printf("error: %s",mgs);
}
int yylex(){	//esto retorna un token es decir numeros
//analizador lexico hecho a mano
	char c;
	//int punto_detectado=0;
	while(1){
		c=getchar();
		if(c=='>') return MAYOR;
		if(c=='<') return MENOR;
		if(c=='+') return MAS;
		if(c=='-') return MENOS;
		if(c=='*') return MULT;
		if(c=='/') return DIV;
		if(c=='=') return IGUAL;		
		if(c=='(') return PARI;
		if(c==')') return PARD;
		if(c=='{') return LLAVEI;
		if(c=='}') return LLAVED;
		if(c==',') return COMA;
		if(c=='.') return PUNTO;
		if(c=='\n') continue;					
		if(isspace(c)) continue;
	
	    if(isalpha(c)){//verifica si es un nro. entero
			int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
			}while(isalnum(c));
		ungetc(c,stdin);//devuelve el caracter a la entrada estandar
		lexema[i]=0;
		if (strcasecmp(lexema,"void")==0| strcasecmp(lexema,"int")==0 | strcasecmp(lexema,"float")==0 | strcasecmp(lexema,"string")==0  ) return TIPO;
        if (strcasecmp(lexema,"public")==0) return PERMISO;
        if (strcasecmp(lexema,"protected")==0) return PERMISO;
        if (strcasecmp(lexema,"private")==0) return PERMISO;
        if (strcasecmp(lexema,"class")==0) return CLASS;  
        if (strcasecmp(lexema,"main")==0) return MAIN;
        if (strcasecmp(lexema,"hereda")==0)   return HEREDA;  
        if (strcasecmp(lexema,"nuevo")==0)  return NEW;
		return ID; // devuelve el token
		}	
		
		if(isdigit(c)){//verifica si es un nro. entero
			int i=0;
			do{
				lexema[i++]=c;
				c=getchar();
			}while(isdigit(c));
		ungetc(c,stdin);//devuelve el caracter a la entrada estandar
		lexema[i]=0;

		return NUM; // devuelve el token
		}
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
