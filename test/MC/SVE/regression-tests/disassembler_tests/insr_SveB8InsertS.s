# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x39,0x34,0x05
# CHECK: insr    z21.b, b10 // encoding: [0x55,0x39,0x34,0x05]
# CHECK-ERROR-NOT: insr    z21.b, b10 
0xb7,0x39,0x34,0x05
# CHECK: insr    z23.b, b13 // encoding: [0xb7,0x39,0x34,0x05]
# CHECK-ERROR-NOT: insr    z23.b, b13 
0x00,0x38,0x34,0x05
# CHECK: insr    z0.b, b0 // encoding: [0x00,0x38,0x34,0x05]
# CHECK-ERROR-NOT: insr    z0.b, b0 
0xff,0x3b,0x34,0x05
# CHECK: insr    z31.b, b31 // encoding: [0xff,0x3b,0x34,0x05]
# CHECK-ERROR-NOT: insr    z31.b, b31 
