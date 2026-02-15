%{
#include <stdio.h>
#include <string.h>

char words[100][50];
char numbers[100][50];
int w = 0, n = 0;
%}

WORD    [a-zA-Z]+
NUM     [0-9]+

%%
{WORD}      { strcpy(words[w++], yytext); }
{NUM}       { strcpy(numbers[n++], yytext); }
[ \t\n\.]+  ;     /* ignore spaces and dot */
.           ;     /* ignore other characters */
%%

int main()
{
    printf("Enter the statement:\n");
    yylex();

    printf("\nWords list:\n");
    for(int i = 0; i < w; i++)
        printf("%s\n", words[i]);

    printf("\nNumbers list:\n");
    for(int i = 0; i < n; i++)
        printf("%s\n", numbers[i]);

    return 0;
}

int yywrap()
{
    return 1;
}
