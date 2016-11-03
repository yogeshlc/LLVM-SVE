# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0x80,0x65
# CHECK: fadd    z0.s, z0.s, z0.s // encoding: [0x00,0x00,0x80,0x65]
# CHECK-ERROR-NOT: fadd    z0.s, z0.s, z0.s 
0xff,0x03,0x9f,0x65
# CHECK: fadd    z31.s, z31.s, z31.s // encoding: [0xff,0x03,0x9f,0x65]
# CHECK-ERROR-NOT: fadd    z31.s, z31.s, z31.s 
0xb7,0x01,0x88,0x65
# CHECK: fadd    z23.s, z13.s, z8.s // encoding: [0xb7,0x01,0x88,0x65]
# CHECK-ERROR-NOT: fadd    z23.s, z13.s, z8.s 
0x55,0x01,0x95,0x65
# CHECK: fadd    z21.s, z10.s, z21.s // encoding: [0x55,0x01,0x95,0x65]
# CHECK-ERROR-NOT: fadd    z21.s, z10.s, z21.s 
