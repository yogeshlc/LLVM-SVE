# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x95,0x38,0x04
# CHECK: lsr     z23.h, z13.h, #8 // encoding: [0xb7,0x95,0x38,0x04]
# CHECK-ERROR-NOT: lsr     z23.h, z13.h, #8 
0x55,0x95,0x35,0x04
# CHECK: lsr     z21.h, z10.h, #11 // encoding: [0x55,0x95,0x35,0x04]
# CHECK-ERROR-NOT: lsr     z21.h, z10.h, #11 
0xff,0x97,0x3f,0x04
# CHECK: lsr     z31.h, z31.h, #1 // encoding: [0xff,0x97,0x3f,0x04]
# CHECK-ERROR-NOT: lsr     z31.h, z31.h, #1 
0x00,0x94,0x30,0x04
# CHECK: lsr     z0.h, z0.h, #16 // encoding: [0x00,0x94,0x30,0x04]
# CHECK-ERROR-NOT: lsr     z0.h, z0.h, #16 
