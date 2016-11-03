# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xcb,0xaf,0x04
# CHECK: sqdecw  z31.s, all, mul #16 // encoding: [0xff,0xcb,0xaf,0x04]
# CHECK-ERROR-NOT: sqdecw  z31.s, all, mul #16 
0x55,0xc9,0xa5,0x04
# CHECK: sqdecw  z21.s, vl32, mul #6 // encoding: [0x55,0xc9,0xa5,0x04]
# CHECK-ERROR-NOT: sqdecw  z21.s, vl32, mul #6 
0xb7,0xc9,0xa8,0x04
# CHECK: sqdecw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc9,0xa8,0x04]
# CHECK-ERROR-NOT: sqdecw  z23.s, vl256, mul #9 
0x00,0xc8,0xa0,0x04
# CHECK: sqdecw  z0.s, pow2 // encoding: [0x00,0xc8,0xa0,0x04]
# CHECK-ERROR-NOT: sqdecw  z0.s, pow2 
