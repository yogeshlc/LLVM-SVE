# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x70,0xe5
# CHECK: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0] // encoding: [0x00,0xe0,0x70,0xe5]
# CHECK-ERROR-NOT: st4w    {z0.s, z1.s, z2.s, z3.s}, p0, [x0] 
0xb7,0xed,0x78,0xe5
# CHECK: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0x78,0xe5]
# CHECK-ERROR-NOT: st4w    {z23.s, z24.s, z25.s, z26.s}, p3, [x13, #-32, mul vl] 
0xff,0xff,0x7f,0xe5
# CHECK: st4w    {z31.s, z0.s, z1.s, z2.s}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0x7f,0xe5]
# CHECK-ERROR-NOT: st4w    {z31.s, z0.s, z1.s, z2.s}, p7, [sp, #-4, mul vl] 
0x55,0xf5,0x75,0xe5
# CHECK: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0x75,0xe5]
# CHECK-ERROR-NOT: st4w    {z21.s, z22.s, z23.s, z24.s}, p5, [x10, #20, mul vl] 
