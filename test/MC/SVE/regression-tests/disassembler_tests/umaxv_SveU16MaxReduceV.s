# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x3f,0x49,0x04
# CHECK: umaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x49,0x04]
# CHECK-ERROR-NOT: umaxv   h31, p7, z31.h 
0xb7,0x2d,0x49,0x04
# CHECK: umaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x49,0x04]
# CHECK-ERROR-NOT: umaxv   h23, p3, z13.h 
0x55,0x35,0x49,0x04
# CHECK: umaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x49,0x04]
# CHECK-ERROR-NOT: umaxv   h21, p5, z10.h 
0x00,0x20,0x49,0x04
# CHECK: umaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x49,0x04]
# CHECK-ERROR-NOT: umaxv   h0, p0, z0.h 
