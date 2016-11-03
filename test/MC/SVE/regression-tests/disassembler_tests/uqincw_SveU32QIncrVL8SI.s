# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xf4,0xb0,0x04
# CHECK: uqincw  x0, pow2 // encoding: [0x00,0xf4,0xb0,0x04]
# CHECK-ERROR-NOT: uqincw  x0, pow2 
0xb7,0xf5,0xb8,0x04
# CHECK: uqincw  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0xb8,0x04]
# CHECK-ERROR-NOT: uqincw  x23, vl256, mul #9 
0xff,0xf7,0xbf,0x04
# CHECK: uqincw  xzr, all, mul #16 // encoding: [0xff,0xf7,0xbf,0x04]
# CHECK-ERROR-NOT: uqincw  xzr, all, mul #16 
0x55,0xf5,0xb5,0x04
# CHECK: uqincw  x21, vl32, mul #6 // encoding: [0x55,0xf5,0xb5,0x04]
# CHECK-ERROR-NOT: uqincw  x21, vl32, mul #6 
