# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0x88,0x24
# CHECK: cmpls   p7.s, p3/z, z13.s, z8.d // encoding: [0xb7,0xed,0x88,0x24]
# CHECK-ERROR-NOT: cmpls   p7.s, p3/z, z13.s, z8.d 
0x55,0xf5,0x95,0x24
# CHECK: cmpls   p5.s, p5/z, z10.s, z21.d // encoding: [0x55,0xf5,0x95,0x24]
# CHECK-ERROR-NOT: cmpls   p5.s, p5/z, z10.s, z21.d 
0x10,0xe0,0x80,0x24
# CHECK: cmpls   p0.s, p0/z, z0.s, z0.d // encoding: [0x10,0xe0,0x80,0x24]
# CHECK-ERROR-NOT: cmpls   p0.s, p0/z, z0.s, z0.d 
0xff,0xff,0x9f,0x24
# CHECK: cmpls   p15.s, p7/z, z31.s, z31.d // encoding: [0xff,0xff,0x9f,0x24]
# CHECK-ERROR-NOT: cmpls   p15.s, p7/z, z31.s, z31.d 
