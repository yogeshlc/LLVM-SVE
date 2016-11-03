# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x9d,0xf5,0x04
# CHECK: lsl     z21.d, z10.d, #53 // encoding: [0x55,0x9d,0xf5,0x04]
# CHECK-ERROR-NOT: lsl     z21.d, z10.d, #53 
0x00,0x9c,0xa0,0x04
# CHECK: lsl     z0.d, z0.d, #0 // encoding: [0x00,0x9c,0xa0,0x04]
# CHECK-ERROR-NOT: lsl     z0.d, z0.d, #0 
0xff,0x9f,0xff,0x04
# CHECK: lsl     z31.d, z31.d, #63 // encoding: [0xff,0x9f,0xff,0x04]
# CHECK-ERROR-NOT: lsl     z31.d, z31.d, #63 
0xb7,0x9d,0xe8,0x04
# CHECK: lsl     z23.d, z13.d, #40 // encoding: [0xb7,0x9d,0xe8,0x04]
# CHECK-ERROR-NOT: lsl     z23.d, z13.d, #40 
