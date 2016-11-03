# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xc1,0xa5,0x04
# CHECK: sqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc1,0xa5,0x04]
# CHECK-ERROR-NOT: sqincw  z21.s, vl32, mul #6 
0x00,0xc0,0xa0,0x04
# CHECK: sqincw  z0.s, pow2 // encoding: [0x00,0xc0,0xa0,0x04]
# CHECK-ERROR-NOT: sqincw  z0.s, pow2 
0xff,0xc3,0xaf,0x04
# CHECK: sqincw  z31.s, all, mul #16 // encoding: [0xff,0xc3,0xaf,0x04]
# CHECK-ERROR-NOT: sqincw  z31.s, all, mul #16 
0xb7,0xc1,0xa8,0x04
# CHECK: sqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc1,0xa8,0x04]
# CHECK-ERROR-NOT: sqincw  z23.s, vl256, mul #9 
