# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x00,0x20,0x24
# CHECK: cmphi   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x00,0x20,0x24]
# CHECK-ERROR-NOT: cmphi   p0.b, p0/z, z0.b, #0 
0xff,0xdf,0x3f,0x24
# CHECK: cmphi   p15.b, p7/z, z31.b, #127 // encoding: [0xff,0xdf,0x3f,0x24]
# CHECK-ERROR-NOT: cmphi   p15.b, p7/z, z31.b, #127 
0xb7,0xcd,0x28,0x24
# CHECK: cmphi   p7.b, p3/z, z13.b, #35 // encoding: [0xb7,0xcd,0x28,0x24]
# CHECK-ERROR-NOT: cmphi   p7.b, p3/z, z13.b, #35 
0x55,0x55,0x35,0x24
# CHECK: cmphi   p5.b, p5/z, z10.b, #85 // encoding: [0x55,0x55,0x35,0x24]
# CHECK-ERROR-NOT: cmphi   p5.b, p5/z, z10.b, #85 
