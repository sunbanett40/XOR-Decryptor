/*
Project:    XOR decrypter
Author:     Joseph Butterworth
License:    This work is licensed under the Creative Commons Attribution-ShareAlike License.
            View this license at https://creativecommons.org/licenses/
*/

#include <stdio.h>

/*
o = 0 1111 = 15
i = 0 1001 = 9
y = 1 1001 = 25
t = 1 0100 = 20
m = 0 1101 = 13
m = 0 1101 = 13
v = 1 0110 = 22
k = 0 1011 = 11
*/

unsigned int encrypted[8] = {15, 9, 25, 20, 13, 13, 22, 11};
unsigned int decrypted[8];

int main()
{
    for (unsigned int key = 0; key < 32; key++)
    {
        printf("%2d: ", key);
        for (int j = 0; j < 8; j++)
        {
            decrypted[j] = encrypted[j] ^ key;
            printf("%c", (decrypted[j]+64));
        }
        printf("\n");
    }
}