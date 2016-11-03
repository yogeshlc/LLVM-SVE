# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x3f,0xd8,0x04
# CHECK: orv     d31, p7, z31.d // encoding: [0xff,0x3f,0xd8,0x04]
# CHECK-ERROR-NOT: orv     d31, p7, z31.d 
0x55,0x35,0xd8,0x04
# CHECK: orv     d21, p5, z10.d // encoding: [0x55,0x35,0xd8,0x04]
# CHECK-ERROR-NOT: orv     d21, p5, z10.d 
0x00,0x20,0xd8,0x04
# CHECK: orv     d0, p0, z0.d // encoding: [0x00,0x20,0xd8,0x04]
# CHECK-ERROR-NOT: orv     d0, p0, z0.d 
0xb7,0x2d,0xd8,0x04
# CHECK: orv     d23, p3, z13.d // encoding: [0xb7,0x2d,0xd8,0x04]
# CHECK-ERROR-NOT: orv     d23, p3, z13.d 
