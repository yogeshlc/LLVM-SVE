# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x3f,0x84
# CHECK: ld1sb   {z31.s}, p7/z, [z31.s, #31] // encoding: [0xff,0x9f,0x3f,0x84]
# CHECK-ERROR-NOT: ld1sb   {z31.s}, p7/z, [z31.s, #31] 
0x00,0x80,0x20,0x84
# CHECK: ld1sb   {z0.s}, p0/z, [z0.s] // encoding: [0x00,0x80,0x20,0x84]
# CHECK-ERROR-NOT: ld1sb   {z0.s}, p0/z, [z0.s] 
0xb7,0x8d,0x28,0x84
# CHECK: ld1sb   {z23.s}, p3/z, [z13.s, #8] // encoding: [0xb7,0x8d,0x28,0x84]
# CHECK-ERROR-NOT: ld1sb   {z23.s}, p3/z, [z13.s, #8] 
0x55,0x95,0x35,0x84
# CHECK: ld1sb   {z21.s}, p5/z, [z10.s, #21] // encoding: [0x55,0x95,0x35,0x84]
# CHECK-ERROR-NOT: ld1sb   {z21.s}, p5/z, [z10.s, #21] 
