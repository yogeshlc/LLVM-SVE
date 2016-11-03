# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xd5,0x95,0x85
# CHECK: prfd    pldl3strm, p5, [x10, x21, lsl #3] // encoding: [0x45,0xd5,0x95,0x85]
# CHECK-ERROR-NOT: prfd    pldl3strm, p5, [x10, x21, lsl #3] 
0xa7,0xcd,0x88,0x85
# CHECK: prfd    #7, p3, [x13, x8, lsl #3] // encoding: [0xa7,0xcd,0x88,0x85]
# CHECK-ERROR-NOT: prfd    #7, p3, [x13, x8, lsl #3] 
0x25,0xce,0x90,0x85
# CHECK: prfd    pldl3strm, p3, [x17, x16, lsl #3] // encoding: [0x25,0xce,0x90,0x85]
# CHECK-ERROR-NOT: prfd    pldl3strm, p3, [x17, x16, lsl #3] 
0x00,0xc0,0x80,0x85
# CHECK: prfd    pldl1keep, p0, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0x80,0x85]
# CHECK-ERROR-NOT: prfd    pldl1keep, p0, [x0, x0, lsl #3] 
