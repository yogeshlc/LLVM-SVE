# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xf7,0x6f,0x04
# CHECK: uqinch  wzr, all, mul #16 // encoding: [0xff,0xf7,0x6f,0x04]
# CHECK-ERROR-NOT: uqinch  wzr, all, mul #16 
0x55,0xf5,0x65,0x04
# CHECK: uqinch  w21, vl32, mul #6 // encoding: [0x55,0xf5,0x65,0x04]
# CHECK-ERROR-NOT: uqinch  w21, vl32, mul #6 
0x00,0xf4,0x60,0x04
# CHECK: uqinch  w0, pow2 // encoding: [0x00,0xf4,0x60,0x04]
# CHECK-ERROR-NOT: uqinch  w0, pow2 
0xb7,0xf5,0x68,0x04
# CHECK: uqinch  w23, vl256, mul #9 // encoding: [0xb7,0xf5,0x68,0x04]
# CHECK-ERROR-NOT: uqinch  w23, vl256, mul #9 
