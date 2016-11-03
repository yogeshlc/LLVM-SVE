# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0x88,0x25
# CHECK: cmple   p7.s, p3/z, z13.s, #8 // encoding: [0xb7,0x2d,0x88,0x25]
# CHECK-ERROR-NOT: cmple   p7.s, p3/z, z13.s, #8 
0x55,0x35,0x95,0x25
# CHECK: cmple   p5.s, p5/z, z10.s, #-11 // encoding: [0x55,0x35,0x95,0x25]
# CHECK-ERROR-NOT: cmple   p5.s, p5/z, z10.s, #-11 
0xff,0x3f,0x9f,0x25
# CHECK: cmple   p15.s, p7/z, z31.s, #-1 // encoding: [0xff,0x3f,0x9f,0x25]
# CHECK-ERROR-NOT: cmple   p15.s, p7/z, z31.s, #-1 
0x10,0x20,0x80,0x25
# CHECK: cmple   p0.s, p0/z, z0.s, #0 // encoding: [0x10,0x20,0x80,0x25]
# CHECK-ERROR-NOT: cmple   p0.s, p0/z, z0.s, #0 
