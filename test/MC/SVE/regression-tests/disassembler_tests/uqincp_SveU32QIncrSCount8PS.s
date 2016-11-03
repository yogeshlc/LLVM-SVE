# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x8d,0xa9,0x25
# CHECK: uqincp  x21, p10.s // encoding: [0x55,0x8d,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  x21, p10.s 
0xb7,0x8d,0xa9,0x25
# CHECK: uqincp  x23, p13.s // encoding: [0xb7,0x8d,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  x23, p13.s 
0xff,0x8d,0xa9,0x25
# CHECK: uqincp  xzr, p15.s // encoding: [0xff,0x8d,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  xzr, p15.s 
0x00,0x8c,0xa9,0x25
# CHECK: uqincp  x0, p0.s // encoding: [0x00,0x8c,0xa9,0x25]
# CHECK-ERROR-NOT: uqincp  x0, p0.s 
