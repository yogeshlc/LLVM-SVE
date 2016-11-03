# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0xd8,0x65
# CHECK: fadda   d23, p3, d23, z13.d // encoding: [0xb7,0x2d,0xd8,0x65]
# CHECK-ERROR-NOT: fadda   d23, p3, d23, z13.d 
0x00,0x20,0xd8,0x65
# CHECK: fadda   d0, p0, d0, z0.d // encoding: [0x00,0x20,0xd8,0x65]
# CHECK-ERROR-NOT: fadda   d0, p0, d0, z0.d 
0x55,0x35,0xd8,0x65
# CHECK: fadda   d21, p5, d21, z10.d // encoding: [0x55,0x35,0xd8,0x65]
# CHECK-ERROR-NOT: fadda   d21, p5, d21, z10.d 
0xff,0x3f,0xd8,0x65
# CHECK: fadda   d31, p7, d31, z31.d // encoding: [0xff,0x3f,0xd8,0x65]
# CHECK-ERROR-NOT: fadda   d31, p7, d31, z31.d 
