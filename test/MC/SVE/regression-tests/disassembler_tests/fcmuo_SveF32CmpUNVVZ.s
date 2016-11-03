# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xd5,0x95,0x65
# CHECK: fcmuo   p5.s, p5/z, z10.s, z21.s // encoding: [0x45,0xd5,0x95,0x65]
# CHECK-ERROR-NOT: fcmuo   p5.s, p5/z, z10.s, z21.s 
0xef,0xdf,0x9f,0x65
# CHECK: fcmuo   p15.s, p7/z, z31.s, z31.s // encoding: [0xef,0xdf,0x9f,0x65]
# CHECK-ERROR-NOT: fcmuo   p15.s, p7/z, z31.s, z31.s 
0xa7,0xcd,0x88,0x65
# CHECK: fcmuo   p7.s, p3/z, z13.s, z8.s // encoding: [0xa7,0xcd,0x88,0x65]
# CHECK-ERROR-NOT: fcmuo   p7.s, p3/z, z13.s, z8.s 
0x00,0xc0,0x80,0x65
# CHECK: fcmuo   p0.s, p0/z, z0.s, z0.s // encoding: [0x00,0xc0,0x80,0x65]
# CHECK-ERROR-NOT: fcmuo   p0.s, p0/z, z0.s, z0.s 
