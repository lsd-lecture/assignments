#include "crypto.h"
#include <string.h>

static int charToInt(char c) {
    return c - 'A' + 1;
}

static char intToChar(int i) {
    return (char) (i + 'A' - 1);
}

static int checkCharacters(const char* inputChars, const char* charSet, int error) {
    char* p = (char*) inputChars;

    while (*p) {
        if (strchr(charSet, *p) == NULL) {
            return error;
        }

        p++;
    }

    return 0;
}
 
static int checkKey(KEY key) {
    int check;

    if (strlen(key.chars) == 0) {
        return E_KEY_TOO_SHORT;
    }

    check = checkCharacters(key.chars, KEY_CHARACTERS, E_KEY_ILLEGAL_CHAR);

    if (check) {
        return check;
    }

    return 0;
}


static int xor(KEY key, const char* message, char* result) {
    int i, pos, check;
    size_t size;
    size_t keySize;

    check = checkKey(key);

    if (check) {
        return check;
    }

    size = strlen(message);
    keySize = strlen(key.chars);

    for (i = 0, pos = 0; i < size; i++) {
        int v1 = charToInt(message[i]);
        int v2 = charToInt(key.chars[pos]);

        result[i] = intToChar(v1 ^ v2);

        if (++pos >= keySize) {
            pos = 0;
        }
    }

    result[size] = '\0'; /* terminate string */

    return 0;
}

int encrypt(KEY key, const char* message, char* output) {
    int error = checkCharacters(message, MESSAGE_CHARACTERS, E_MESSAGE_ILLEGAL_CHAR);

    if (error) {
        return error;
    }

    return xor(key, message, output);
}

int decrypt(KEY key, const char* cyphertext, char* output) {
    int error = checkCharacters(cyphertext, CYPHER_CHARACTERS, E_CYPHER_ILLEGAL_CHAR);

    if (error) {
        return error;
    }

    return xor(key, cyphertext, output);
}
