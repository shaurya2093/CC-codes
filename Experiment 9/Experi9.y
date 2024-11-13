%{
#include<stdio.h>
extern int yylex();
int yyerror(const char *);
%}
%token FOR LP RP SC ID NUM UOP BOP
%%
P:S
;
S: FOR LP E SC E SC E RP 
{
printf("valid for loop detected\n");
}
;
E: ID | NUM | ID BOP ID | ID BOP NUM | ID UOP | UOP ID
;
%%
int main()
{
yyparse();
return 0;
}
int yyerror(const char *s){
fprintf(stderr, "Errror:%s\n",s);
return 0;
}
