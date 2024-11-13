%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);

%}

%union {
    int num;
}

%token <num> NUMBER
%type <num> expr

%%

input:
    /* empty */
    | input line
;

line:
    expr '\n'    { printf("Result: %d\n", $1); }
    | '\n'       { /* ignore blank line */ }
;

expr:
    NUMBER            { $$ = $1; }
    | expr '+' NUMBER { $$ = $1 + $3; }
    | expr '-' NUMBER { $$ = $1 - $3; }
    | expr '*' NUMBER { $$ = $1 * $3; }
    | expr '/' NUMBER { if ($3 != 0) $$ = $1 / $3; else { yyerror("Division by zero"); $$ = 0; } }
    | expr '^' NUMBER { $$ = (int)pow($1, $3); }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions. Press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}
