# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xc7,0x6f,0x04
# CHECK: uqinch  z31.h, all, mul #16 // encoding: [0xff,0xc7,0x6f,0x04]
# CHECK-ERROR-NOT: uqinch  z31.h, all, mul #16 
0xb7,0xc5,0x68,0x04
# CHECK: uqinch  z23.h, vl256, mul #9 // encoding: [0xb7,0xc5,0x68,0x04]
# CHECK-ERROR-NOT: uqinch  z23.h, vl256, mul #9 
0x00,0xc4,0x60,0x04
# CHECK: uqinch  z0.h, pow2 // encoding: [0x00,0xc4,0x60,0x04]
# CHECK-ERROR-NOT: uqinch  z0.h, pow2 
0x55,0xc5,0x65,0x04
# CHECK: uqinch  z21.h, vl32, mul #6 // encoding: [0x55,0xc5,0x65,0x04]
# CHECK-ERROR-NOT: uqinch  z21.h, vl32, mul #6 
