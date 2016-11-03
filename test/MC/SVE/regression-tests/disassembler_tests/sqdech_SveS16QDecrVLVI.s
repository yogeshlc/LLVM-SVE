# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xcb,0x6f,0x04
# CHECK: sqdech  z31.h, all, mul #16 // encoding: [0xff,0xcb,0x6f,0x04]
# CHECK-ERROR-NOT: sqdech  z31.h, all, mul #16 
0x00,0xc8,0x60,0x04
# CHECK: sqdech  z0.h, pow2 // encoding: [0x00,0xc8,0x60,0x04]
# CHECK-ERROR-NOT: sqdech  z0.h, pow2 
0xb7,0xc9,0x68,0x04
# CHECK: sqdech  z23.h, vl256, mul #9 // encoding: [0xb7,0xc9,0x68,0x04]
# CHECK-ERROR-NOT: sqdech  z23.h, vl256, mul #9 
0x55,0xc9,0x65,0x04
# CHECK: sqdech  z21.h, vl32, mul #6 // encoding: [0x55,0xc9,0x65,0x04]
# CHECK-ERROR-NOT: sqdech  z21.h, vl32, mul #6 
