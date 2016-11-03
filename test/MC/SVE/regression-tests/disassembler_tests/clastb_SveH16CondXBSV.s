# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x6b,0x05
# CHECK: clastb  h23, p3, h23, z13.h // encoding: [0xb7,0x8d,0x6b,0x05]
# CHECK-ERROR-NOT: clastb  h23, p3, h23, z13.h 
0x55,0x95,0x6b,0x05
# CHECK: clastb  h21, p5, h21, z10.h // encoding: [0x55,0x95,0x6b,0x05]
# CHECK-ERROR-NOT: clastb  h21, p5, h21, z10.h 
0x00,0x80,0x6b,0x05
# CHECK: clastb  h0, p0, h0, z0.h // encoding: [0x00,0x80,0x6b,0x05]
# CHECK-ERROR-NOT: clastb  h0, p0, h0, z0.h 
0xff,0x9f,0x6b,0x05
# CHECK: clastb  h31, p7, h31, z31.h // encoding: [0xff,0x9f,0x6b,0x05]
# CHECK-ERROR-NOT: clastb  h31, p7, h31, z31.h 
