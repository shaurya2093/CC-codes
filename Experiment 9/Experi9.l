%{
#include<stdio.h>
#include "y.tab.h"
%}
%%
"for" {return FOR;}
"(" {return LP;}
")" {return RP;}
";" {return SC;}
[a-zA-Z_][a-zA-Z0-9_]* {return ID;}
"+"|"-"|"*"|"/"|"="|"=="|"<"|"<="|">"|">="|"&&"|"||" {return BOP;}
"++"|"--" {return UOP;}
[0-9]+ {return NUM;}
. {}
%%
int yywrap()
{
return 1;
}
