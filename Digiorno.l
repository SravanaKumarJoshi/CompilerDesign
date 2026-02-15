%{
#include <stdio.h>
%}

%%
[0-9]      { printf("Digit\n"); }
.          { printf("Not a Digit\n"); }
\n         { /* ignore newline */ }
%%

int main()
{
    printf("Enter a character:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
