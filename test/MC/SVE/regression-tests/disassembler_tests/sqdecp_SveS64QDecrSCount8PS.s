# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x8d,0xea,0x25
# CHECK: sqdecp  xzr, p15.d // encoding: [0xff,0x8d,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  xzr, p15.d 
0x55,0x8d,0xea,0x25
# CHECK: sqdecp  x21, p10.d // encoding: [0x55,0x8d,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  x21, p10.d 
0xb7,0x8d,0xea,0x25
# CHECK: sqdecp  x23, p13.d // encoding: [0xb7,0x8d,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  x23, p13.d 
0x00,0x8c,0xea,0x25
# CHECK: sqdecp  x0, p0.d // encoding: [0x00,0x8c,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  x0, p0.d 
