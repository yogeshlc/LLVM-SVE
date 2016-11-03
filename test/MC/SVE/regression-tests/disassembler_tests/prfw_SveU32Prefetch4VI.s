# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xf5,0x15,0x85
# CHECK: prfw    pldl3strm, p5, [z10.s, #84] // encoding: [0x45,0xf5,0x15,0x85]
# CHECK-ERROR-NOT: prfw    pldl3strm, p5, [z10.s, #84] 
0xa7,0xed,0x08,0x85
# CHECK: prfw    #7, p3, [z13.s, #32] // encoding: [0xa7,0xed,0x08,0x85]
# CHECK-ERROR-NOT: prfw    #7, p3, [z13.s, #32] 
0x00,0xe0,0x00,0x85
# CHECK: prfw    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x85]
# CHECK-ERROR-NOT: prfw    pldl1keep, p0, [z0.s] 
0xef,0xff,0x1f,0x85
# CHECK: prfw    #15, p7, [z31.s, #124] // encoding: [0xef,0xff,0x1f,0x85]
# CHECK-ERROR-NOT: prfw    #15, p7, [z31.s, #124] 
