# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xf3,0x6f,0x04
# CHECK: sqinch  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x6f,0x04]
# CHECK-ERROR-NOT: sqinch  xzr, wzr, all, mul #16 
0xb7,0xf1,0x68,0x04
# CHECK: sqinch  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x68,0x04]
# CHECK-ERROR-NOT: sqinch  x23, w23, vl256, mul #9 
0x55,0xf1,0x65,0x04
# CHECK: sqinch  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x65,0x04]
# CHECK-ERROR-NOT: sqinch  x21, w21, vl32, mul #6 
0x00,0xf0,0x60,0x04
# CHECK: sqinch  x0, w0, pow2 // encoding: [0x00,0xf0,0x60,0x04]
# CHECK-ERROR-NOT: sqinch  x0, w0, pow2 
