# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0xf5,0x04
# CHECK: lsr     z21.d, z10.d, #11 // encoding: [0x55,0x95,0xf5,0x04]
# CHECK-ERROR-NOT: lsr     z21.d, z10.d, #11 
0xb7,0x95,0xe8,0x04
# CHECK: lsr     z23.d, z13.d, #24 // encoding: [0xb7,0x95,0xe8,0x04]
# CHECK-ERROR-NOT: lsr     z23.d, z13.d, #24 
0x00,0x94,0xa0,0x04
# CHECK: lsr     z0.d, z0.d, #64 // encoding: [0x00,0x94,0xa0,0x04]
# CHECK-ERROR-NOT: lsr     z0.d, z0.d, #64 
0xff,0x97,0xff,0x04
# CHECK: lsr     z31.d, z31.d, #1 // encoding: [0xff,0x97,0xff,0x04]
# CHECK-ERROR-NOT: lsr     z31.d, z31.d, #1 
