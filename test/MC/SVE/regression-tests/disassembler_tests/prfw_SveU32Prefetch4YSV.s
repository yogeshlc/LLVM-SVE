# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0x20,0x84
# CHECK: prfw    pldl1keep, p0, [x0, z0.s, uxtw #2] // encoding: [0x00,0x40,0x20,0x84]
# CHECK-ERROR-NOT: prfw    pldl1keep, p0, [x0, z0.s, uxtw #2] 
0xef,0x5f,0x3f,0x84
# CHECK: prfw    #15, p7, [sp, z31.s, uxtw #2] // encoding: [0xef,0x5f,0x3f,0x84]
# CHECK-ERROR-NOT: prfw    #15, p7, [sp, z31.s, uxtw #2] 
0xa7,0x4d,0x28,0x84
# CHECK: prfw    #7, p3, [x13, z8.s, uxtw #2] // encoding: [0xa7,0x4d,0x28,0x84]
# CHECK-ERROR-NOT: prfw    #7, p3, [x13, z8.s, uxtw #2] 
0x45,0x55,0x35,0x84
# CHECK: prfw    pldl3strm, p5, [x10, z21.s, uxtw #2] // encoding: [0x45,0x55,0x35,0x84]
# CHECK-ERROR-NOT: prfw    pldl3strm, p5, [x10, z21.s, uxtw #2] 
