# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xe1,0x78,0x04
# CHECK: inch    x23, vl256, mul #9 // encoding: [0xb7,0xe1,0x78,0x04]
# CHECK-ERROR-NOT: inch    x23, vl256, mul #9 
0x00,0xe0,0x70,0x04
# CHECK: inch    x0, pow2 // encoding: [0x00,0xe0,0x70,0x04]
# CHECK-ERROR-NOT: inch    x0, pow2 
0x55,0xe1,0x75,0x04
# CHECK: inch    x21, vl32, mul #6 // encoding: [0x55,0xe1,0x75,0x04]
# CHECK-ERROR-NOT: inch    x21, vl32, mul #6 
0xff,0xe3,0x7f,0x04
# CHECK: inch    xzr, all, mul #16 // encoding: [0xff,0xe3,0x7f,0x04]
# CHECK-ERROR-NOT: inch    xzr, all, mul #16 
