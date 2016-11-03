# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x1f,0xdf,0x24
# CHECK: cmphs   p15.d, p7/z, z31.d, z31.d // encoding: [0xef,0x1f,0xdf,0x24]
# CHECK-ERROR-NOT: cmphs   p15.d, p7/z, z31.d, z31.d 
0x45,0x15,0xd5,0x24
# CHECK: cmphs   p5.d, p5/z, z10.d, z21.d // encoding: [0x45,0x15,0xd5,0x24]
# CHECK-ERROR-NOT: cmphs   p5.d, p5/z, z10.d, z21.d 
0x00,0x00,0xc0,0x24
# CHECK: cmphs   p0.d, p0/z, z0.d, z0.d // encoding: [0x00,0x00,0xc0,0x24]
# CHECK-ERROR-NOT: cmphs   p0.d, p0/z, z0.d, z0.d 
0xa7,0x0d,0xc8,0x24
# CHECK: cmphs   p7.d, p3/z, z13.d, z8.d // encoding: [0xa7,0x0d,0xc8,0x24]
# CHECK-ERROR-NOT: cmphs   p7.d, p3/z, z13.d, z8.d 
