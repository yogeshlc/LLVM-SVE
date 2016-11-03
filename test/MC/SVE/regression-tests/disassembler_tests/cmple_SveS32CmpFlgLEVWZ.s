# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x7f,0x9f,0x24
# CHECK: cmple   p15.s, p7/z, z31.s, z31.d // encoding: [0xff,0x7f,0x9f,0x24]
# CHECK-ERROR-NOT: cmple   p15.s, p7/z, z31.s, z31.d 
0xb7,0x6d,0x88,0x24
# CHECK: cmple   p7.s, p3/z, z13.s, z8.d // encoding: [0xb7,0x6d,0x88,0x24]
# CHECK-ERROR-NOT: cmple   p7.s, p3/z, z13.s, z8.d 
0x55,0x75,0x95,0x24
# CHECK: cmple   p5.s, p5/z, z10.s, z21.d // encoding: [0x55,0x75,0x95,0x24]
# CHECK-ERROR-NOT: cmple   p5.s, p5/z, z10.s, z21.d 
0x10,0x60,0x80,0x24
# CHECK: cmple   p0.s, p0/z, z0.s, z0.d // encoding: [0x10,0x60,0x80,0x24]
# CHECK-ERROR-NOT: cmple   p0.s, p0/z, z0.s, z0.d 
