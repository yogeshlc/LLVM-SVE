# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0x20,0x84
# CHECK: prfb    pldl1keep, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x00,0x20,0x84]
# CHECK-ERROR-NOT: prfb    pldl1keep, p0, [x0, z0.s, uxtw] 
0x45,0x15,0x35,0x84
# CHECK: prfb    pldl3strm, p5, [x10, z21.s, uxtw] // encoding: [0x45,0x15,0x35,0x84]
# CHECK-ERROR-NOT: prfb    pldl3strm, p5, [x10, z21.s, uxtw] 
0xef,0x1f,0x3f,0x84
# CHECK: prfb    #15, p7, [sp, z31.s, uxtw] // encoding: [0xef,0x1f,0x3f,0x84]
# CHECK-ERROR-NOT: prfb    #15, p7, [sp, z31.s, uxtw] 
0xa7,0x0d,0x28,0x84
# CHECK: prfb    #7, p3, [x13, z8.s, uxtw] // encoding: [0xa7,0x0d,0x28,0x84]
# CHECK-ERROR-NOT: prfb    #7, p3, [x13, z8.s, uxtw] 
