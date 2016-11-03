# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xe5,0xf8,0x04
# CHECK: decd    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0xf8,0x04]
# CHECK-ERROR-NOT: decd    x23, vl256, mul #9 
0xff,0xe7,0xff,0x04
# CHECK: decd    xzr, all, mul #16 // encoding: [0xff,0xe7,0xff,0x04]
# CHECK-ERROR-NOT: decd    xzr, all, mul #16 
0x55,0xe5,0xf5,0x04
# CHECK: decd    x21, vl32, mul #6 // encoding: [0x55,0xe5,0xf5,0x04]
# CHECK-ERROR-NOT: decd    x21, vl32, mul #6 
0x00,0xe4,0xf0,0x04
# CHECK: decd    x0, pow2 // encoding: [0x00,0xe4,0xf0,0x04]
# CHECK-ERROR-NOT: decd    x0, pow2 
