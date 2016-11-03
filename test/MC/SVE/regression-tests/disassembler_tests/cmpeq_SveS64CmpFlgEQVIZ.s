# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x9f,0xdf,0x25
# CHECK: cmpeq   p15.d, p7/z, z31.d, #-1 // encoding: [0xef,0x9f,0xdf,0x25]
# CHECK-ERROR-NOT: cmpeq   p15.d, p7/z, z31.d, #-1 
0xa7,0x8d,0xc8,0x25
# CHECK: cmpeq   p7.d, p3/z, z13.d, #8 // encoding: [0xa7,0x8d,0xc8,0x25]
# CHECK-ERROR-NOT: cmpeq   p7.d, p3/z, z13.d, #8 
0x45,0x95,0xd5,0x25
# CHECK: cmpeq   p5.d, p5/z, z10.d, #-11 // encoding: [0x45,0x95,0xd5,0x25]
# CHECK-ERROR-NOT: cmpeq   p5.d, p5/z, z10.d, #-11 
0x00,0x80,0xc0,0x25
# CHECK: cmpeq   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x80,0xc0,0x25]
# CHECK-ERROR-NOT: cmpeq   p0.d, p0/z, z0.d, #0 
