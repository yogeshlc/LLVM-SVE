# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0xd1,0x65
# CHECK: fcmle   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xb7,0x2d,0xd1,0x65]
# CHECK-ERROR-NOT: fcmle   p7.d, p3/z, z13.d, #0.0{{0*}} 
0xff,0x3f,0xd1,0x65
# CHECK: fcmle   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xff,0x3f,0xd1,0x65]
# CHECK-ERROR-NOT: fcmle   p15.d, p7/z, z31.d, #0.0{{0*}} 
0x55,0x35,0xd1,0x65
# CHECK: fcmle   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x55,0x35,0xd1,0x65]
# CHECK-ERROR-NOT: fcmle   p5.d, p5/z, z10.d, #0.0{{0*}} 
0x10,0x20,0xd1,0x65
# CHECK: fcmle   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x10,0x20,0xd1,0x65]
# CHECK-ERROR-NOT: fcmle   p0.d, p0/z, z0.d, #0.0{{0*}} 
