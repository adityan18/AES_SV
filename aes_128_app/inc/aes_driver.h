/*
 * aes_driver.g: AES Driver Header
 *
 * This driver can be configured to use the PL AES
 */

#include <stdbool.h>
#include <stdio.h>
#include <string.h>

typedef enum { AES_DRIVER_SUCCESS, AES_DRIVER_FAILURE } aes_driver_result_t;

aes_driver_result_t aes_driver_Init(void);

void aes_Encryption(uint32_t *ipKey, uint32_t *ipPlainText,
                    uint32_t *ipCipherText);

void aes_Decryption(uint32_t *ipKey, uint32_t *ipCipherText,
                    uint32_t *ipPlainText);