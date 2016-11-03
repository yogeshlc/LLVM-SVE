# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0x20,0xc4
# CHECK: prfb    pldl1keep, p0, [x0, z0.d, uxtw] // encoding: [0x00,0x00,0x20,0xc4]
# CHECK-ERROR-NOT: prfb    pldl1keep, p0, [x0, z0.d, uxtw] 
0xa7,0x0d,0x28,0xc4
# CHECK: prfb    #7, p3, [x13, z8.d, uxtw] // encoding: [0xa7,0x0d,0x28,0xc4]
# CHECK-ERROR-NOT: prfb    #7, p3, [x13, z8.d, uxtw] 
0x45,0x15,0x35,0xc4
# CHECK: prfb    pldl3strm, p5, [x10, z21.d, uxtw] // encoding: [0x45,0x15,0x35,0xc4]
# CHECK-ERROR-NOT: prfb    pldl3strm, p5, [x10, z21.d, uxtw] 
0xef,0x1f,0x3f,0xc4
# CHECK: prfb    #15, p7, [sp, z31.d, uxtw] // encoding: [0xef,0x1f,0x3f,0xc4]
# CHECK-ERROR-NOT: prfb    #15, p7, [sp, z31.d, uxtw] 
