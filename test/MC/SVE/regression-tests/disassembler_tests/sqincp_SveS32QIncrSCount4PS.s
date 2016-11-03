# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x89,0xa8,0x25
# CHECK: sqincp  x21, p10.s, w21 // encoding: [0x55,0x89,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  x21, p10.s, w21 
0x00,0x88,0xa8,0x25
# CHECK: sqincp  x0, p0.s, w0 // encoding: [0x00,0x88,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  x0, p0.s, w0 
0xff,0x89,0xa8,0x25
# CHECK: sqincp  xzr, p15.s, wzr // encoding: [0xff,0x89,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  xzr, p15.s, wzr 
0xb7,0x89,0xa8,0x25
# CHECK: sqincp  x23, p13.s, w23 // encoding: [0xb7,0x89,0xa8,0x25]
# CHECK-ERROR-NOT: sqincp  x23, p13.s, w23 
