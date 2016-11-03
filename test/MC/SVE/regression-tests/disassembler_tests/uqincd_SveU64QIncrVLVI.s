# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc4,0xe0,0x04
# CHECK: uqincd  z0.d, pow2 // encoding: [0x00,0xc4,0xe0,0x04]
# CHECK-ERROR-NOT: uqincd  z0.d, pow2 
0x55,0xc5,0xe5,0x04
# CHECK: uqincd  z21.d, vl32, mul #6 // encoding: [0x55,0xc5,0xe5,0x04]
# CHECK-ERROR-NOT: uqincd  z21.d, vl32, mul #6 
0xb7,0xc5,0xe8,0x04
# CHECK: uqincd  z23.d, vl256, mul #9 // encoding: [0xb7,0xc5,0xe8,0x04]
# CHECK-ERROR-NOT: uqincd  z23.d, vl256, mul #9 
0xff,0xc7,0xef,0x04
# CHECK: uqincd  z31.d, all, mul #16 // encoding: [0xff,0xc7,0xef,0x04]
# CHECK-ERROR-NOT: uqincd  z31.d, all, mul #16 
