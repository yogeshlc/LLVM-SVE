# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x0d,0x08,0x25
# CHECK: cmpgt   p7.b, p3/z, z13.b, #8 // encoding: [0xb7,0x0d,0x08,0x25]
# CHECK-ERROR-NOT: cmpgt   p7.b, p3/z, z13.b, #8 
0x55,0x15,0x15,0x25
# CHECK: cmpgt   p5.b, p5/z, z10.b, #-11 // encoding: [0x55,0x15,0x15,0x25]
# CHECK-ERROR-NOT: cmpgt   p5.b, p5/z, z10.b, #-11 
0xff,0x1f,0x1f,0x25
# CHECK: cmpgt   p15.b, p7/z, z31.b, #-1 // encoding: [0xff,0x1f,0x1f,0x25]
# CHECK-ERROR-NOT: cmpgt   p15.b, p7/z, z31.b, #-1 
0x10,0x00,0x00,0x25
# CHECK: cmpgt   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x00,0x00,0x25]
# CHECK-ERROR-NOT: cmpgt   p0.b, p0/z, z0.b, #0 
