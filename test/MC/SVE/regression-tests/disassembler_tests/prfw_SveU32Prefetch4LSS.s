# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0x00,0x85
# CHECK: prfw    pldl1keep, p0, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x00,0x85]
# CHECK-ERROR-NOT: prfw    pldl1keep, p0, [x0, x0, lsl #2] 
0xa7,0xcd,0x08,0x85
# CHECK: prfw    #7, p3, [x13, x8, lsl #2] // encoding: [0xa7,0xcd,0x08,0x85]
# CHECK-ERROR-NOT: prfw    #7, p3, [x13, x8, lsl #2] 
0x25,0xce,0x10,0x85
# CHECK: prfw    pldl3strm, p3, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x10,0x85]
# CHECK-ERROR-NOT: prfw    pldl3strm, p3, [x17, x16, lsl #2] 
0x45,0xd5,0x15,0x85
# CHECK: prfw    pldl3strm, p5, [x10, x21, lsl #2] // encoding: [0x45,0xd5,0x15,0x85]
# CHECK-ERROR-NOT: prfw    pldl3strm, p5, [x10, x21, lsl #2] 
