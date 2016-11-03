# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x89,0xe9,0x25
# CHECK: uqincp  w23, p13.d // encoding: [0xb7,0x89,0xe9,0x25]
# CHECK-ERROR-NOT: uqincp  w23, p13.d 
0x00,0x88,0xe9,0x25
# CHECK: uqincp  w0, p0.d // encoding: [0x00,0x88,0xe9,0x25]
# CHECK-ERROR-NOT: uqincp  w0, p0.d 
0xff,0x89,0xe9,0x25
# CHECK: uqincp  wzr, p15.d // encoding: [0xff,0x89,0xe9,0x25]
# CHECK-ERROR-NOT: uqincp  wzr, p15.d 
0x55,0x89,0xe9,0x25
# CHECK: uqincp  w21, p10.d // encoding: [0x55,0x89,0xe9,0x25]
# CHECK-ERROR-NOT: uqincp  w21, p10.d 
