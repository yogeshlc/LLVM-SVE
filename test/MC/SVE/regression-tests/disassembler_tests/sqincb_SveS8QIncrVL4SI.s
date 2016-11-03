# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf1,0x25,0x04
# CHECK: sqincb  x21, w21, vl32, mul #6 // encoding: [0x55,0xf1,0x25,0x04]
# CHECK-ERROR-NOT: sqincb  x21, w21, vl32, mul #6 
0xb7,0xf1,0x28,0x04
# CHECK: sqincb  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf1,0x28,0x04]
# CHECK-ERROR-NOT: sqincb  x23, w23, vl256, mul #9 
0xff,0xf3,0x2f,0x04
# CHECK: sqincb  xzr, wzr, all, mul #16 // encoding: [0xff,0xf3,0x2f,0x04]
# CHECK-ERROR-NOT: sqincb  xzr, wzr, all, mul #16 
0x00,0xf0,0x20,0x04
# CHECK: sqincb  x0, w0, pow2 // encoding: [0x00,0xf0,0x20,0x04]
# CHECK-ERROR-NOT: sqincb  x0, w0, pow2 
