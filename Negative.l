%{
#include <stdio.h>
int pos = 0, neg = 0;
%}

DIGIT   [0-9]+

%%
"-"{DIGIT}    { neg++; }     /* negative number */
{DIGIT}       { pos++; }     /* positive number */
[ \t\n]+      ;              /* ignore spaces and newline */
.             ;              /* ignore other characters */
%%

int main()
{
    printf("Enter numbers:\n");
    yylex();

    printf("Positive numbers = %d\n", pos);
    printf("Negative numbers = %d\n", neg);

    return 0;
}

int yywrap()
{
    return 1;
}
