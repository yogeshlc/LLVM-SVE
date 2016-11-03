# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x70,0xe4
# CHECK: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0] // encoding: [0x00,0xe0,0x70,0xe4]
# CHECK-ERROR-NOT: st4b    {z0.b, z1.b, z2.b, z3.b}, p0, [x0] 
0xff,0xff,0x7f,0xe4
# CHECK: st4b    {z31.b, z0.b, z1.b, z2.b}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0x7f,0xe4]
# CHECK-ERROR-NOT: st4b    {z31.b, z0.b, z1.b, z2.b}, p7, [sp, #-4, mul vl] 
0x55,0xf5,0x75,0xe4
# CHECK: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0x75,0xe4]
# CHECK-ERROR-NOT: st4b    {z21.b, z22.b, z23.b, z24.b}, p5, [x10, #20, mul vl] 
0xb7,0xed,0x78,0xe4
# CHECK: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0x78,0xe4]
# CHECK-ERROR-NOT: st4b    {z23.b, z24.b, z25.b, z26.b}, p3, [x13, #-32, mul vl] 
