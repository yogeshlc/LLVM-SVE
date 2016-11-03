# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x9c,0x60,0x04
# CHECK: lsl     z0.s, z0.s, #0 // encoding: [0x00,0x9c,0x60,0x04]
# CHECK-ERROR-NOT: lsl     z0.s, z0.s, #0 
0xff,0x9f,0x7f,0x04
# CHECK: lsl     z31.s, z31.s, #31 // encoding: [0xff,0x9f,0x7f,0x04]
# CHECK-ERROR-NOT: lsl     z31.s, z31.s, #31 
0xb7,0x9d,0x68,0x04
# CHECK: lsl     z23.s, z13.s, #8 // encoding: [0xb7,0x9d,0x68,0x04]
# CHECK-ERROR-NOT: lsl     z23.s, z13.s, #8 
0x55,0x9d,0x75,0x04
# CHECK: lsl     z21.s, z10.s, #21 // encoding: [0x55,0x9d,0x75,0x04]
# CHECK-ERROR-NOT: lsl     z21.s, z10.s, #21 
