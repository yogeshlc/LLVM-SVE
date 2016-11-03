# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x20,0xd0,0x65
# CHECK: fcmgt   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x10,0x20,0xd0,0x65]
# CHECK-ERROR-NOT: fcmgt   p0.d, p0/z, z0.d, #0.0{{0*}} 
0xb7,0x2d,0xd0,0x65
# CHECK: fcmgt   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xb7,0x2d,0xd0,0x65]
# CHECK-ERROR-NOT: fcmgt   p7.d, p3/z, z13.d, #0.0{{0*}} 
0xff,0x3f,0xd0,0x65
# CHECK: fcmgt   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xff,0x3f,0xd0,0x65]
# CHECK-ERROR-NOT: fcmgt   p15.d, p7/z, z31.d, #0.0{{0*}} 
0x55,0x35,0xd0,0x65
# CHECK: fcmgt   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x55,0x35,0xd0,0x65]
# CHECK-ERROR-NOT: fcmgt   p5.d, p5/z, z10.d, #0.0{{0*}} 
