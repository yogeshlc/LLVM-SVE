# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x09,0x95,0x65
# CHECK: fmul    z21.s, z10.s, z21.s // encoding: [0x55,0x09,0x95,0x65]
# CHECK-ERROR-NOT: fmul    z21.s, z10.s, z21.s 
0xff,0x0b,0x9f,0x65
# CHECK: fmul    z31.s, z31.s, z31.s // encoding: [0xff,0x0b,0x9f,0x65]
# CHECK-ERROR-NOT: fmul    z31.s, z31.s, z31.s 
0xb7,0x09,0x88,0x65
# CHECK: fmul    z23.s, z13.s, z8.s // encoding: [0xb7,0x09,0x88,0x65]
# CHECK-ERROR-NOT: fmul    z23.s, z13.s, z8.s 
0x00,0x08,0x80,0x65
# CHECK: fmul    z0.s, z0.s, z0.s // encoding: [0x00,0x08,0x80,0x65]
# CHECK-ERROR-NOT: fmul    z0.s, z0.s, z0.s 
