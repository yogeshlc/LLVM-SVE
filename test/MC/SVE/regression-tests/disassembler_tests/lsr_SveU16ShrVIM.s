# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x01,0x04
# CHECK: lsr     z31.h, p7/m, z31.h, #1 // encoding: [0xff,0x9f,0x01,0x04]
# CHECK-ERROR-NOT: lsr     z31.h, p7/m, z31.h, #1 
0xb7,0x8f,0x01,0x04
# CHECK: lsr     z23.h, p3/m, z23.h, #3 // encoding: [0xb7,0x8f,0x01,0x04]
# CHECK-ERROR-NOT: lsr     z23.h, p3/m, z23.h, #3 
0x55,0x97,0x01,0x04
# CHECK: lsr     z21.h, p5/m, z21.h, #6 // encoding: [0x55,0x97,0x01,0x04]
# CHECK-ERROR-NOT: lsr     z21.h, p5/m, z21.h, #6 
0x00,0x82,0x01,0x04
# CHECK: lsr     z0.h, p0/m, z0.h, #16 // encoding: [0x00,0x82,0x01,0x04]
# CHECK-ERROR-NOT: lsr     z0.h, p0/m, z0.h, #16 
