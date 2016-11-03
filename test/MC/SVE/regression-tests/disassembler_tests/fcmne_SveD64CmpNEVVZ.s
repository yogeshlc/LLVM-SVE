# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x7f,0xdf,0x65
# CHECK: fcmne   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0x7f,0xdf,0x65]
# CHECK-ERROR-NOT: fcmne   p15.d, p7/z, z31.d, z31.d 
0x55,0x75,0xd5,0x65
# CHECK: fcmne   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0x75,0xd5,0x65]
# CHECK-ERROR-NOT: fcmne   p5.d, p5/z, z10.d, z21.d 
0x10,0x60,0xc0,0x65
# CHECK: fcmne   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0x60,0xc0,0x65]
# CHECK-ERROR-NOT: fcmne   p0.d, p0/z, z0.d, z0.d 
0xb7,0x6d,0xc8,0x65
# CHECK: fcmne   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0x6d,0xc8,0x65]
# CHECK-ERROR-NOT: fcmne   p7.d, p3/z, z13.d, z8.d 
