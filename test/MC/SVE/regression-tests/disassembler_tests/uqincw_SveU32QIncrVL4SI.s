# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xa5,0x04
# CHECK: uqincw  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xa5,0x04]
# CHECK-ERROR-NOT: uqincw  w21, vl32, mul #6 
0xb7,0xf5,0xa8,0x04
# CHECK: uqincw  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xa8,0x04]
# CHECK-ERROR-NOT: uqincw  w23, vl256, mul #9 
0x00,0xf4,0xa0,0x04
# CHECK: uqincw  w0, pow2 // encoding: [0x00,0xf4,0xa0,0x04]
# CHECK-ERROR-NOT: uqincw  w0, pow2 
0xff,0xf7,0xaf,0x04
# CHECK: uqincw  wzr, all, mul #16 // encoding: [0xff,0xf7,0xaf,0x04]
# CHECK-ERROR-NOT: uqincw  wzr, all, mul #16 
