# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xe1,0xb5,0x04
# CHECK: incw    x21, vl32, mul #6 // encoding: [0x55,0xe1,0xb5,0x04]
# CHECK-ERROR-NOT: incw    x21, vl32, mul #6 
0xb7,0xe1,0xb8,0x04
# CHECK: incw    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0xb8,0x04]
# CHECK-ERROR-NOT: incw    x23, vl256, mul #9 
0xff,0xe3,0xbf,0x04
# CHECK: incw    xzr, all, mul #16 // encoding: [0xff,0xe3,0xbf,0x04]
# CHECK-ERROR-NOT: incw    xzr, all, mul #16 
0x00,0xe0,0xb0,0x04
# CHECK: incw    x0, pow2 // encoding: [0x00,0xe0,0xb0,0x04]
# CHECK-ERROR-NOT: incw    x0, pow2 
