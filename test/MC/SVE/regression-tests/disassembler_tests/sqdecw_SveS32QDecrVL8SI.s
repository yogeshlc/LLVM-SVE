# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf9,0xb5,0x04
# CHECK: sqdecw  x21, vl32, mul #6 // encoding: [0x55,0xf9,0xb5,0x04]
# CHECK-ERROR-NOT: sqdecw  x21, vl32, mul #6 
0xb7,0xf9,0xb8,0x04
# CHECK: sqdecw  x23, vl256, mul #9 // encoding: [0xb7,0xf9,0xb8,0x04]
# CHECK-ERROR-NOT: sqdecw  x23, vl256, mul #9 
0x00,0xf8,0xb0,0x04
# CHECK: sqdecw  x0, pow2 // encoding: [0x00,0xf8,0xb0,0x04]
# CHECK-ERROR-NOT: sqdecw  x0, pow2 
0xff,0xfb,0xbf,0x04
# CHECK: sqdecw  xzr, all, mul #16 // encoding: [0xff,0xfb,0xbf,0x04]
# CHECK-ERROR-NOT: sqdecw  xzr, all, mul #16 
