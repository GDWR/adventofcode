#include <stdlib.h>
#include <ctype.h>
#include "stdio.h"
#include "string.h"
#include "stack.h"

typedef struct {
    int amount;
    int from;
    int to;
} Instruction;


Instruction parseInstructions(char *string) {
    string = strdup(string);
    Instruction i;

    strsep(&string, " ");
    i.amount = atoi(strsep(&string, " "));
    strsep(&string, " ");
    i.from = atoi(strsep(&string, " "));
    strsep(&string, " ");
    i.to = atoi(strsep(&string, " "));
    return i;
}

int main() {
    FILE *fp = fopen("../data", "r");
    if (fp == NULL) {
        printf("Couldn't open data file");
        return 1;
    }

    Stack *stacks = (Stack *) malloc(100 * sizeof(Stack));
    int instructionCur = 0;
    Instruction *instructions = (Instruction *) malloc(1000 * sizeof(Instruction));

    char *line;
    size_t len;
    ssize_t read;
    int readingStacks = 1;
    while ((read = getline(&line, &len, fp)) != -1) {
        if (read == 1) {
            readingStacks = 0;
            continue;
        }

        if (readingStacks) {
            for (int i = 0; i < read; ++i) {
                char v = line[1 + (i * 4)];
                if (v && !isdigit(v) && v != ' ') {
                    append(&stacks[i + 1], v);
                }
            }
        } else {
            instructions[instructionCur++] = parseInstructions(line);
        }
    }
    fclose(fp);


    for (int i = 0; i < instructionCur; ++i) {
        Instruction instruction = instructions[i];

        char toPush[instruction.amount];

        for (int j = 0; j < instruction.amount; ++j) {
            toPush[j] = pop(&stacks[instruction.from]);
        }

        for (int x = instruction.amount - 1; x >= 0; --x) {
            push(&stacks[instruction.to], toPush[x]);
        }

    }


    for (int i = 1; i < 10; ++i) {
        char v = pop(&stacks[i]);
        printf("%c", v);
    }

    return 0;
}