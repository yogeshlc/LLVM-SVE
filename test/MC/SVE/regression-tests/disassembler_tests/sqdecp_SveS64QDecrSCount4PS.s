# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x89,0xea,0x25
# CHECK: sqdecp  x23, p13.d, w23 // encoding: [0xb7,0x89,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  x23, p13.d, w23 
0x00,0x88,0xea,0x25
# CHECK: sqdecp  x0, p0.d, w0 // encoding: [0x00,0x88,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  x0, p0.d, w0 
0xff,0x89,0xea,0x25
# CHECK: sqdecp  xzr, p15.d, wzr // encoding: [0xff,0x89,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  xzr, p15.d, wzr 
0x55,0x89,0xea,0x25
# CHECK: sqdecp  x21, p10.d, w21 // encoding: [0x55,0x89,0xea,0x25]
# CHECK-ERROR-NOT: sqdecp  x21, p10.d, w21 
