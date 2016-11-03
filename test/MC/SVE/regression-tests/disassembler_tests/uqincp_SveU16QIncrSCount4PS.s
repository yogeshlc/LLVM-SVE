# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x88,0x69,0x25
# CHECK: uqincp  w0, p0.h // encoding: [0x00,0x88,0x69,0x25]
# CHECK-ERROR-NOT: uqincp  w0, p0.h 
0x55,0x89,0x69,0x25
# CHECK: uqincp  w21, p10.h // encoding: [0x55,0x89,0x69,0x25]
# CHECK-ERROR-NOT: uqincp  w21, p10.h 
0xff,0x89,0x69,0x25
# CHECK: uqincp  wzr, p15.h // encoding: [0xff,0x89,0x69,0x25]
# CHECK-ERROR-NOT: uqincp  wzr, p15.h 
0xb7,0x89,0x69,0x25
# CHECK: uqincp  w23, p13.h // encoding: [0xb7,0x89,0x69,0x25]
# CHECK-ERROR-NOT: uqincp  w23, p13.h 
