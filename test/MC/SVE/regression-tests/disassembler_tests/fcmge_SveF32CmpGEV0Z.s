# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x35,0x90,0x65
# CHECK: fcmge   p5.s, p5/z, z10.s, #0.0{{0*}} // encoding: [0x45,0x35,0x90,0x65]
# CHECK-ERROR-NOT: fcmge   p5.s, p5/z, z10.s, #0.0{{0*}} 
0x00,0x20,0x90,0x65
# CHECK: fcmge   p0.s, p0/z, z0.s, #0.0{{0*}} // encoding: [0x00,0x20,0x90,0x65]
# CHECK-ERROR-NOT: fcmge   p0.s, p0/z, z0.s, #0.0{{0*}} 
0xef,0x3f,0x90,0x65
# CHECK: fcmge   p15.s, p7/z, z31.s, #0.0{{0*}} // encoding: [0xef,0x3f,0x90,0x65]
# CHECK-ERROR-NOT: fcmge   p15.s, p7/z, z31.s, #0.0{{0*}} 
0xa7,0x2d,0x90,0x65
# CHECK: fcmge   p7.s, p3/z, z13.s, #0.0{{0*}} // encoding: [0xa7,0x2d,0x90,0x65]
# CHECK-ERROR-NOT: fcmge   p7.s, p3/z, z13.s, #0.0{{0*}} 
