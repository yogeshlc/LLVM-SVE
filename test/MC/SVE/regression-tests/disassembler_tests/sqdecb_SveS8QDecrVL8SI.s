# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xf9,0x38,0x04
# CHECK: sqdecb  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0x38,0x04]
# CHECK-ERROR-NOT: sqdecb  x23, vl256, mul #9 
0x00,0xf8,0x30,0x04
# CHECK: sqdecb  x0, pow2 // encoding: [0x00,0xf8,0x30,0x04]
# CHECK-ERROR-NOT: sqdecb  x0, pow2 
0xff,0xfb,0x3f,0x04
# CHECK: sqdecb  xzr, all, mul #16 // encoding: [0xff,0xfb,0x3f,0x04]
# CHECK-ERROR-NOT: sqdecb  xzr, all, mul #16 
0x55,0xf9,0x35,0x04
# CHECK: sqdecb  x21, vl32, mul #6 // encoding: [0x55,0xf9,0x35,0x04]
# CHECK-ERROR-NOT: sqdecb  x21, vl32, mul #6 
