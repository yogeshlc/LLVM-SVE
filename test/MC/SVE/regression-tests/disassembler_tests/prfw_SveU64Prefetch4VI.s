# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xf5,0x15,0xc5
# CHECK: prfw    pldl3strm, p5, [z10.d, #84] // encoding: [0x45,0xf5,0x15,0xc5]
# CHECK-ERROR-NOT: prfw    pldl3strm, p5, [z10.d, #84] 
0xef,0xff,0x1f,0xc5
# CHECK: prfw    #15, p7, [z31.d, #124] // encoding: [0xef,0xff,0x1f,0xc5]
# CHECK-ERROR-NOT: prfw    #15, p7, [z31.d, #124] 
0x00,0xe0,0x00,0xc5
# CHECK: prfw    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x00,0xc5]
# CHECK-ERROR-NOT: prfw    pldl1keep, p0, [z0.d] 
0xa7,0xed,0x08,0xc5
# CHECK: prfw    #7, p3, [z13.d, #32] // encoding: [0xa7,0xed,0x08,0xc5]
# CHECK-ERROR-NOT: prfw    #7, p3, [z13.d, #32] 
