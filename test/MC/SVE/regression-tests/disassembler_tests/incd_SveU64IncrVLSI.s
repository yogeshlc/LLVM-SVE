# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xe3,0xff,0x04
# CHECK: incd    xzr, all, mul #16 // encoding: [0xff,0xe3,0xff,0x04]
# CHECK-ERROR-NOT: incd    xzr, all, mul #16 
0x00,0xe0,0xf0,0x04
# CHECK: incd    x0, pow2 // encoding: [0x00,0xe0,0xf0,0x04]
# CHECK-ERROR-NOT: incd    x0, pow2 
0x55,0xe1,0xf5,0x04
# CHECK: incd    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xf5,0x04]
# CHECK-ERROR-NOT: incd    x21, vl32, mul #6 
0xb7,0xe1,0xf8,0x04
# CHECK: incd    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xf8,0x04]
# CHECK-ERROR-NOT: incd    x23, vl256, mul #9 
