# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf9,0xa5,0x04
# CHECK: sqdecw  x21, w21, vl32, mul #6 // encoding: [0x55,0xf9,0xa5,0x04]
# CHECK-ERROR-NOT: sqdecw  x21, w21, vl32, mul #6 
0xb7,0xf9,0xa8,0x04
# CHECK: sqdecw  x23, w23, vl256, mul #9 // encoding: [0xb7,0xf9,0xa8,0x04]
# CHECK-ERROR-NOT: sqdecw  x23, w23, vl256, mul #9 
0xff,0xfb,0xaf,0x04
# CHECK: sqdecw  xzr, wzr, all, mul #16 // encoding: [0xff,0xfb,0xaf,0x04]
# CHECK-ERROR-NOT: sqdecw  xzr, wzr, all, mul #16 
0x00,0xf8,0xa0,0x04
# CHECK: sqdecw  x0, w0, pow2 // encoding: [0x00,0xf8,0xa0,0x04]
# CHECK-ERROR-NOT: sqdecw  x0, w0, pow2 
