16.16. The lexical analyzer should ignore redundant spaces, tabs and new lines. It should also
ignore comments. Although the syntax specification states that identifiers can be
arbitrarily long, you may restrict the length to some reasonable value. Write a LEX
specification file to take input C program from a .c file and count t he number of
characters, number of lines &amp; number of words.

Input Source Program: (sample.c)
#include &lt;stdio.h&gt;
int main()
{
int number1, number2, sum;
printf(&quot;Enter two integers: &quot;);
scanf(&quot;%d %d&quot;, &amp;number1, &amp;number2);
sum = number1 + number2;
printf(&quot;%d + %d = %d&quot;, number1, number2, sum);
return 0;
}

Lex Program:
%{
#include <stdio.h>

int characters = 0;
int words = 0;
int lines = 0;
%}

%%
"//".*                    ;    /* ignore single-line comments */
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*"*"+"/" ; /* ignore multi-line comments */

[ \t]+                    ;    /* ignore spaces and tabs */

\n                         { lines++; }

[A-Za-z_][A-Za-z0-9_]{0,31} { words++; characters += yyleng; }

[0-9]+                    { words++; characters += yyleng; }

.                          { characters++; }
%%

int main(int argc, char *argv[])
{
    if (argc > 1)
        yyin = fopen(argv[1], "r");

    yylex();

    printf("\nNumber of Characters = %d", characters);
    printf("\nNumber of Words      = %d", words);
    printf("\nNumber of Lines      = %d\n", lines);

    return 0;
}

int yywrap()
{
    return 1;
}


17. 17. Write a LEX program to print all the constants in the given C source program file.

Input Source Program: (sample.c)
#define PI 3.14
#include&lt;stdio.h&gt;
#include&lt;conio.h&gt;
void main()
{
int a,b,c = 30;
printf(&quot;hello&quot;);
}

Lex Program:

%{
#include <stdio.h>
%}

%%
"//".*                  ;   /* Ignore single line comments */

[0-9]+"."[0-9]+         {
                            printf("Float Constant: %s\n", yytext);
                        }

[0-9]+                  {
                            printf("Integer Constant: %s\n", yytext);
                        }

\"[^\"]*\"              {
                            printf("String Constant: %s\n", yytext);
                        }

[ \t\n]+                ;   /* Ignore spaces */

.                       ;   /* Ignore other characters */
%%

int main(int argc, char *argv[])
{
    if(argc > 1)
        yyin = fopen(argv[1], "r");

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
18. Write a LEX program to count the number of Macros defined and header files included
in the C program.
Input Source Program: (sample.c)
#define PI 3.14
#include&lt;stdio.h&gt;
#include&lt;conio.h&gt;
void main()
{
int a,b,c = 30;
printf(&quot;hello&quot;);
}

Lex program:

  
19. Write a LEX program to print all HTML tags in the input file.
Input Source Program: (sample.html)
&lt;html&gt;
&lt;body&gt;
&lt;h1&gt;My First Heading&lt;/h1&gt;
&lt;p&gt;My first paragraph.&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;

Lex Program:

%{
#include <stdio.h>
%}

%%
"<"[^>]+">"    {
                    printf("HTML Tag: %s\n", yytext);
               }

.|\n           ;   /* Ignore other content */
%%

int main(int argc, char *argv[])
{
    if(argc > 1)
        yyin = fopen(argv[1], "r");

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

20. Write a LEX program which adds line numbers to the given C program file and display
the same in the standard output.
Input Source Program: (sample.c)
#define PI 3.14
#include&lt;stdio.h&gt;
#include&lt;conio.h&gt;
void main()
{
int a,b,c = 30;
printf(&quot;hello&quot;);
}

Lex Program:
 
%{
#include <stdio.h>

int line = 1;
%}

%%
^.*\n    {
            printf("%d. %s", line++, yytext);
        }

.        ;
%%

int main(int argc, char *argv[])
{
    if(argc > 1)
        yyin = fopen(argv[1], "r");

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

21. Write a LEX specification count the number of characters, number of lines & number of words.

Lex Program:
 %{
#include <stdio.h>

int characters = 0;
int words = 0;
int lines = 0;
%}

%%
\n              { lines++; characters++; }

[ \t]+          { characters += yyleng; }

[a-zA-Z0-9]+    { words++; characters += yyleng; }

.               { characters++; }
%%

int main()
{
    printf("Enter text (Press Ctrl+Z to stop):\n");
    yylex();

    printf("\nNumber of Characters = %d", characters);
    printf("\nNumber of Words      = %d", words);
    printf("\nNumber of Lines      = %d\n", lines);

    return 0;
}

int yywrap()
{
    return 1;
}

22. Write a LEX program to count the number of comment lines in a given C program
and eliminate them and write into another file.
Input Source File: (input.c)
#include&lt;stdio.h&gt;
int main()
{
int a,b,c; /*varible declaration*/
printf(“enter two numbers”);
scanf(“%d %d”,&amp;a,&amp;b);
c=a+b;//adding two numbers
printf(“sum is %d”,c);
return 0;
}

Lex Program:

%{
#include <stdio.h>

int comment_count = 0;
FILE *fp;
%}

%%
"//".*      { 
                comment_count++; 
            }

"/*"([^*]|\n|(\*+([^*/]|\n)))*"*"+"/"  { 
                comment_count++; 
            }

.|\n        { 
                fputc(yytext[0], fp); 
            }
%%

int main(int argc, char *argv[])
{
    if(argc > 1)
        yyin = fopen(argv[1], "r");

    fp = fopen("output.c", "w");

    yylex();

    fclose(fp);

    printf("\nNumber of Comment Lines = %d\n", comment_count);
    printf("Comments removed and written to output.c\n");

    return 0;
}

int yywrap()
{
    return 1;
}

23. Write a LEX program to identify the capital words from the given input.

Lex Program:
  
%{
#include <stdio.h>
%}

%%
[A-Z]+        { printf("Capital Word: %s\n", yytext); }
[ \t\n]+      ;
.             ;
%%

int main()
{
    printf("Enter text:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

24. Write a LEX Program to check the email address is valid or not.

Lex Program:

%{
#include <stdio.h>
%}

%%
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com    { 
                                            printf("Valid Email\n"); 
                                         }

\n                                       { }

.                                        { 
                                            printf("Invalid Email\n"); 
                                         }
%%

int main()
{
    printf("Enter Email:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

25. Write a LEX Program to convert the substring abc to ABC from the given input string.

Lex Program:

%{
#include <stdio.h>
%}

%%
"abc"     { printf("ABC"); }
.|\n      { printf("%s", yytext); }
%%

int main()
{
    printf("Enter text:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

26. The Company ABC runs with employees with several departments. The Organization manager had all the mobile numbers of employees. Assume that
you are the manager and need to verify the valid mobile numbers because there may be some invalid numbers present. Implement a LEX program to check whether the mobile number is valid or not.

Lex Program:

%{
#include <stdio.h>
int valid = 0;
%}

%%
^[6-9][0-9]{9}$    { valid = 1; }
.*                 { valid = 0; }
%%

int main()
{
    printf("Enter Mobile Number:\n");
    yylex();

    if(valid)
        printf("Valid Mobile Number\n");
    else
        printf("Invalid Mobile Number\n");

    return 0;
}

int yywrap()
{
    return 1;
}

27. Implement Lexical Analyzer using LEX or FLEX (Fast Lexical Analyzer). The program should separate the tokens in the given C program and display with appropriate caption.
Input Source Program: (sample.c)
#include<stdio.h>
void main()
{
int a,b,c = 30;
printf(&quot;hello&quot;);
}

Lex program:
 
%{
#include <stdio.h>
%}

%%
"#include"            { printf("Preprocessor Directive : %s\n", yytext); }

"int"                 { printf("Keyword : %s\n", yytext); }
"void"                { printf("Keyword : %s\n", yytext); }
"return"              { printf("Keyword : %s\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]*   { printf("Identifier : %s\n", yytext); }

[0-9]+                { printf("Constant : %s\n", yytext); }

\"[^\"]*\"            { printf("String Literal : %s\n", yytext); }

"="                   { printf("Operator : %s\n", yytext); }
"+"                   { printf("Operator : %s\n", yytext); }
"-"                   { printf("Operator : %s\n", yytext); }
"*"                   { printf("Operator : %s\n", yytext); }
"/"                   { printf("Operator : %s\n", yytext); }

"("                   { printf("Special Symbol : %s\n", yytext); }
")"                   { printf("Special Symbol : %s\n", yytext); }
"{"                   { printf("Special Symbol : %s\n", yytext); }
"}"                   { printf("Special Symbol : %s\n", yytext); }
","                   { printf("Special Symbol : %s\n", yytext); }
";"                   { printf("Special Symbol : %s\n", yytext); }

[ \t\n]+              ;

.                     { printf("Unknown : %s\n", yytext); }
%%

int main(int argc, char *argv[])
{
    if(argc > 1)
        yyin = fopen(argv[1], "r");

    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

28. In a class, an English teacher was teaching the vowels and consonants to the students. She says “Vowel sounds allow the air to flow freely, causing the chin to drop noticeably, whilst consonant sounds are produced by restricting the air flow”. As a class activity the students are asked to identify the vowels and consonants in the given word/sentence and count the number of elements in each. Write an algorithm to help the student to count the number of vowels and consonants in the given sentence.

Lex Program:

29. Keywords are predefined, reserved words used in programming that have special meanings to the compiler. Keywords are part of the syntax and they cannot be used as an identifier. In general there are 32 keywords. The prime function of Lexical Analyser is token Generation. Among the 6 types of tokens, differentiating Keyword and Identifier is a challenging issue. Thus write a LEX program to separate keywords and identifiers.

Lex Program: 

%{
#include <stdio.h>
%}

%%
"int"        { printf("Keyword : %s\n", yytext); }
"float"      { printf("Keyword : %s\n", yytext); }
"char"       { printf("Keyword : %s\n", yytext); }
"void"       { printf("Keyword : %s\n", yytext); }
"if"         { printf("Keyword : %s\n", yytext); }
"else"       { printf("Keyword : %s\n", yytext); }
"return"     { printf("Keyword : %s\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]*   { printf("Identifier : %s\n", yytext); }

[ \t\n]+    ;
.           ;
%%

int main()
{
    printf("Enter C code:\n");
    yylex();
    return 0;
}

int yywrap(){ return 1; }

30. Write a LEX program to recognise numbers and words in a statement. Pooja is a small girl of age 3 always fond of games. Due to the pandemic, she was not allowed to play outside. So her mother designs a gaming event by showing a flash card. Pooja has to separate the numbers in one list and words in another list shown in the flash card.

Lex Program: 
%{
#include <stdio.h>
%}

%%
[0-9]+         { printf("Number : %s\n", yytext); }

[a-zA-Z]+      { printf("Word : %s\n", yytext); }

[ \t\n]+       ;

.              ;
%%

int main()
{
    printf("Enter statement:\n");
    yylex();
    return 0;
}

int yywrap(){ return 1; }

31. Write a LEX program to identify and count positive and negative numbers.

%{
#include <stdio.h>

int positive = 0;
int negative = 0;
%}

%%
"-"[0-9]+        { 
                    printf("Negative Number: %s\n", yytext);
                    negative++; 
                  }

[0-9]+           { 
                    printf("Positive Number: %s\n", yytext);
                    positive++; 
                  }

[ \t\n]+         ;   /* Ignore spaces */

.                ;   /* Ignore other characters */
%%

int main()
{
    printf("Enter numbers (Press Ctrl+Z to stop):\n");
    yylex();

    printf("\nTotal Positive Numbers = %d\n", positive);
    printf("Total Negative Numbers = %d\n", negative);

    return 0;
}

int yywrap()
{
    return 1;
}

32. A networking company wants to validate the URL for their clients. Write a LEX program to implement the same.

%{
#include <stdio.h>
%}

%%
https?"://"(www\.)?[a-zA-Z0-9]+(\.(com|org|net))   {
        printf("Valid URL: %s\n", yytext);
    }

.|\n   {
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

33. School management wants to validate DOB of all students. Write a LEX program to implement it.

%{
#include <stdio.h>
int valid=0;
%}

%%
^(0[1-9]|[12][0-9]|3[01])"/"(0[1-9]|1[0-2])"/"(19[0-9]{2}|20[0-9]{2})   {
        valid=1;
    }

.*   {
        valid=0;
    }
%%

int main()
{
    printf("Enter Date of Birth (DD/MM/YYYY):\n");
    yylex();
   
    if(valid)
        printf("Valid DOB\n");
    else
        printf("Invalid\n");

    return 0;
}

int yywrap()
{
    return 1;
}

34. Write a LEX program to check whether the given input is digit or not.

%{
#include <stdio.h>
%}

%%
[0-9]+      { 
                printf("It is a Digit: %s\n", yytext); 
            }

[a-zA-Z]+   { 
                printf("It is NOT a Digit: %s\n", yytext); 
            }

.           { 
                printf("It is NOT a Digit: %s\n", yytext); 
            }
%%

int main()
{
    printf("Enter input:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

35. A School student was asked to do basic mathematical operations. Implement a LEX program to implement the same.

%{
#include <stdio.h>
#include <stdlib.h>

int result = 0;
int num;
char op = '+';
%}

%%
[0-9]+  {
            num = atoi(yytext);

            if(op == '+')
                result += num;
            else if(op == '-')
                result -= num;
            else if(op == '*')
                result *= num;
            else if(op == '/')
                result /= num;
        }

"+"     { op = '+'; }
"-"     { op = '-'; }
"*"     { op = '*'; }
"/"     { op = '/'; }

[ \t\n]  ;   /* Ignore spaces */
.        ;   /* Ignore others */
%%

int main()
{
    printf("Enter expression (Example: 5+3*2):\n");
    yylex();

    printf("Result = %d\n", result);
    return 0;
}

int yywrap()
{
    return 1;
}

36. Write a LEX program to accept string starting with vowel.

%{
#include <stdio.h>
%}

%%
^[aeiouAEIOU][a-zA-Z]*    {
        printf("String starts with a Vowel: %s\n", yytext);
    }

^[^aeiouAEIOU\n]+         {
        printf("String does NOT start with a Vowel: %s\n", yytext);
    }

\n      ;
.       ;
%%

int main()
{
    printf("Enter a string:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}

37. Write a LEX program to find the length of the longest word.

%{
#include <stdio.h>
#include <string.h>

int max = 0;
char longest[100];
%}

%%
[a-zA-Z]+   {
                if(yyleng > max)
                {
                    max = yyleng;
                    strcpy(longest, yytext);
                }
            }

[ \t\n]+    ;   /* Ignore spaces and newlines */

.           ;   /* Ignore other characters */
%%

int main()
{
    printf("Enter text (Press Ctrl+Z to stop):\n");
    yylex();

    printf("\nLongest Word: %s", longest);
    printf("\nLength: %d\n", max);

    return 0;
}

int yywrap()
{
    return 1;
}


38. Write a LEX program to count the frequency of the given word in a given sentence.

%{
#include <stdio.h>
#include <string.h>

char word[50];
int count = 0;
%}

%%
[a-zA-Z]+   {
                if(strcmp(yytext, word) == 0)
                    count++;
            }

[ \t\n]+    ;   /* Ignore spaces */

.           ;   /* Ignore other characters */
%%

int main()
{
    printf("Enter word to search: ");
    scanf("%s", word);

    printf("Enter sentence (Press Ctrl+Z to stop):\n");
    yylex();

    printf("\nFrequency of '%s' = %d\n", word, count);

    return 0;
}

int yywrap()
{
    return 1;
}

39. Write a LEX code to replace a word with another word in a file.

%{
#include <stdio.h>
#include <string.h>

char oldword[50], newword[50];
%}

%%
[a-zA-Z]+  {
              if(strcmp(yytext, oldword) == 0)
                  printf("%s", newword);
              else
                  printf("%s", yytext);
           }

.|\n       { printf("%s", yytext); }
%%

int main(int argc, char *argv[])
{
    printf("Enter word to replace: ");
    scanf("%s", oldword);

    printf("Enter new word: ");
    scanf("%s", newword);

    printf("\nEnter text (Press Ctrl+Z to stop):\n");
    yylex();

    return 0;
}

int yywrap()
{
    return 1;
}

40. Write a LEX program to recognize a word and relational operator.

%{
#include <stdio.h>
%}

%%
"=="|"<="|">="|"!="|"<"|">"    {
        printf("Relational Operator: %s\n", yytext);
    }

[a-zA-Z]+   {
        printf("Word: %s\n", yytext);
    }

[ \t\n]+    ;

.           ;
%%

int main()
{
    printf("Enter input:\n");
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
