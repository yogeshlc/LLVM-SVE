# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xa0,0x80,0x24
# CHECK: cmpeq   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0xa0,0x80,0x24]
# CHECK-ERROR-NOT: cmpeq   p0.s, p0/z, z0.s, z0.s 
0xa7,0xad,0x88,0x24
# CHECK: cmpeq   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0xad,0x88,0x24]
# CHECK-ERROR-NOT: cmpeq   p7.s, p3/z, z13.s, z8.s 
0x45,0xb5,0x95,0x24
# CHECK: cmpeq   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0xb5,0x95,0x24]
# CHECK-ERROR-NOT: cmpeq   p5.s, p5/z, z10.s, z21.s 
0xef,0xbf,0x9f,0x24
# CHECK: cmpeq   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0xbf,0x9f,0x24]
# CHECK-ERROR-NOT: cmpeq   p15.s, p7/z, z31.s, z31.s 
