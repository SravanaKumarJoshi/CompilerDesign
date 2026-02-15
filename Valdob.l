%{
#include <stdio.h>
#include <stdlib.h>

int day, month, year;
%}

DIGIT   [0-9]

%%
{DIGIT}{DIGIT}"/"{DIGIT}{DIGIT}"/"{DIGIT}{DIGIT}{DIGIT}{DIGIT}  {
        sscanf(yytext, "%d/%d/%d", &day, &month, &year);

        if(month < 1 || month > 12)
            printf("Invalid DOB\n");

        else if(day < 1 || day > 31)
            printf("Invalid DOB\n");

        else if((month == 4 || month == 6 || month == 9 || month == 11) && day > 30)
            printf("Invalid DOB\n");

        else if(month == 2 && day > 29)
            printf("Invalid DOB\n");

        else
            printf("Valid DOB\n");
}

.*   { printf("Invalid DOB\n"); }

%%

int main()
{
    printf("Enter DOB (DD/MM/YYYY):\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
