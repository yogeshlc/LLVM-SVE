# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0x58,0xe5
# CHECK: st3w    {z23.s, z24.s, z25.s}, p3, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0x58,0xe5]
# CHECK-ERROR-NOT: st3w    {z23.s, z24.s, z25.s}, p3, [x13, #-24, mul vl] 
0x55,0xf5,0x55,0xe5
# CHECK: st3w    {z21.s, z22.s, z23.s}, p5, [x10, #15, mul vl] // encoding: [0x55,0xf5,0x55,0xe5]
# CHECK-ERROR-NOT: st3w    {z21.s, z22.s, z23.s}, p5, [x10, #15, mul vl] 
0x00,0xe0,0x50,0xe5
# CHECK: st3w    {z0.s, z1.s, z2.s}, p0, [x0] // encoding: [0x00,0xe0,0x50,0xe5]
# CHECK-ERROR-NOT: st3w    {z0.s, z1.s, z2.s}, p0, [x0] 
0xff,0xff,0x5f,0xe5
# CHECK: st3w    {z31.s, z0.s, z1.s}, p7, [sp, #-3, mul vl] // encoding: [0xff,0xff,0x5f,0xe5]
# CHECK-ERROR-NOT: st3w    {z31.s, z0.s, z1.s}, p7, [sp, #-3, mul vl] 
