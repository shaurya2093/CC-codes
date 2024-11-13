%{
#include<stdio.h>
extern int yylex();
int yyerror(const char *s);
%}

%token IF ELSE LP RP SC ID NUM UOP BOP LB RB

%%

program: statement
       ;

statement: IF LP expression RP LB statement RB
         { printf("Valid 'if' statement detected\n"); }
       | IF LP expression RP LB statement RB ELSE LB statement RB
         { printf("Valid 'if-else' statement detected\n"); }
       | IF LP expression RP LB statement RB ELSE IF LP expression RP LB statement RB ELSE LB statement RB
         { printf("Valid 'if-else-if-else' statement detected\n"); }
       ;

expression: ID
          | NUM
          | ID BOP ID
          | ID BOP NUM
          | ID UOP
          | UOP ID
          ;

%%

int main()
{
    yyparse();
    return 0;
}

int yyerror(const char *s)
{
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
