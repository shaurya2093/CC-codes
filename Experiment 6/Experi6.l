%{
#include <stdio.h>
#include <stdlib.h>

int com_count = 0;
int edu_count = 0;
int org_count = 0;

FILE *com_file;
FILE *edu_file;
FILE *org_file;

%}

%%

[a-z0-9._%+-]+.com {
    fprintf(com_file, "%s\n", yytext);
    com_count++;
}

[a-z0-9._%+-]+.edu {
    fprintf(edu_file, "%s\n", yytext);
    edu_count++;
}

[a-z0-9._%+-]+.org {
    fprintf(org_file, "%s\n", yytext);
    org_count++;
}

.                   ;

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
FILE *links=fopen(argv[1], "r");
yyin=links;
    com_file = fopen("urls_com.txt", "w");
    edu_file = fopen("urls_edu.txt", "w");
    org_file = fopen("urls_org.txt", "w");

    if (!com_file || !edu_file || !org_file) {
        perror("Error opening output files");
        return 1;
    }
    yylex();

    printf(".com URLs: %d\n", com_count);
    printf(".edu URLs: %d\n", edu_count);
    printf(".org URLs: %d\n", org_count);

    fclose(com_file);
    fclose(edu_file);
    fclose(org_file);
   
    return 0;
}
