# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x95,0x75,0xc4
# CHECK: prfb    pldl3strm, p5, [x10, z21.d] // encoding: [0x45,0x95,0x75,0xc4]
# CHECK-ERROR-NOT: prfb    pldl3strm, p5, [x10, z21.d] 
0x00,0x80,0x60,0xc4
# CHECK: prfb    pldl1keep, p0, [x0, z0.d] // encoding: [0x00,0x80,0x60,0xc4]
# CHECK-ERROR-NOT: prfb    pldl1keep, p0, [x0, z0.d] 
0xef,0x9f,0x7f,0xc4
# CHECK: prfb    #15, p7, [sp, z31.d] // encoding: [0xef,0x9f,0x7f,0xc4]
# CHECK-ERROR-NOT: prfb    #15, p7, [sp, z31.d] 
0xa7,0x8d,0x68,0xc4
# CHECK: prfb    #7, p3, [x13, z8.d] // encoding: [0xa7,0x8d,0x68,0xc4]
# CHECK-ERROR-NOT: prfb    #7, p3, [x13, z8.d] 
