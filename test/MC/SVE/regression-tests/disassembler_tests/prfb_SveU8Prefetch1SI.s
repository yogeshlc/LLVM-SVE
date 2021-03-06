# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x1f,0xff,0x85
# CHECK: prfb    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x1f,0xff,0x85]
# CHECK-ERROR-NOT: prfb    #15, p7, [sp, #-1, mul vl] 
0x45,0x15,0xd5,0x85
# CHECK: prfb    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x15,0xd5,0x85]
# CHECK-ERROR-NOT: prfb    pldl3strm, p5, [x10, #21, mul vl] 
0x00,0x00,0xc0,0x85
# CHECK: prfb    pldl1keep, p0, [x0] // encoding: [0x00,0x00,0xc0,0x85]
# CHECK-ERROR-NOT: prfb    pldl1keep, p0, [x0] 
0xa7,0x0d,0xc8,0x85
# CHECK: prfb    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x0d,0xc8,0x85]
# CHECK-ERROR-NOT: prfb    #7, p3, [x13, #8, mul vl] 
