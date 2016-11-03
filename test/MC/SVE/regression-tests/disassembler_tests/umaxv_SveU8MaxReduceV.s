# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x3f,0x09,0x04
# CHECK: umaxv   b31, p7, z31.b // encoding: [0xff,0x3f,0x09,0x04]
# CHECK-ERROR-NOT: umaxv   b31, p7, z31.b 
0xb7,0x2d,0x09,0x04
# CHECK: umaxv   b23, p3, z13.b // encoding: [0xb7,0x2d,0x09,0x04]
# CHECK-ERROR-NOT: umaxv   b23, p3, z13.b 
0x55,0x35,0x09,0x04
# CHECK: umaxv   b21, p5, z10.b // encoding: [0x55,0x35,0x09,0x04]
# CHECK-ERROR-NOT: umaxv   b21, p5, z10.b 
0x00,0x20,0x09,0x04
# CHECK: umaxv   b0, p0, z0.b // encoding: [0x00,0x20,0x09,0x04]
# CHECK-ERROR-NOT: umaxv   b0, p0, z0.b 
