%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
%}

digit [0-9]+

%%
{digit} { yylval.n = atoi(yytext); return oprnd; }

"+" { return '+'; }
"-" { return '-'; }
"*" { return '*'; }
"/" { return '/'; }

. {}

%%

int yywrap() {
 return 1;
 }
