%{
#include<stdio.h>
#include "y.tab.h"
%}

%%

"if"                { return IF; }
"else"              { return ELSE; }
"("                 { return LP; }
")"                 { return RP; }
"{"                 { return LB; }
"}"                 { return RB; }
";"                 { return SC; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
"+"|"-"|"*"|"/"|"="|"=="|"<"|"<="|">"|">="|"&&"|"||" { return BOP; }
"++"|"--"           { return UOP; }
[0-9]+              { return NUM; }
.                   { /* Ignore other characters */ }

%%

int yywrap()
{
    return 1;
}

