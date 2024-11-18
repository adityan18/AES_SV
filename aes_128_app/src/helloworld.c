/******************************************************************************
 * Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
 * SPDX-License-Identifier: MIT
 ******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include "platform.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

XGpio AES_CTRL_EVENT_FLAGS; /* AES_CTRL AND EVENT FLAG: | DECRYPT_DONE |
                               ENCRYPT_DONE => GPIO 0 */

XGpio KEY_IN_1_2; /* KEY IN WORD 1 WORD 2 => GPIO 1 */
XGpio KEY_IN_3_4; /* KEY IN WORD 3 WORD 4 => GPIO 2 */

XGpio TEXT_IN_1_2; /* TEXT IN WORD 1 WORD 2 => GPIO 3 */
XGpio TEXT_IN_3_4; /* TEXT IN WORD 3 WORD 4 => GPIO 4 */

XGpio TEXT_OUT_1_2; /* TEXT OUT WORD 1 WORD 2 => GPIO 5 */
XGpio TEXT_OUT_3_4; /* TEXT OUT WORD 3 WORD 4 => GPIO 6 */

uint32_t KEY[4u] = {0x2b28ab09u, 0x7eaef7cfu, 0x15d2154fu, 0x16a6883cu};

uint32_t TEXT_IN[4u] = {0x328831e0, 0x435a3137, 0xf6309807, 0xa88da234};

uint32_t TEXT_OUT[4u] = {0x3902dc19, 0x25dc116a, 0x8409850b, 0x1dfb9732};

uint32_t result[4u] = {0u};

static uint8_t gpio_init(void);

static uint8_t gpio_set_dir(void);

static void perform_encryption(void);
static void perform_decryption(void);

int main() {
  init_platform();

  print("Boot successfull\n\r");

  bool bIsSucccess = TRUE;

  if (gpio_init() != 0u) {
    bIsSucccess = FALSE;
  } else if (gpio_set_dir() != 0u) {
    bIsSucccess = FALSE;
  } else {
    bIsSucccess = TRUE;
  }

  if (bIsSucccess == TRUE) {
    perform_encryption();
    perform_decryption();
  }

  while (1)
    ;
  cleanup_platform();
  return 0;
}

static uint8_t gpio_init(void) {
  uint8_t iStatus = 0u;
  if (XGpio_Initialize(&AES_CTRL_EVENT_FLAGS, XPAR_XGPIO_0_BASEADDR) !=
      XST_SUCCESS) {
    iStatus |= (1u << 6u);
  } else if (XGpio_Initialize(&KEY_IN_1_2, XPAR_XGPIO_1_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 3u);
  } else if (XGpio_Initialize(&KEY_IN_3_4, XPAR_XGPIO_2_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 1u);
  } else if (XGpio_Initialize(&TEXT_IN_1_2, XPAR_XGPIO_3_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 0u);
  } else if (XGpio_Initialize(&TEXT_IN_3_4, XPAR_XGPIO_4_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 2u);
  } else if (XGpio_Initialize(&TEXT_OUT_1_2, XPAR_XGPIO_5_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 4u);
  } else if (XGpio_Initialize(&TEXT_OUT_3_4, XPAR_XGPIO_6_BASEADDR) !=
             XST_SUCCESS) {
    iStatus |= (1u << 5u);
  }
  return iStatus;
}

static uint8_t gpio_set_dir(void) {
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

  return 0u;
}

static void perform_encryption(void) {
  // Set enc_or_dec = 0, enable = 0
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1u, 0x0u);

  // Set Key 1 and Key 2
  uint32_t iKey1, iKey2;
  (void)memcpy(&iKey1, &KEY[0u], 4u);
  (void)memcpy(&iKey2, &KEY[1u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 1u, iKey1);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 2u, iKey2);

  // Set Key 3 and Key 4
  uint32_t iKey3, iKey4;
  (void)memcpy(&iKey3, &KEY[2u], 4u);
  (void)memcpy(&iKey4, &KEY[3u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 1u, iKey3);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 2u, iKey4);

  //   Set Text In 1 and Text In 2
  uint32_t iTextIn1, iTextIn2;
  (void)memcpy(&iTextIn1, &TEXT_IN[0u], 4u);
  (void)memcpy(&iTextIn2, &TEXT_IN[1u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 1u, iTextIn1);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 2u, iTextIn2);

  //   Set Text In 3 and Text In 4
  uint32_t iTextIn3, iTextIn4;
  (void)memcpy(&iTextIn3, &TEXT_IN[2u], 4u);
  (void)memcpy(&iTextIn4, &TEXT_IN[3u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 1u, iTextIn3);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 2u, iTextIn4);

  // Set Enable
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1, 0x3u);

  while ((XGpio_DiscreteRead(&AES_CTRL_EVENT_FLAGS, 2) & 0x1u) != 0x1u) {
    // Wait till encrypt done event flag is set;
  }

  uint32_t iTextOut1, iTextOut2, iTextOut3, iTextOut4;
  iTextOut1 = XGpio_DiscreteRead(&TEXT_OUT_1_2, 1);
  iTextOut2 = XGpio_DiscreteRead(&TEXT_OUT_1_2, 2);
  iTextOut3 = XGpio_DiscreteRead(&TEXT_OUT_3_4, 1);
  iTextOut4 = XGpio_DiscreteRead(&TEXT_OUT_3_4, 2);

  (void)memcpy(&result[0], &iTextOut1, 4u);
  (void)memcpy(&result[1], &iTextOut2, 4u);
  (void)memcpy(&result[2], &iTextOut3, 4u);
  (void)memcpy(&result[3], &iTextOut4, 4u);
}

static void perform_decryption(void) {
  // Set enc_or_dec = 1, enable = 0
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1u, 0x2u);

  // Set Key 1 and Key 2
  uint32_t iKey1, iKey2;
  (void)memcpy(&iKey1, &KEY[0u], 4u);
  (void)memcpy(&iKey2, &KEY[1u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 1u, iKey1);
  XGpio_DiscreteWrite(&KEY_IN_1_2, 2u, iKey2);

  // Set Key 3 and Key 4
  uint32_t iKey3, iKey4;
  (void)memcpy(&iKey3, &KEY[2u], 4u);
  (void)memcpy(&iKey4, &KEY[3u], 4u);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 1u, iKey3);
  XGpio_DiscreteWrite(&KEY_IN_3_4, 2u, iKey4);

  //   Set Text In 1 and Text In 2
  uint32_t iTextIn1, iTextIn2;
  (void)memcpy(&iTextIn1, &TEXT_OUT[0u], 4u);
  (void)memcpy(&iTextIn2, &TEXT_OUT[1u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 1u, iTextIn1);
  XGpio_DiscreteWrite(&TEXT_IN_1_2, 2u, iTextIn2);

  //   Set Text In 3 and Text In 4
  uint32_t iTextIn3, iTextIn4;
  (void)memcpy(&iTextIn3, &TEXT_OUT[2u], 4u);
  (void)memcpy(&iTextIn4, &TEXT_OUT[3u], 4u);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 1u, iTextIn3);
  XGpio_DiscreteWrite(&TEXT_IN_3_4, 2u, iTextIn4);

  // Set Enable
  XGpio_DiscreteWrite(&AES_CTRL_EVENT_FLAGS, 1, 0x1u);

  while (((XGpio_DiscreteRead(&AES_CTRL_EVENT_FLAGS, 2) >> 1u) & 0x1u) !=
         0x1u) {
    // Wait till encrypt done event flag is set;
  }

  uint32_t iTextOut1, iTextOut2, iTextOut3, iTextOut4;
  iTextOut1 = XGpio_DiscreteRead(&TEXT_OUT_1_2, 1);
  iTextOut2 = XGpio_DiscreteRead(&TEXT_OUT_1_2, 2);
  iTextOut3 = XGpio_DiscreteRead(&TEXT_OUT_3_4, 1);
  iTextOut4 = XGpio_DiscreteRead(&TEXT_OUT_3_4, 2);

  (void)memcpy(&result[0], &iTextOut1, 4u);
  (void)memcpy(&result[1], &iTextOut2, 4u);
  (void)memcpy(&result[2], &iTextOut3, 4u);
  (void)memcpy(&result[3], &iTextOut4, 4u);
}