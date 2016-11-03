# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0xb0,0x04
# CHECK: incw    z0.s, pow2 // encoding: [0x00,0xc0,0xb0,0x04]
# CHECK-ERROR-NOT: incw    z0.s, pow2 
0x55,0xc1,0xb5,0x04
# CHECK: incw    z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xb5,0x04]
# CHECK-ERROR-NOT: incw    z21.s, vl32, mul #6 
0xff,0xc3,0xbf,0x04
# CHECK: incw    z31.s, all, mul #16 // encoding: [0xff,0xc3,0xbf,0x04]
# CHECK-ERROR-NOT: incw    z31.s, all, mul #16 
0xb7,0xc1,0xb8,0x04
# CHECK: incw    z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xb8,0x04]
# CHECK-ERROR-NOT: incw    z23.s, vl256, mul #9 
