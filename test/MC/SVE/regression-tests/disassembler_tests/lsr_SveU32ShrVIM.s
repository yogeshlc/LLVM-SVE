# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x41,0x04
# CHECK: lsr     z0.s, p0/m, z0.s, #32 // encoding: [0x00,0x80,0x41,0x04]
# CHECK-ERROR-NOT: lsr     z0.s, p0/m, z0.s, #32 
0xb7,0x8d,0x41,0x04
# CHECK: lsr     z23.s, p3/m, z23.s, #19 // encoding: [0xb7,0x8d,0x41,0x04]
# CHECK-ERROR-NOT: lsr     z23.s, p3/m, z23.s, #19 
0xff,0x9f,0x41,0x04
# CHECK: lsr     z31.s, p7/m, z31.s, #1 // encoding: [0xff,0x9f,0x41,0x04]
# CHECK-ERROR-NOT: lsr     z31.s, p7/m, z31.s, #1 
0x55,0x95,0x41,0x04
# CHECK: lsr     z21.s, p5/m, z21.s, #22 // encoding: [0x55,0x95,0x41,0x04]
# CHECK-ERROR-NOT: lsr     z21.s, p5/m, z21.s, #22 
