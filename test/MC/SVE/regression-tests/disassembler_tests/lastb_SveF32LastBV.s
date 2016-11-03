# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0xa3,0x05
# CHECK: lastb   s23, p3, z13.s // encoding: [0xb7,0x8d,0xa3,0x05]
# CHECK-ERROR-NOT: lastb   s23, p3, z13.s 
0x55,0x95,0xa3,0x05
# CHECK: lastb   s21, p5, z10.s // encoding: [0x55,0x95,0xa3,0x05]
# CHECK-ERROR-NOT: lastb   s21, p5, z10.s 
0x00,0x80,0xa3,0x05
# CHECK: lastb   s0, p0, z0.s // encoding: [0x00,0x80,0xa3,0x05]
# CHECK-ERROR-NOT: lastb   s0, p0, z0.s 
0xff,0x9f,0xa3,0x05
# CHECK: lastb   s31, p7, z31.s // encoding: [0xff,0x9f,0xa3,0x05]
# CHECK-ERROR-NOT: lastb   s31, p7, z31.s 
