# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xd5,0x95,0x84
# CHECK: prfh    pldl3strm, p5, [x10, x21, lsl #1] // encoding: [0x45,0xd5,0x95,0x84]
# CHECK-ERROR-NOT: prfh    pldl3strm, p5, [x10, x21, lsl #1] 
0x25,0xce,0x90,0x84
# CHECK: prfh    pldl3strm, p3, [x17, x16, lsl #1] // encoding: [0x25,0xce,0x90,0x84]
# CHECK-ERROR-NOT: prfh    pldl3strm, p3, [x17, x16, lsl #1] 
0x00,0xc0,0x80,0x84
# CHECK: prfh    pldl1keep, p0, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0x80,0x84]
# CHECK-ERROR-NOT: prfh    pldl1keep, p0, [x0, x0, lsl #1] 
0xa7,0xcd,0x88,0x84
# CHECK: prfh    #7, p3, [x13, x8, lsl #1] // encoding: [0xa7,0xcd,0x88,0x84]
# CHECK-ERROR-NOT: prfh    #7, p3, [x13, x8, lsl #1] 
