# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xcf,0xef,0x04
# CHECK: uqdecd  z31.d, all, mul #16 // encoding: [0xff,0xcf,0xef,0x04]
# CHECK-ERROR-NOT: uqdecd  z31.d, all, mul #16 
0x55,0xcd,0xe5,0x04
# CHECK: uqdecd  z21.d, vl32, mul #6 // encoding: [0x55,0xcd,0xe5,0x04]
# CHECK-ERROR-NOT: uqdecd  z21.d, vl32, mul #6 
0xb7,0xcd,0xe8,0x04
# CHECK: uqdecd  z23.d, vl256, mul #9 // encoding: [0xb7,0xcd,0xe8,0x04]
# CHECK-ERROR-NOT: uqdecd  z23.d, vl256, mul #9 
0x00,0xcc,0xe0,0x04
# CHECK: uqdecd  z0.d, pow2 // encoding: [0x00,0xcc,0xe0,0x04]
# CHECK-ERROR-NOT: uqdecd  z0.d, pow2 
