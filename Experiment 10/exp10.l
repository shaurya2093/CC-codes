%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
%}

%%
[0-9]+ {strcpy(yylval.n, yytext); return oprnd;}
[a-zA-Z_][a-zA-Z0-9_]* {strcpy(yylval.n, yytext); return oprnd;}
"+" {return PLUS;}
"*" {return MUL;}
"=" {return '=';}
[()] {return yytext[0];}
[ \t\n\r]+ {}
. {}
%%S

int yywrap()
{
  return 1;
}
