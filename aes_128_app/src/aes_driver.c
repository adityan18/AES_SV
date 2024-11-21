/*
 * aes_driver.c: AES Driver
 *
 * This driver can be configured to use the PL AES
 */

#include "aes_driver.h"
#include "xgpio.h"
#include "xparameters.h"

static XGpio AES_CTRL_EVENT_FLAGS; /* AES_CTRL AND EVENT FLAG: | DECRYPT_DONE |
                               ENCRYPT_DONE => GPIO 0 */

static XGpio KEY_IN_1_2; /* KEY IN WORD 1 WORD 2 => GPIO 1 */
static XGpio KEY_IN_3_4; /* KEY IN WORD 3 WORD 4 => GPIO 2 */

static XGpio TEXT_IN_1_2; /* TEXT IN WORD 1 WORD 2 => GPIO 3 */
static XGpio TEXT_IN_3_4; /* TEXT IN WORD 3 WORD 4 => GPIO 4 */

static XGpio TEXT_OUT_1_2; /* TEXT OUT WORD 1 WORD 2 => GPIO 5 */
static XGpio TEXT_OUT_3_4; /* TEXT OUT WORD 3 WORD 4 => GPIO 6 */

static uint8_t aes_gpio_Init(void);
static void aes_gpio_SetDir(void);

aes_driver_result_t aes_driver_Init(void) {

  aes_driver_result_t eResult = AES_DRIVER_SUCCESS;

  if (aes_gpio_Init() != 0u) {
    eResult = AES_DRIVER_FAILURE;
  }

  aes_gpio_SetDir();

  return eResult;
}

void aes_Encryption(uint32_t *ipKey, uint32_t *ipPlainText,
                    uint32_t *ipCipherText) {

  // Set enc_or_dec = 0, enable = 0
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1u, 0x0u);

  // Set Key 1 and Key 2
  uint32_t iKey1, iKey2;
  (void)memcpy(&iKey1, &ipKey[0u], 4u);
  (void)memcpy(&iKey2, &ipKey[1u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 1u, iKey1);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 2u, iKey2);

  // Set Key 3 and Key 4
  uint32_t iKey3, iKey4;
  (void)memcpy(&iKey3, &ipKey[2u], 4u);
  (void)memcpy(&iKey4, &ipKey[3u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 1u, iKey3);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 2u, iKey4);

  //   Set Text In 1 and Text In 2
  uint32_t iTextIn1, iTextIn2;
  (void)memcpy(&iTextIn1, &ipPlainText[0u], 4u);
  (void)memcpy(&iTextIn2, &ipPlainText[1u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 1u, iTextIn1);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 2u, iTextIn2);

  //   Set Text In 3 and Text In 4
  uint32_t iTextIn3, iTextIn4;
  (void)memcpy(&iTextIn3, &ipPlainText[2u], 4u);
  (void)memcpy(&iTextIn4, &ipPlainText[3u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 1u, iTextIn3);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 2u, iTextIn4);

  // Set Enable
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1, 0x3u);

  while ((XGpio_DiscreteRead(&AES_CTRL_EVENT_FLAGS, 2) & 0x1u) != 0x1u) {
    // Wait till encrypt done event flag is set;
  }

  ipCipherText[0] = XGpio_DiscreteRead(&TEXT_OUT_1_2, 1);
  ipCipherText[1] = XGpio_DiscreteRead(&TEXT_OUT_1_2, 2);
  ipCipherText[2] = XGpio_DiscreteRead(&TEXT_OUT_3_4, 1);
  ipCipherText[3] = XGpio_DiscreteRead(&TEXT_OUT_3_4, 2);
}

void aes_Decryption(uint32_t *ipKey, uint32_t *ipCipherText,
                    uint32_t *ipPlaintext) {
  // Set enc_or_dec = 1, enable = 0
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1u, 0x2u);

  // Set Key 1 and Key 2
  uint32_t iKey1, iKey2;
  (void)memcpy(&iKey1, &ipKey[0u], 4u);
  (void)memcpy(&iKey2, &ipKey[1u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 1u, iKey1);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 2u, iKey2);

  // Set Key 3 and Key 4
  uint32_t iKey3, iKey4;
  (void)memcpy(&iKey3, &ipKey[2u], 4u);
  (void)memcpy(&iKey4, &ipKey[3u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 1u, iKey3);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 2u, iKey4);

  //   Set Text In 1 and Text In 2
  uint32_t iTextIn1, iTextIn2;
  (void)memcpy(&iTextIn1, &ipCipherText[0u], 4u);
  (void)memcpy(&iTextIn2, &ipCipherText[1u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 1u, iTextIn1);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 2u, iTextIn2);

  //   Set Text In 3 and Text In 4
  uint32_t iTextIn3, iTextIn4;
  (void)memcpy(&iTextIn3, &ipCipherText[2u], 4u);
  (void)memcpy(&iTextIn4, &ipCipherText[3u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 1u, iTextIn3);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 2u, iTextIn4);

  // Set Enable
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1, 0x1u);

  while (((XGpio_DiscreteRead(&AES_CTRL_EVENT_FLAGS, 2) >> 1u) & 0x1u) !=
         0x1u) {
    // Wait till encrypt done event flag is set;
  }

  ipPlaintext[0] = XGpio_DiscreteRead(&TEXT_OUT_1_2, 1);
  ipPlaintext[1] = XGpio_DiscreteRead(&TEXT_OUT_1_2, 2);
  ipPlaintext[2] = XGpio_DiscreteRead(&TEXT_OUT_3_4, 1);
  ipPlaintext[3] = XGpio_DiscreteRead(&TEXT_OUT_3_4, 2);
}

uint8_t aes_gpio_Init(void) {
  uint8_t iStatus = 0u;
  if (XGpio_Initialize(&AES_CTRL_EVENT_FLAGS, XPAR_XGPIO_0_BASEADDR) !=
      XST_SUCCESS) {
    iStatus |= (1u << 0u);
  } else if (XGpio_Initialize(&KEY_IN_1_2, XPAR_XGPIO_1_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 1u);
  } else if (XGpio_Initialize(&KEY_IN_3_4, XPAR_XGPIO_2_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 2u);
  } else if (XGpio_Initialize(&TEXT_IN_1_2, XPAR_XGPIO_3_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 3u);
  } else if (XGpio_Initialize(&TEXT_IN_3_4, XPAR_XGPIO_4_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 4u);
  } else if (XGpio_Initialize(&TEXT_OUT_1_2, XPAR_XGPIO_5_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 5u);
  } else if (XGpio_Initialize(&TEXT_OUT_3_4, XPAR_XGPIO_6_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 6u);
  }
  return iStatus;
}

static void aes_gpio_SetDir(void) {
  XGpio_SetDataDirection(&AES_CTRL_EVENT_FLAGS, 1u, 0b1u);
  XGpio_SetDataDirection(&AES_CTRL_EVENT_FLAGS, 2u, 0b11u);

  XGpio_SetDataDirection(&KEY_IN_1_2, 1u, 0xFFFFFFFFu);
  XGpio_SetDataDirection(&KEY_IN_1_2, 2u, 0xFFFFFFFFu);

  XGpio_SetDataDirection(&KEY_IN_3_4, 1u, 0xFFFFFFFFu);
  XGpio_SetDataDirection(&KEY_IN_3_4, 2u, 0xFFFFFFFFu);

  XGpio_SetDataDirection(&TEXT_IN_1_2, 1u, 0xFFFFFFFFu);
  XGpio_SetDataDirection(&TEXT_IN_3_4, 2u, 0xFFFFFFFFu);

  XGpio_SetDataDirection(&TEXT_OUT_1_2, 1u, 0xFFFFFFFFu);
  XGpio_SetDataDirection(&TEXT_OUT_3_4, 2u, 0xFFFFFFFFu);
}