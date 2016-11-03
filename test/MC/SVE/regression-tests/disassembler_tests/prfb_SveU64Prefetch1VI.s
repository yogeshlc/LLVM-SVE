# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0xff,0x1f,0xc4
# CHECK: prfb    #15, p7, [z31.d, #31] // encoding: [0xef,0xff,0x1f,0xc4]
# CHECK-ERROR-NOT: prfb    #15, p7, [z31.d, #31] 
0xa7,0xed,0x08,0xc4
# CHECK: prfb    #7, p3, [z13.d, #8] // encoding: [0xa7,0xed,0x08,0xc4]
# CHECK-ERROR-NOT: prfb    #7, p3, [z13.d, #8] 
0x00,0xe0,0x00,0xc4
# CHECK: prfb    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x00,0xc4]
# CHECK-ERROR-NOT: prfb    pldl1keep, p0, [z0.d] 
0x45,0xf5,0x15,0xc4
# CHECK: prfb    pldl3strm, p5, [z10.d, #21] // encoding: [0x45,0xf5,0x15,0xc4]
# CHECK-ERROR-NOT: prfb    pldl3strm, p5, [z10.d, #21] 
