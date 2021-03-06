# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x81,0xa8,0x25
# CHECK: sqincp  z21.s, p10 // encoding: [0x55,0x81,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  z21.s, p10 
0xb7,0x81,0xa8,0x25
# CHECK: sqincp  z23.s, p13 // encoding: [0xb7,0x81,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  z23.s, p13 
0x00,0x80,0xa8,0x25
# CHECK: sqincp  z0.s, p0 // encoding: [0x00,0x80,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  z0.s, p0 
0xff,0x81,0xa8,0x25
# CHECK: sqincp  z31.s, p15 // encoding: [0xff,0x81,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  z31.s, p15 
