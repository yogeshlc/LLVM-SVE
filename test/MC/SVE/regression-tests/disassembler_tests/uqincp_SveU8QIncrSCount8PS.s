# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x8d,0x29,0x25
# CHECK: uqincp  x21, p10.b // encoding: [0x55,0x8d,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  x21, p10.b 
0xff,0x8d,0x29,0x25
# CHECK: uqincp  xzr, p15.b // encoding: [0xff,0x8d,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  xzr, p15.b 
0xb7,0x8d,0x29,0x25
# CHECK: uqincp  x23, p13.b // encoding: [0xb7,0x8d,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  x23, p13.b 
0x00,0x8c,0x29,0x25
# CHECK: uqincp  x0, p0.b // encoding: [0x00,0x8c,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  x0, p0.b 
