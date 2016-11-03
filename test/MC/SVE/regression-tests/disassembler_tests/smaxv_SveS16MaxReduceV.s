# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x35,0x48,0x04
# CHECK: smaxv   h21, p5, z10.h // encoding: [0x55,0x35,0x48,0x04]
# CHECK-ERROR-NOT: smaxv   h21, p5, z10.h 
0x00,0x20,0x48,0x04
# CHECK: smaxv   h0, p0, z0.h // encoding: [0x00,0x20,0x48,0x04]
# CHECK-ERROR-NOT: smaxv   h0, p0, z0.h 
0xb7,0x2d,0x48,0x04
# CHECK: smaxv   h23, p3, z13.h // encoding: [0xb7,0x2d,0x48,0x04]
# CHECK-ERROR-NOT: smaxv   h23, p3, z13.h 
0xff,0x3f,0x48,0x04
# CHECK: smaxv   h31, p7, z31.h // encoding: [0xff,0x3f,0x48,0x04]
# CHECK-ERROR-NOT: smaxv   h31, p7, z31.h 
