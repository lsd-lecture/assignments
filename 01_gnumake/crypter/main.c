#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "crypto.h"
#include <errno.h>

#define BUFFER_SIZE 255

int main(int argc, char** argv) {

    /* encrypt or decrypt function */
    int (*func)(KEY, const char*, char*);

    if (argc < 2) {
        fprintf(stderr, "Usage: KEY [file name]\n\n");
        exit(1);
    }

    if (strstr(argv[0], "encrypt")) {
        func = encrypt;
    }
    else if (strstr(argv[0], "decrypt")) {
        func = decrypt;
    }
    else {
        func = encrypt;
    }

    KEY key;
    key.type = 1;
    key.chars = argv[1];
    FILE* f;

    if (argc == 3) {
        char *file = argv[2];
        if (!(f = fopen(file, "r"))) {
            fprintf(stderr, "Could not open %s: %s\n", file, strerror(errno));
            exit(1);
        }
    }
    else {
        f = stdin;
    }

    char buffer[BUFFER_SIZE];
    char result[BUFFER_SIZE];

    while (fgets(buffer, BUFFER_SIZE - 1, f)) {

        /* remove newline character at the end of line */
        char* lineEnd = strchr(buffer, 10);
        if (lineEnd) {
            *lineEnd = '\0';
        }

        /* encrypt or decrypt */
        int error = func(key, buffer, result);

        if (error) {
            fprintf(stderr, "Error: %d\n", error);
            exit(error);
        }

        printf("%s\n", result);
    }

    if (argc == 3) {
        fclose(f);
    }

    return 0;
}