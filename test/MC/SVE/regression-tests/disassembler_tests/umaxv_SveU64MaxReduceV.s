# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x35,0xc9,0x04
# CHECK: umaxv   d21, p5, z10.d // encoding: [0x55,0x35,0xc9,0x04]
# CHECK-ERROR-NOT: umaxv   d21, p5, z10.d 
0xff,0x3f,0xc9,0x04
# CHECK: umaxv   d31, p7, z31.d // encoding: [0xff,0x3f,0xc9,0x04]
# CHECK-ERROR-NOT: umaxv   d31, p7, z31.d 
0x00,0x20,0xc9,0x04
# CHECK: umaxv   d0, p0, z0.d // encoding: [0x00,0x20,0xc9,0x04]
# CHECK-ERROR-NOT: umaxv   d0, p0, z0.d 
0xb7,0x2d,0xc9,0x04
# CHECK: umaxv   d23, p3, z13.d // encoding: [0xb7,0x2d,0xc9,0x04]
# CHECK-ERROR-NOT: umaxv   d23, p3, z13.d 
