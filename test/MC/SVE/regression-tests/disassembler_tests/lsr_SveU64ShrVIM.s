# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x81,0x04
# CHECK: lsr     z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x81,0x04]
# CHECK-ERROR-NOT: lsr     z0.d, p0/m, z0.d, #64 
0x55,0x95,0xc1,0x04
# CHECK: lsr     z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc1,0x04]
# CHECK-ERROR-NOT: lsr     z21.d, p5/m, z21.d, #22 
0xb7,0x8d,0xc1,0x04
# CHECK: lsr     z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc1,0x04]
# CHECK-ERROR-NOT: lsr     z23.d, p3/m, z23.d, #19 
0xff,0x9f,0xc1,0x04
# CHECK: lsr     z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc1,0x04]
# CHECK-ERROR-NOT: lsr     z31.d, p7/m, z31.d, #1 
