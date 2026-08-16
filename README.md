# AES-128

This repository contains the Vivado design and Vitis workspace for an AES-128 project.

## Project Layout

- `vivado_ws/`: Vivado project and exported XSA files.
- `vitis_ws/`: Vitis platform and application workspace.
- `generate_platform.py`: Script to generate the Vitis platform from an XSA.

## Vivado

The hardware design is in `vivado_ws/`.

Exported XSA files are available under:

- `vivado_ws/xsa/aes_128_xsa.xsa`
- `vivado_ws/xsa/aes_128_linux.xsa`

## Vitis

The Vitis application and platform artifacts are in `vitis_ws/`.

### Generate Platform

1. Source the Vitis environment:

   ```bash
   source /opt/Xilinx/Vitis/2024.2/settings64.sh
   ```

2. Run the platform generation script:

   ```bash
   vitis -s generate_platform.py --xsa vivado_ws/xsa/aes_128_xsa.xsa
   ```
