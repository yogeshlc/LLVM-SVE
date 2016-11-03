# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x63,0x05
# CHECK: lastb   h31, p7, z31.h // encoding: [0xff,0x9f,0x63,0x05]
# CHECK-ERROR-NOT: lastb   h31, p7, z31.h 
0xb7,0x8d,0x63,0x05
# CHECK: lastb   h23, p3, z13.h // encoding: [0xb7,0x8d,0x63,0x05]
# CHECK-ERROR-NOT: lastb   h23, p3, z13.h 
0x55,0x95,0x63,0x05
# CHECK: lastb   h21, p5, z10.h // encoding: [0x55,0x95,0x63,0x05]
# CHECK-ERROR-NOT: lastb   h21, p5, z10.h 
0x00,0x80,0x63,0x05
# CHECK: lastb   h0, p0, z0.h // encoding: [0x00,0x80,0x63,0x05]
# CHECK-ERROR-NOT: lastb   h0, p0, z0.h 
