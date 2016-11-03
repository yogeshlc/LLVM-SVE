# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0xed,0x28,0x24
# CHECK: cmplo   p7.b, p3/z, z13.b, #35 // encoding: [0xa7,0xed,0x28,0x24]
# CHECK-ERROR-NOT: cmplo   p7.b, p3/z, z13.b, #35 
0xef,0xff,0x3f,0x24
# CHECK: cmplo   p15.b, p7/z, z31.b, #127 // encoding: [0xef,0xff,0x3f,0x24]
# CHECK-ERROR-NOT: cmplo   p15.b, p7/z, z31.b, #127 
0x45,0x75,0x35,0x24
# CHECK: cmplo   p5.b, p5/z, z10.b, #85 // encoding: [0x45,0x75,0x35,0x24]
# CHECK-ERROR-NOT: cmplo   p5.b, p5/z, z10.b, #85 
0x00,0x20,0x20,0x24
# CHECK: cmplo   p0.b, p0/z, z0.b, #0 // encoding: [0x00,0x20,0x20,0x24]
# CHECK-ERROR-NOT: cmplo   p0.b, p0/z, z0.b, #0 
