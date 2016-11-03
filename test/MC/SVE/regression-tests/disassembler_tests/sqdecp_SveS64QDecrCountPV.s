# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x81,0xea,0x25
# CHECK: sqdecp  z31.d, p15 // encoding: [0xff,0x81,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  z31.d, p15 
0x55,0x81,0xea,0x25
# CHECK: sqdecp  z21.d, p10 // encoding: [0x55,0x81,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  z21.d, p10 
0x00,0x80,0xea,0x25
# CHECK: sqdecp  z0.d, p0 // encoding: [0x00,0x80,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  z0.d, p0 
0xb7,0x81,0xea,0x25
# CHECK: sqdecp  z23.d, p13 // encoding: [0xb7,0x81,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  z23.d, p13 
