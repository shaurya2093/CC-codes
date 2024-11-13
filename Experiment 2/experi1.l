%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Counters */
int token_count = 0;
int keyword_count = 0;
int comment_count = 0;
int argument_count = 0;

/* List of keywords */
char *keywords[] = {"if", "else", "while", "return", "int", "float", "char", "void"};
int num_keywords = sizeof(keywords) / sizeof(keywords[0]);

/* Helper function to check if a word is a keyword */
int is_keyword(char *word) {
    for (int i = 0; i < num_keywords; i++) {
        if (strcmp(word, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}

/* Define yywrap to avoid linker errors */
int yywrap(void) {
    return 1;  // Return 1 to indicate the end of input.
}
%}

%%
"//".*                   { comment_count++; }  /* Single line comment */
"/\\*"([^*]|\\*+[^*/])*"\\*/"  { comment_count++; }  /* Multi-line comment */
[a-zA-Z_][a-zA-Z0-9_]*   {
                            token_count++;
                            if (is_keyword(yytext)) {
                                keyword_count++;
                            }
                         }
\"[^\"]*\"               { argument_count++; token_count++; }  /* Double-quoted string */
[\(\)\{\};,]            { token_count++; }  /* Count punctuation as separate tokens */
[ \t\n]+                { /* Ignore whitespace */ }
.                       { token_count++; }  /* Catch-all for any other characters */
%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening file");
            exit(1);
        }
        yyin = file;
    }

    yylex();  // Start lexical analysis

    /* Print the results */
    printf("Tokens: %d\n", token_count);
    printf("Keywords: %d\n", keyword_count);
    printf("Comments: %d\n", comment_count);
    printf("Arguments: %d\n", argument_count);

    return 0;
}
