%{
#include <stdio.h>
%}

LETTER      [a-zA-Z]
DIGIT       [0-9]

%%
(http|https)"://"(www\.)?{LETTER}({LETTER}|{DIGIT})*"."{LETTER}{LETTER}{LETTER}?   {
        printf("Valid URL\n");
}

.*  {
        printf("Invalid URL\n");
}
%%

int main()
{
    printf("Enter URL:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
