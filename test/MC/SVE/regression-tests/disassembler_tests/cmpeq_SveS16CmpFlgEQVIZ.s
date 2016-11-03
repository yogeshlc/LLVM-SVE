# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x95,0x55,0x25
# CHECK: cmpeq   p5.h, p5/z, z10.h, #-11 // encoding: [0x45,0x95,0x55,0x25]
# CHECK-ERROR-NOT: cmpeq   p5.h, p5/z, z10.h, #-11 
0xef,0x9f,0x5f,0x25
# CHECK: cmpeq   p15.h, p7/z, z31.h, #-1 // encoding: [0xef,0x9f,0x5f,0x25]
# CHECK-ERROR-NOT: cmpeq   p15.h, p7/z, z31.h, #-1 
0x00,0x80,0x40,0x25
# CHECK: cmpeq   p0.h, p0/z, z0.h, #0 // encoding: [0x00,0x80,0x40,0x25]
# CHECK-ERROR-NOT: cmpeq   p0.h, p0/z, z0.h, #0 
0xa7,0x8d,0x48,0x25
# CHECK: cmpeq   p7.h, p3/z, z13.h, #8 // encoding: [0xa7,0x8d,0x48,0x25]
# CHECK-ERROR-NOT: cmpeq   p7.h, p3/z, z13.h, #8 
