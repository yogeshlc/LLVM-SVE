# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0xff,0x9f,0x85
# CHECK: prfd    #15, p7, [z31.s, #248] // encoding: [0xef,0xff,0x9f,0x85]
# CHECK-ERROR-NOT: prfd    #15, p7, [z31.s, #248] 
0xa7,0xed,0x88,0x85
# CHECK: prfd    #7, p3, [z13.s, #64] // encoding: [0xa7,0xed,0x88,0x85]
# CHECK-ERROR-NOT: prfd    #7, p3, [z13.s, #64] 
0x00,0xe0,0x80,0x85
# CHECK: prfd    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x80,0x85]
# CHECK-ERROR-NOT: prfd    pldl1keep, p0, [z0.s] 
0x45,0xf5,0x95,0x85
# CHECK: prfd    pldl3strm, p5, [z10.s, #168] // encoding: [0x45,0xf5,0x95,0x85]
# CHECK-ERROR-NOT: prfd    pldl3strm, p5, [z10.s, #168] 
