#pragma once

struct StackNode {
    char value;
    struct StackNode *next;
};

typedef struct {
    struct StackNode *head;
} Stack;

Stack stack_new();

void print_stack(Stack *stack);

void append(Stack *stack, char c);
void push(Stack *stack, char c);

char pop(Stack *stack);