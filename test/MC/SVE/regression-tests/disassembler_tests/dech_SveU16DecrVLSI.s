# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xe7,0x7f,0x04
# CHECK: dech    xzr, all, mul #16 // encoding: [0xff,0xe7,0x7f,0x04]
# CHECK-ERROR-NOT: dech    xzr, all, mul #16 
0x55,0xe5,0x75,0x04
# CHECK: dech    x21, vl32, mul #6 // encoding: [0x55,0xe5,0x75,0x04]
# CHECK-ERROR-NOT: dech    x21, vl32, mul #6 
0x00,0xe4,0x70,0x04
# CHECK: dech    x0, pow2 // encoding: [0x00,0xe4,0x70,0x04]
# CHECK-ERROR-NOT: dech    x0, pow2 
0xb7,0xe5,0x78,0x04
# CHECK: dech    x23, vl256, mul #9 // encoding: [0xb7,0xe5,0x78,0x04]
# CHECK-ERROR-NOT: dech    x23, vl256, mul #9 
