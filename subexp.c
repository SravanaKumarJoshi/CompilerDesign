#include <stdio.h>
#include <string.h>

#define MAX 10

int main() {
    char expr[MAX][20];
    char op1[MAX][10], op2[MAX][10], operator[MAX];
    int n, i, j;

    printf("Enter number of expressions: ");
    scanf("%d", &n);

    printf("Enter expressions in form: a=b+c\n");

    for(i = 0; i < n; i++) {
        scanf("%s", expr[i]);

        // Parse expression (a=b+c)
        op1[i][0] = expr[i][2];     // first operand
        op1[i][1] = '\0';

        operator[i] = expr[i][3];   // operator

        op2[i][0] = expr[i][4];     // second operand
        op2[i][1] = '\0';
    }

    printf("\nOptimized Code:\n");

    for(i = 0; i < n; i++) {
        int flag = 0;

        for(j = 0; j < i; j++) {
            if(strcmp(op1[i], op1[j]) == 0 &&
               strcmp(op2[i], op2[j]) == 0 &&
               operator[i] == operator[j]) {

                printf("%c = %c\n", expr[i][0], expr[j][0]);
                flag = 1;
                break;
            }
        }

        if(flag == 0) {
            printf("%s\n", expr[i]);
        }
    }

    return 0;
}
