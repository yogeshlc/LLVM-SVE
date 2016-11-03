# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xf4,0xe0,0x04
# CHECK: uqincd  w0, pow2 // encoding: [0x00,0xf4,0xe0,0x04]
# CHECK-ERROR-NOT: uqincd  w0, pow2 
0xb7,0xf5,0xe8,0x04
# CHECK: uqincd  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0xe8,0x04]
# CHECK-ERROR-NOT: uqincd  w23, vl256, mul #9 
0x55,0xf5,0xe5,0x04
# CHECK: uqincd  w21, vl32, mul #6 // encoding: [0x55,0xf5,0xe5,0x04]
# CHECK-ERROR-NOT: uqincd  w21, vl32, mul #6 
0xff,0xf7,0xef,0x04
# CHECK: uqincd  wzr, all, mul #16 // encoding: [0xff,0xf7,0xef,0x04]
# CHECK-ERROR-NOT: uqincd  wzr, all, mul #16 
