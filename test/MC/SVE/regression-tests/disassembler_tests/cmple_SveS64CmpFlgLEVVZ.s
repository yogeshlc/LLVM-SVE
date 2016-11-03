# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xc0,0x24
# CHECK: cmpge   p0.d, p0/z, z0.d, z0.d // encoding: [0x00,0x80,0xc0,0x24]
# CHECK-ERROR-NOT: cmpge   p0.d, p0/z, z0.d, z0.d 
0xef,0x9f,0xdf,0x24
# CHECK: cmpge   p15.d, p7/z, z31.d, z31.d // encoding: [0xef,0x9f,0xdf,0x24]
# CHECK-ERROR-NOT: cmpge   p15.d, p7/z, z31.d, z31.d 
0xa7,0x8d,0xc8,0x24
# CHECK: cmpge   p7.d, p3/z, z13.d, z8.d // encoding: [0xa7,0x8d,0xc8,0x24]
# CHECK-ERROR-NOT: cmpge   p7.d, p3/z, z13.d, z8.d 
0x45,0x95,0xd5,0x24
# CHECK: cmpge   p5.d, p5/z, z10.d, z21.d // encoding: [0x45,0x95,0xd5,0x24]
# CHECK-ERROR-NOT: cmpge   p5.d, p5/z, z10.d, z21.d 
