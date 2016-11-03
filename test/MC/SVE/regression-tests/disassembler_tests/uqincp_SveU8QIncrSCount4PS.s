# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x89,0x29,0x25
# CHECK: uqincp  w23, p13.b // encoding: [0xb7,0x89,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  w23, p13.b 
0x55,0x89,0x29,0x25
# CHECK: uqincp  w21, p10.b // encoding: [0x55,0x89,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  w21, p10.b 
0x00,0x88,0x29,0x25
# CHECK: uqincp  w0, p0.b // encoding: [0x00,0x88,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  w0, p0.b 
0xff,0x89,0x29,0x25
# CHECK: uqincp  wzr, p15.b // encoding: [0xff,0x89,0x29,0x25]
# CHECK-ERROR-NOT: uqincp  wzr, p15.b 
