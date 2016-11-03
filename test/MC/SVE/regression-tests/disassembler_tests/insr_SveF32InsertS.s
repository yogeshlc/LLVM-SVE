# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x3b,0xb4,0x05
# CHECK: insr    z31.s, s31 // encoding: [0xff,0x3b,0xb4,0x05]
# CHECK-ERROR-NOT: insr    z31.s, s31 
0x00,0x38,0xb4,0x05
# CHECK: insr    z0.s, s0 // encoding: [0x00,0x38,0xb4,0x05]
# CHECK-ERROR-NOT: insr    z0.s, s0 
0xb7,0x39,0xb4,0x05
# CHECK: insr    z23.s, s13 // encoding: [0xb7,0x39,0xb4,0x05]
# CHECK-ERROR-NOT: insr    z23.s, s13 
0x55,0x39,0xb4,0x05
# CHECK: insr    z21.s, s10 // encoding: [0x55,0x39,0xb4,0x05]
# CHECK-ERROR-NOT: insr    z21.s, s10 
