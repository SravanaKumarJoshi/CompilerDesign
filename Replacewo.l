%{
#include <stdio.h>
%}

%%
cat     { printf("dog"); }   /* replace cat with dog */
.|\n    { printf("%s", yytext); }  /* print everything else */
%%

int main()
{
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}