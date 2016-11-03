# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x75,0x15,0x24
# CHECK: cmple   p5.b, p5/z, z10.b, z21.d // encoding: [0x55,0x75,0x15,0x24]
# CHECK-ERROR-NOT: cmple   p5.b, p5/z, z10.b, z21.d 
0xb7,0x6d,0x08,0x24
# CHECK: cmple   p7.b, p3/z, z13.b, z8.d // encoding: [0xb7,0x6d,0x08,0x24]
# CHECK-ERROR-NOT: cmple   p7.b, p3/z, z13.b, z8.d 
0x10,0x60,0x00,0x24
# CHECK: cmple   p0.b, p0/z, z0.b, z0.d // encoding: [0x10,0x60,0x00,0x24]
# CHECK-ERROR-NOT: cmple   p0.b, p0/z, z0.b, z0.d 
0xff,0x7f,0x1f,0x24
# CHECK: cmple   p15.b, p7/z, z31.b, z31.d // encoding: [0xff,0x7f,0x1f,0x24]
# CHECK-ERROR-NOT: cmple   p15.b, p7/z, z31.b, z31.d 
