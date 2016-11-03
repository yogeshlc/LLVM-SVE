# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x2d,0xc8,0x85
# CHECK: prfh    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x2d,0xc8,0x85]
# CHECK-ERROR-NOT: prfh    #7, p3, [x13, #8, mul vl] 
0xef,0x3f,0xff,0x85
# CHECK: prfh    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x3f,0xff,0x85]
# CHECK-ERROR-NOT: prfh    #15, p7, [sp, #-1, mul vl] 
0x00,0x20,0xc0,0x85
# CHECK: prfh    pldl1keep, p0, [x0] // encoding: [0x00,0x20,0xc0,0x85]
# CHECK-ERROR-NOT: prfh    pldl1keep, p0, [x0] 
0x45,0x35,0xd5,0x85
# CHECK: prfh    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x35,0xd5,0x85]
# CHECK-ERROR-NOT: prfh    pldl3strm, p5, [x10, #21, mul vl] 
