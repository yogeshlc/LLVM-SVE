# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x3f,0x9f,0x25
# CHECK: cmplt   p15.s, p7/z, z31.s, #-1 // encoding: [0xef,0x3f,0x9f,0x25]
# CHECK-ERROR-NOT: cmplt   p15.s, p7/z, z31.s, #-1 
0x00,0x20,0x80,0x25
# CHECK: cmplt   p0.s, p0/z, z0.s, #0 // encoding: [0x00,0x20,0x80,0x25]
# CHECK-ERROR-NOT: cmplt   p0.s, p0/z, z0.s, #0 
0x45,0x35,0x95,0x25
# CHECK: cmplt   p5.s, p5/z, z10.s, #-11 // encoding: [0x45,0x35,0x95,0x25]
# CHECK-ERROR-NOT: cmplt   p5.s, p5/z, z10.s, #-11 
0xa7,0x2d,0x88,0x25
# CHECK: cmplt   p7.s, p3/z, z13.s, #8 // encoding: [0xa7,0x2d,0x88,0x25]
# CHECK-ERROR-NOT: cmplt   p7.s, p3/z, z13.s, #8 
