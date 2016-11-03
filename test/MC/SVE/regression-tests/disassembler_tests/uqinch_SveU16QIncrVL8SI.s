# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0x75,0x04
# CHECK: uqinch  x21, vl32, mul #6 // encoding: [0x55,0xf5,0x75,0x04]
# CHECK-ERROR-NOT: uqinch  x21, vl32, mul #6 
0x00,0xf4,0x70,0x04
# CHECK: uqinch  x0, pow2 // encoding: [0x00,0xf4,0x70,0x04]
# CHECK-ERROR-NOT: uqinch  x0, pow2 
0xb7,0xf5,0x78,0x04
# CHECK: uqinch  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0x78,0x04]
# CHECK-ERROR-NOT: uqinch  x23, vl256, mul #9 
0xff,0xf7,0x7f,0x04
# CHECK: uqinch  xzr, all, mul #16 // encoding: [0xff,0xf7,0x7f,0x04]
# CHECK-ERROR-NOT: uqinch  xzr, all, mul #16 
