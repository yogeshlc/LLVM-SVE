# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xf5,0x04
# CHECK: uqincd  x21, vl32, mul #6 // encoding: [0x55,0xf5,0xf5,0x04]
# CHECK-ERROR-NOT: uqincd  x21, vl32, mul #6 
0xb7,0xf5,0xf8,0x04
# CHECK: uqincd  x23, vl256, mul #9 // encoding: [0xb7,0xf5,0xf8,0x04]
# CHECK-ERROR-NOT: uqincd  x23, vl256, mul #9 
0xff,0xf7,0xff,0x04
# CHECK: uqincd  xzr, all, mul #16 // encoding: [0xff,0xf7,0xff,0x04]
# CHECK-ERROR-NOT: uqincd  xzr, all, mul #16 
0x00,0xf4,0xf0,0x04
# CHECK: uqincd  x0, pow2 // encoding: [0x00,0xf4,0xf0,0x04]
# CHECK-ERROR-NOT: uqincd  x0, pow2 
