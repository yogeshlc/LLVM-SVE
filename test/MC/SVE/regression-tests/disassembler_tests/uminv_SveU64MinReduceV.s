# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x20,0xcb,0x04
# CHECK: uminv   d0, p0, z0.d // encoding: [0x00,0x20,0xcb,0x04]
# CHECK-ERROR-NOT: uminv   d0, p0, z0.d 
0xb7,0x2d,0xcb,0x04
# CHECK: uminv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xcb,0x04]
# CHECK-ERROR-NOT: uminv   d23, p3, z13.d 
0x55,0x35,0xcb,0x04
# CHECK: uminv   d21, p5, z10.d // encoding: [0x55,0x35,0xcb,0x04]
# CHECK-ERROR-NOT: uminv   d21, p5, z10.d 
0xff,0x3f,0xcb,0x04
# CHECK: uminv   d31, p7, z31.d // encoding: [0xff,0x3f,0xcb,0x04]
# CHECK-ERROR-NOT: uminv   d31, p7, z31.d 
