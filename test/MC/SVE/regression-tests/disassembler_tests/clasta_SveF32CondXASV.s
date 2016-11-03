# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0xaa,0x05
# CHECK: clasta  s23, p3, s23, z13.s // encoding: [0xb7,0x8d,0xaa,0x05]
# CHECK-ERROR-NOT: clasta  s23, p3, s23, z13.s 
0x00,0x80,0xaa,0x05
# CHECK: clasta  s0, p0, s0, z0.s // encoding: [0x00,0x80,0xaa,0x05]
# CHECK-ERROR-NOT: clasta  s0, p0, s0, z0.s 
0x55,0x95,0xaa,0x05
# CHECK: clasta  s21, p5, s21, z10.s // encoding: [0x55,0x95,0xaa,0x05]
# CHECK-ERROR-NOT: clasta  s21, p5, s21, z10.s 
0xff,0x9f,0xaa,0x05
# CHECK: clasta  s31, p7, s31, z31.s // encoding: [0xff,0x9f,0xaa,0x05]
# CHECK-ERROR-NOT: clasta  s31, p7, s31, z31.s 
