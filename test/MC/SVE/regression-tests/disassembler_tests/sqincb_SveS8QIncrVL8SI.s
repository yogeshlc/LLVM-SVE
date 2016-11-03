# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xf3,0x3f,0x04
# CHECK: sqincb  xzr, all, mul #16 // encoding: [0xff,0xf3,0x3f,0x04]
# CHECK-ERROR-NOT: sqincb  xzr, all, mul #16 
0x55,0xf1,0x35,0x04
# CHECK: sqincb  x21, vl32, mul #6 // encoding: [0x55,0xf1,0x35,0x04]
# CHECK-ERROR-NOT: sqincb  x21, vl32, mul #6 
0xb7,0xf1,0x38,0x04
# CHECK: sqincb  x23, vl256, mul #9 // encoding: [0xb7,0xf1,0x38,0x04]
# CHECK-ERROR-NOT: sqincb  x23, vl256, mul #9 
0x00,0xf0,0x30,0x04
# CHECK: sqincb  x0, pow2 // encoding: [0x00,0xf0,0x30,0x04]
# CHECK-ERROR-NOT: sqincb  x0, pow2 
