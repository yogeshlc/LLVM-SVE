# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x55,0xb5,0x24
# CHECK: cmphs   p5.s, p5/z, z10.s, #85 // encoding: [0x45,0x55,0xb5,0x24]
# CHECK-ERROR-NOT: cmphs   p5.s, p5/z, z10.s, #85 
0x00,0x00,0xa0,0x24
# CHECK: cmphs   p0.s, p0/z, z0.s, #0 // encoding: [0x00,0x00,0xa0,0x24]
# CHECK-ERROR-NOT: cmphs   p0.s, p0/z, z0.s, #0 
0xef,0xdf,0xbf,0x24
# CHECK: cmphs   p15.s, p7/z, z31.s, #127 // encoding: [0xef,0xdf,0xbf,0x24]
# CHECK-ERROR-NOT: cmphs   p15.s, p7/z, z31.s, #127 
0xa7,0xcd,0xa8,0x24
# CHECK: cmphs   p7.s, p3/z, z13.s, #35 // encoding: [0xa7,0xcd,0xa8,0x24]
# CHECK-ERROR-NOT: cmphs   p7.s, p3/z, z13.s, #35 
