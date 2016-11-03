# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0xff,0x9f,0x84
# CHECK: prfh    #15, p7, [z31.s, #62] // encoding: [0xef,0xff,0x9f,0x84]
# CHECK-ERROR-NOT: prfh    #15, p7, [z31.s, #62] 
0x00,0xe0,0x80,0x84
# CHECK: prfh    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x80,0x84]
# CHECK-ERROR-NOT: prfh    pldl1keep, p0, [z0.s] 
0x45,0xf5,0x95,0x84
# CHECK: prfh    pldl3strm, p5, [z10.s, #42] // encoding: [0x45,0xf5,0x95,0x84]
# CHECK-ERROR-NOT: prfh    pldl3strm, p5, [z10.s, #42] 
0xa7,0xed,0x88,0x84
# CHECK: prfh    #7, p3, [z13.s, #16] // encoding: [0xa7,0xed,0x88,0x84]
# CHECK-ERROR-NOT: prfh    #7, p3, [z13.s, #16] 
