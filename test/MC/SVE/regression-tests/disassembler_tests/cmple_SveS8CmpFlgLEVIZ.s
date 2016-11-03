# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x20,0x00,0x25
# CHECK: cmple   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x20,0x00,0x25]
# CHECK-ERROR-NOT: cmple   p0.b, p0/z, z0.b, #0 
0xff,0x3f,0x1f,0x25
# CHECK: cmple   p15.b, p7/z, z31.b, #-1 // encoding: [0xff,0x3f,0x1f,0x25]
# CHECK-ERROR-NOT: cmple   p15.b, p7/z, z31.b, #-1 
0x55,0x35,0x15,0x25
# CHECK: cmple   p5.b, p5/z, z10.b, #-11 // encoding: [0x55,0x35,0x15,0x25]
# CHECK-ERROR-NOT: cmple   p5.b, p5/z, z10.b, #-11 
0xb7,0x2d,0x08,0x25
# CHECK: cmple   p7.b, p3/z, z13.b, #8 // encoding: [0xb7,0x2d,0x08,0x25]
# CHECK-ERROR-NOT: cmple   p7.b, p3/z, z13.b, #8 
