# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x20,0x84,0x65
# CHECK: fmaxnmv s0, p0, z0.s // encoding: [0x00,0x20,0x84,0x65]
# CHECK-ERROR-NOT: fmaxnmv s0, p0, z0.s 
0x55,0x35,0x84,0x65
# CHECK: fmaxnmv s21, p5, z10.s // encoding: [0x55,0x35,0x84,0x65]
# CHECK-ERROR-NOT: fmaxnmv s21, p5, z10.s 
0xff,0x3f,0x84,0x65
# CHECK: fmaxnmv s31, p7, z31.s // encoding: [0xff,0x3f,0x84,0x65]
# CHECK-ERROR-NOT: fmaxnmv s31, p7, z31.s 
0xb7,0x2d,0x84,0x65
# CHECK: fmaxnmv s23, p3, z13.s // encoding: [0xb7,0x2d,0x84,0x65]
# CHECK-ERROR-NOT: fmaxnmv s23, p3, z13.s 
