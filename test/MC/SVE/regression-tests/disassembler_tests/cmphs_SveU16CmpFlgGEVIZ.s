# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0xcd,0x68,0x24
# CHECK: cmphs   p7.h, p3/z, z13.h, #35 // encoding: [0xa7,0xcd,0x68,0x24]
# CHECK-ERROR-NOT: cmphs   p7.h, p3/z, z13.h, #35 
0x45,0x55,0x75,0x24
# CHECK: cmphs   p5.h, p5/z, z10.h, #85 // encoding: [0x45,0x55,0x75,0x24]
# CHECK-ERROR-NOT: cmphs   p5.h, p5/z, z10.h, #85 
0xef,0xdf,0x7f,0x24
# CHECK: cmphs   p15.h, p7/z, z31.h, #127 // encoding: [0xef,0xdf,0x7f,0x24]
# CHECK-ERROR-NOT: cmphs   p15.h, p7/z, z31.h, #127 
0x00,0x00,0x60,0x24
# CHECK: cmphs   p0.h, p0/z, z0.h, #0 // encoding: [0x00,0x00,0x60,0x24]
# CHECK-ERROR-NOT: cmphs   p0.h, p0/z, z0.h, #0 
