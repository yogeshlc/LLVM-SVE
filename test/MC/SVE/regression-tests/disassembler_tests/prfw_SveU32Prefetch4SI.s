# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x4d,0xc8,0x85
# CHECK: prfw    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x4d,0xc8,0x85]
# CHECK-ERROR-NOT: prfw    #7, p3, [x13, #8, mul vl] 
0x45,0x55,0xd5,0x85
# CHECK: prfw    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x55,0xd5,0x85]
# CHECK-ERROR-NOT: prfw    pldl3strm, p5, [x10, #21, mul vl] 
0xef,0x5f,0xff,0x85
# CHECK: prfw    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x5f,0xff,0x85]
# CHECK-ERROR-NOT: prfw    #15, p7, [sp, #-1, mul vl] 
0x00,0x40,0xc0,0x85
# CHECK: prfw    pldl1keep, p0, [x0] // encoding: [0x00,0x40,0xc0,0x85]
# CHECK-ERROR-NOT: prfw    pldl1keep, p0, [x0] 
