# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xb9,0xe0,0x04
# CHECK: fexpa   z23.d, z13.d // encoding: [0xb7,0xb9,0xe0,0x04]
# CHECK-ERROR-NOT: fexpa   z23.d, z13.d 
0x00,0xb8,0xe0,0x04
# CHECK: fexpa   z0.d, z0.d // encoding: [0x00,0xb8,0xe0,0x04]
# CHECK-ERROR-NOT: fexpa   z0.d, z0.d 
0x55,0xb9,0xe0,0x04
# CHECK: fexpa   z21.d, z10.d // encoding: [0x55,0xb9,0xe0,0x04]
# CHECK-ERROR-NOT: fexpa   z21.d, z10.d 
0xff,0xbb,0xe0,0x04
# CHECK: fexpa   z31.d, z31.d // encoding: [0xff,0xbb,0xe0,0x04]
# CHECK-ERROR-NOT: fexpa   z31.d, z31.d 
