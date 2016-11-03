# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc4,0x70,0x04
# CHECK: dech    z0.h, pow2 // encoding: [0x00,0xc4,0x70,0x04]
# CHECK-ERROR-NOT: dech    z0.h, pow2 
0xff,0xc7,0x7f,0x04
# CHECK: dech    z31.h, all, mul #16 // encoding: [0xff,0xc7,0x7f,0x04]
# CHECK-ERROR-NOT: dech    z31.h, all, mul #16 
0x55,0xc5,0x75,0x04
# CHECK: dech    z21.h, vl32, mul #6 // encoding: [0x55,0xc5,0x75,0x04]
# CHECK-ERROR-NOT: dech    z21.h, vl32, mul #6 
0xb7,0xc5,0x78,0x04
# CHECK: dech    z23.h, vl256, mul #9 // encoding: [0xb7,0xc5,0x78,0x04]
# CHECK-ERROR-NOT: dech    z23.h, vl256, mul #9 
