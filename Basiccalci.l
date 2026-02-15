%{
#include <stdio.h>
#include <stdlib.h>

int a, b;
%}

DIGIT   [0-9]+

%%
{DIGIT}"+"{DIGIT}   {
                        sscanf(yytext, "%d+%d", &a, &b);
                        printf("Result = %d\n", a + b);
                    }

{DIGIT}"-"{DIGIT}   {
                        sscanf(yytext, "%d-%d", &a, &b);
                        printf("Result = %d\n", a - b);
                    }

{DIGIT}"*"{DIGIT}   {
                        sscanf(yytext, "%d*%d", &a, &b);
                        printf("Result = %d\n", a * b);
                    }

{DIGIT}"/"{DIGIT}   {
                        sscanf(yytext, "%d/%d", &a, &b);
                        if(b == 0)
                            printf("Division by zero error\n");
                        else
                            printf("Result = %d\n", a / b);
                    }

\n      { /* ignore newline */ }

.       { printf("Invalid Expression\n"); }

%%

int main()
{
    printf("Enter expression:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
