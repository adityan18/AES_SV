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

#include "aes_driver.h"
#include "platform.h"
#include "xil_printf.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

uint32_t KEY[4u] = {0x2b28ab09u, 0x7eaef7cfu, 0x15d2154fu, 0x16a6883cu};

uint32_t PLAIN_TEXT[4u] = {0x328831e0, 0x435a3137, 0xf6309807, 0xa88da234};

uint32_t CIPHER_TEXT[4u] = {0x3902dc19, 0x25dc116a, 0x8409850b, 0x1dfb9732};

int main() {
  init_platform();

  print("Boot successfull\n\r");

  bool bIsSucccess = TRUE;

  if (aes_driver_Init() != AES_DRIVER_SUCCESS) {
    bIsSucccess = FALSE;
  }

  if (bIsSucccess == TRUE) {
    uint32_t iaCipherText[4u] = {0u};
    aes_Encryption(&KEY[0u], &PLAIN_TEXT[0u], &iaCipherText[0u]);

    uint32_t iaPlainText[4u] = {0u};
    aes_Decryption(&KEY[0u], &CIPHER_TEXT[0u], &iaPlainText[0u]);

    if (memcmp(&PLAIN_TEXT, &iaPlainText, sizeof(iaPlainText)) != 0u) {
      bIsSucccess = false;
    } else if (memcmp(&CIPHER_TEXT, &iaCipherText, sizeof(iaCipherText)) !=
               0u) {
      bIsSucccess = false;
    }
  }

  while (1)
    ;
  cleanup_platform();
  return 0;
}
