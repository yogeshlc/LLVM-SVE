# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0xff,0xbf,0x24
# CHECK: cmplo   p15.s, p7/z, z31.s, #127 // encoding: [0xef,0xff,0xbf,0x24]
# CHECK-ERROR-NOT: cmplo   p15.s, p7/z, z31.s, #127 
0x00,0x20,0xa0,0x24
# CHECK: cmplo   p0.s, p0/z, z0.s, #0 // encoding: [0x00,0x20,0xa0,0x24]
# CHECK-ERROR-NOT: cmplo   p0.s, p0/z, z0.s, #0 
0xa7,0xed,0xa8,0x24
# CHECK: cmplo   p7.s, p3/z, z13.s, #35 // encoding: [0xa7,0xed,0xa8,0x24]
# CHECK-ERROR-NOT: cmplo   p7.s, p3/z, z13.s, #35 
0x45,0x75,0xb5,0x24
# CHECK: cmplo   p5.s, p5/z, z10.s, #85 // encoding: [0x45,0x75,0xb5,0x24]
# CHECK-ERROR-NOT: cmplo   p5.s, p5/z, z10.s, #85 
