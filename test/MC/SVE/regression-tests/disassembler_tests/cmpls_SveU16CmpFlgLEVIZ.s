# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x20,0x60,0x24
# CHECK: cmpls   p0.h, p0/z, z0.h, #0 // encoding: [0x10,0x20,0x60,0x24]
# CHECK-ERROR-NOT: cmpls   p0.h, p0/z, z0.h, #0 
0x55,0x75,0x75,0x24
# CHECK: cmpls   p5.h, p5/z, z10.h, #85 // encoding: [0x55,0x75,0x75,0x24]
# CHECK-ERROR-NOT: cmpls   p5.h, p5/z, z10.h, #85 
0xff,0xff,0x7f,0x24
# CHECK: cmpls   p15.h, p7/z, z31.h, #127 // encoding: [0xff,0xff,0x7f,0x24]
# CHECK-ERROR-NOT: cmpls   p15.h, p7/z, z31.h, #127 
0xb7,0xed,0x68,0x24
# CHECK: cmpls   p7.h, p3/z, z13.h, #35 // encoding: [0xb7,0xed,0x68,0x24]
# CHECK-ERROR-NOT: cmpls   p7.h, p3/z, z13.h, #35 
