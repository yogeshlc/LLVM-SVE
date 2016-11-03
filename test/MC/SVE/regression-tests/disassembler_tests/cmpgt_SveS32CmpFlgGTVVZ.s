# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x9f,0x24
# CHECK: cmpgt   p15.s, p7/z, z31.s, z31.s // encoding: [0xff,0x9f,0x9f,0x24]
# CHECK-ERROR-NOT: cmpgt   p15.s, p7/z, z31.s, z31.s 
0xb7,0x8d,0x88,0x24
# CHECK: cmpgt   p7.s, p3/z, z13.s, z8.s // encoding: [0xb7,0x8d,0x88,0x24]
# CHECK-ERROR-NOT: cmpgt   p7.s, p3/z, z13.s, z8.s 
0x55,0x95,0x95,0x24
# CHECK: cmpgt   p5.s, p5/z, z10.s, z21.s // encoding: [0x55,0x95,0x95,0x24]
# CHECK-ERROR-NOT: cmpgt   p5.s, p5/z, z10.s, z21.s 
0x10,0x80,0x80,0x24
# CHECK: cmpgt   p0.s, p0/z, z0.s, z0.s // encoding: [0x10,0x80,0x80,0x24]
# CHECK-ERROR-NOT: cmpgt   p0.s, p0/z, z0.s, z0.s 
