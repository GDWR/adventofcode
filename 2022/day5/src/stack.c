#include <malloc.h>
#include "stdio.h"
#include "stack.h"

Stack stack_new() {
    Stack s = {.head = NULL};
    return s;
}

void print_stack(Stack *stack) {
    struct StackNode *node = stack->head;

    printf("[");
    while (node != NULL) {
        printf(" %c ", node->value);
        node = node->next;
    }
    printf("]\n");
}

void push(Stack *stack, char c) {
    struct StackNode *newNode = NULL;
    newNode = (struct StackNode *) malloc(sizeof(struct StackNode));
    newNode->value = c;
    newNode->next = stack->head;
    stack->head = newNode;
}

void append(Stack *stack, char c) {
    struct StackNode *newNode = NULL;
    newNode = (struct StackNode *) malloc(sizeof(struct StackNode));
    newNode->value = c;

    if (stack->head == NULL) {
        newNode->next = stack->head;
        stack->head = newNode;
        return;
    }

    struct StackNode *curNode = stack->head;
    while (curNode->next != NULL){
        curNode = curNode->next;
    }
    curNode->next = newNode;

}

char pop(Stack *stack) {
    if (stack->head == NULL) {
        return NULL;
    }

    char out = stack->head->value;
    stack->head = stack->head->next;

    return out;
}