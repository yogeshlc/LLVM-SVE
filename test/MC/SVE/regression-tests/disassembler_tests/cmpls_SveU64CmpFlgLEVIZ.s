# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x20,0xe0,0x24
# CHECK: cmpls   p0.d, p0/z, z0.d, #0 // encoding: [0x10,0x20,0xe0,0x24]
# CHECK-ERROR-NOT: cmpls   p0.d, p0/z, z0.d, #0 
0xb7,0xed,0xe8,0x24
# CHECK: cmpls   p7.d, p3/z, z13.d, #35 // encoding: [0xb7,0xed,0xe8,0x24]
# CHECK-ERROR-NOT: cmpls   p7.d, p3/z, z13.d, #35 
0xff,0xff,0xff,0x24
# CHECK: cmpls   p15.d, p7/z, z31.d, #127 // encoding: [0xff,0xff,0xff,0x24]
# CHECK-ERROR-NOT: cmpls   p15.d, p7/z, z31.d, #127 
0x55,0x75,0xf5,0x24
# CHECK: cmpls   p5.d, p5/z, z10.d, #85 // encoding: [0x55,0x75,0xf5,0x24]
# CHECK-ERROR-NOT: cmpls   p5.d, p5/z, z10.d, #85 
