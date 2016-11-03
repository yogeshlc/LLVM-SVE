# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xa9,0x25
# CHECK: uqincp  z0.s, p0 // encoding: [0x00,0x80,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  z0.s, p0 
0xb7,0x81,0xa9,0x25
# CHECK: uqincp  z23.s, p13 // encoding: [0xb7,0x81,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  z23.s, p13 
0xff,0x81,0xa9,0x25
# CHECK: uqincp  z31.s, p15 // encoding: [0xff,0x81,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  z31.s, p15 
0x55,0x81,0xa9,0x25
# CHECK: uqincp  z21.s, p10 // encoding: [0x55,0x81,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  z21.s, p10 
