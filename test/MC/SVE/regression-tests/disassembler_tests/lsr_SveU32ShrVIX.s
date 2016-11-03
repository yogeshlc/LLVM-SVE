# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x94,0x60,0x04
# CHECK: lsr     z0.s, z0.s, #32 // encoding: [0x00,0x94,0x60,0x04]
# CHECK-ERROR-NOT: lsr     z0.s, z0.s, #32 
0xff,0x97,0x7f,0x04
# CHECK: lsr     z31.s, z31.s, #1 // encoding: [0xff,0x97,0x7f,0x04]
# CHECK-ERROR-NOT: lsr     z31.s, z31.s, #1 
0x55,0x95,0x75,0x04
# CHECK: lsr     z21.s, z10.s, #11 // encoding: [0x55,0x95,0x75,0x04]
# CHECK-ERROR-NOT: lsr     z21.s, z10.s, #11 
0xb7,0x95,0x68,0x04
# CHECK: lsr     z23.s, z13.s, #24 // encoding: [0xb7,0x95,0x68,0x04]
# CHECK-ERROR-NOT: lsr     z23.s, z13.s, #24 
