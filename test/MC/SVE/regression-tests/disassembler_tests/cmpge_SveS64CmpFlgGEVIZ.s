# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x1f,0xdf,0x25
# CHECK: cmpge   p15.d, p7/z, z31.d, #-1 // encoding: [0xef,0x1f,0xdf,0x25]
# CHECK-ERROR-NOT: cmpge   p15.d, p7/z, z31.d, #-1 
0x00,0x00,0xc0,0x25
# CHECK: cmpge   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x00,0xc0,0x25]
# CHECK-ERROR-NOT: cmpge   p0.d, p0/z, z0.d, #0 
0xa7,0x0d,0xc8,0x25
# CHECK: cmpge   p7.d, p3/z, z13.d, #8 // encoding: [0xa7,0x0d,0xc8,0x25]
# CHECK-ERROR-NOT: cmpge   p7.d, p3/z, z13.d, #8 
0x45,0x15,0xd5,0x25
# CHECK: cmpge   p5.d, p5/z, z10.d, #-11 // encoding: [0x45,0x15,0xd5,0x25]
# CHECK-ERROR-NOT: cmpge   p5.d, p5/z, z10.d, #-11 
