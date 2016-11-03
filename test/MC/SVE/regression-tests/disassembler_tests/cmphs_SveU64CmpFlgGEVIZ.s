# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0xe0,0x24
# CHECK: cmphs   p0.d, p0/z, z0.d, #0 // encoding: [0x00,0x00,0xe0,0x24]
# CHECK-ERROR-NOT: cmphs   p0.d, p0/z, z0.d, #0 
0xa7,0xcd,0xe8,0x24
# CHECK: cmphs   p7.d, p3/z, z13.d, #35 // encoding: [0xa7,0xcd,0xe8,0x24]
# CHECK-ERROR-NOT: cmphs   p7.d, p3/z, z13.d, #35 
0x45,0x55,0xf5,0x24
# CHECK: cmphs   p5.d, p5/z, z10.d, #85 // encoding: [0x45,0x55,0xf5,0x24]
# CHECK-ERROR-NOT: cmphs   p5.d, p5/z, z10.d, #85 
0xef,0xdf,0xff,0x24
# CHECK: cmphs   p15.d, p7/z, z31.d, #127 // encoding: [0xef,0xdf,0xff,0x24]
# CHECK-ERROR-NOT: cmphs   p15.d, p7/z, z31.d, #127 
