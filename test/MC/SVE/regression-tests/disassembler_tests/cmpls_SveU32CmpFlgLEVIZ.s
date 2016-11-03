# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x75,0xb5,0x24
# CHECK: cmpls   p5.s, p5/z, z10.s, #85 // encoding: [0x55,0x75,0xb5,0x24]
# CHECK-ERROR-NOT: cmpls   p5.s, p5/z, z10.s, #85 
0xff,0xff,0xbf,0x24
# CHECK: cmpls   p15.s, p7/z, z31.s, #127 // encoding: [0xff,0xff,0xbf,0x24]
# CHECK-ERROR-NOT: cmpls   p15.s, p7/z, z31.s, #127 
0x10,0x20,0xa0,0x24
# CHECK: cmpls   p0.s, p0/z, z0.s, #0 // encoding: [0x10,0x20,0xa0,0x24]
# CHECK-ERROR-NOT: cmpls   p0.s, p0/z, z0.s, #0 
0xb7,0xed,0xa8,0x24
# CHECK: cmpls   p7.s, p3/z, z13.s, #35 // encoding: [0xb7,0xed,0xa8,0x24]
# CHECK-ERROR-NOT: cmpls   p7.s, p3/z, z13.s, #35 
