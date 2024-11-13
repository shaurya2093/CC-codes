%{
#include <stdio.h>
%}

%%

^[a-zA-Z][a-zA-Z0-9_.-]*@[a-zA-Z][a-zA-Z0-9_-]*\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$ {
    printf("Valid email address: %s\n", yytext); 
}

^[^\n]+$ {
    printf("Invalid email address: %s\n", yytext); 
}

\n {
    // Ignore newline characters
}

%%

int main() {
    printf("Enter an email address:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
