# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf9,0x75,0x04
# CHECK: sqdech  x21, vl32, mul #6 // encoding: [0x55,0xf9,0x75,0x04]
# CHECK-ERROR-NOT: sqdech  x21, vl32, mul #6 
0xff,0xfb,0x7f,0x04
# CHECK: sqdech  xzr, all, mul #16 // encoding: [0xff,0xfb,0x7f,0x04]
# CHECK-ERROR-NOT: sqdech  xzr, all, mul #16 
0x00,0xf8,0x70,0x04
# CHECK: sqdech  x0, pow2 // encoding: [0x00,0xf8,0x70,0x04]
# CHECK-ERROR-NOT: sqdech  x0, pow2 
0xb7,0xf9,0x78,0x04
# CHECK: sqdech  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0x78,0x04]
# CHECK-ERROR-NOT: sqdech  x23, vl256, mul #9 
