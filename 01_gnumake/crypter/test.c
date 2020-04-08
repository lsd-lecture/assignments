#include "crypto.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#define mu_assert(message, test) do { if (!(test)) return message; } while (0)
#define mu_run_test(test) do { char *message = test(); tests_run++; \
                                if (message) return message; } while (0)
int tests_run;

static char* testRoundtrip() {
    char* text = strdup("DIESXISTXEINXTEST");
    char* result = (char*) malloc(strlen(text) + 1);
    char* result2 = (char*) malloc(strlen(text) + 1);

    KEY key = { 1, "KEY" };
    encrypt(key, text, result);
    decrypt(key, result, result2);

    mu_assert("Roundtrip failed", strcmp(result2, text) == 0);
    return 0;
}

static char* testIllegalKey() {
    char* text = strdup("DIESXISTXEINXTEST");
    char* result = (char*) malloc(strlen(text) + 1);
    int error;

    KEY key1 = { 1, "" };
    error = encrypt(key1, text, result);
    mu_assert("Zero key not detected", error == E_KEY_TOO_SHORT);

    KEY key2 = { 1, "abcd"};
    error = encrypt(key2, text, result);
    mu_assert("Illegal char in key not detected: abcd", error == E_KEY_ILLEGAL_CHAR);

    KEY key3 = { 1, "@[\\]^_"};
    error = encrypt(key3, text, result);
    mu_assert("Illegal char in key not detected: @[\\]^_", error == E_KEY_ILLEGAL_CHAR);
    return 0;
}

static char* textIllegalMessage() {
    KEY key1 = { 1, "KEY" };
    int error = encrypt(key1, "ABCD AB", NULL);
    mu_assert("Illegal char in message not detected: ABCD AB", error == E_MESSAGE_ILLEGAL_CHAR);
    return 0;
}

static char* textIllegalCypher() {
    KEY key1 = { 1, "KEY" };
    int error = decrypt(key1, "ABCD AB", NULL);
    mu_assert("Illegal char in cypher not detected: ABCD AB", error == E_CYPHER_ILLEGAL_CHAR);
    return 0;
}

static char* allTests() {
    mu_run_test(testRoundtrip);
    mu_run_test(testIllegalKey);
    mu_run_test(textIllegalMessage);
    mu_run_test(textIllegalCypher);
    return 0;
}

int main() {
    char *result = allTests();

    if (result != 0) printf("%s\n", result);
    else             printf("ALL TESTS PASSED\n");

    printf("Tests run: %d\n", tests_run);

    return result != 0;
}
