# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xc7,0xaf,0x04
# CHECK: uqincw  z31.s, all, mul #16 // encoding: [0xff,0xc7,0xaf,0x04]
# CHECK-ERROR-NOT: uqincw  z31.s, all, mul #16 
0x55,0xc5,0xa5,0x04
# CHECK: uqincw  z21.s, vl32, mul #6 // encoding: [0x55,0xc5,0xa5,0x04]
# CHECK-ERROR-NOT: uqincw  z21.s, vl32, mul #6 
0x00,0xc4,0xa0,0x04
# CHECK: uqincw  z0.s, pow2 // encoding: [0x00,0xc4,0xa0,0x04]
# CHECK-ERROR-NOT: uqincw  z0.s, pow2 
0xb7,0xc5,0xa8,0x04
# CHECK: uqincw  z23.s, vl256, mul #9 // encoding: [0xb7,0xc5,0xa8,0x04]
# CHECK-ERROR-NOT: uqincw  z23.s, vl256, mul #9 
