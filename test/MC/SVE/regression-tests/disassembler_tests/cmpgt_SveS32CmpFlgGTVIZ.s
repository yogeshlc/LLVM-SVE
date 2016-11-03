# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x1f,0x9f,0x25
# CHECK: cmpgt   p15.s, p7/z, z31.s, #-1 // encoding: [0xff,0x1f,0x9f,0x25]
# CHECK-ERROR-NOT: cmpgt   p15.s, p7/z, z31.s, #-1 
0x10,0x00,0x80,0x25
# CHECK: cmpgt   p0.s, p0/z, z0.s, #0 // encoding: [0x10,0x00,0x80,0x25]
# CHECK-ERROR-NOT: cmpgt   p0.s, p0/z, z0.s, #0 
0x55,0x15,0x95,0x25
# CHECK: cmpgt   p5.s, p5/z, z10.s, #-11 // encoding: [0x55,0x15,0x95,0x25]
# CHECK-ERROR-NOT: cmpgt   p5.s, p5/z, z10.s, #-11 
0xb7,0x0d,0x88,0x25
# CHECK: cmpgt   p7.s, p3/z, z13.s, #8 // encoding: [0xb7,0x0d,0x88,0x25]
# CHECK-ERROR-NOT: cmpgt   p7.s, p3/z, z13.s, #8 
