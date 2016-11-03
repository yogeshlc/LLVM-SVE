# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xb9,0xa0,0x04
# CHECK: fexpa   z23.s, z13.s // encoding: [0xb7,0xb9,0xa0,0x04]
# CHECK-ERROR-NOT: fexpa   z23.s, z13.s 
0x00,0xb8,0xa0,0x04
# CHECK: fexpa   z0.s, z0.s // encoding: [0x00,0xb8,0xa0,0x04]
# CHECK-ERROR-NOT: fexpa   z0.s, z0.s 
0xff,0xbb,0xa0,0x04
# CHECK: fexpa   z31.s, z31.s // encoding: [0xff,0xbb,0xa0,0x04]
# CHECK-ERROR-NOT: fexpa   z31.s, z31.s 
0x55,0xb9,0xa0,0x04
# CHECK: fexpa   z21.s, z10.s // encoding: [0x55,0xb9,0xa0,0x04]
# CHECK-ERROR-NOT: fexpa   z21.s, z10.s 
