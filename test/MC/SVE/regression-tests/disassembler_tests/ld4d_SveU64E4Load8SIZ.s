# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xe5,0xa5
# CHECK: ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xe5,0xa5]
# CHECK-ERROR-NOT: ld4d    {z21.d, z22.d, z23.d, z24.d}, p5/z, [x10, #20, mul vl] 
0xb7,0xed,0xe8,0xa5
# CHECK: ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xe8,0xa5]
# CHECK-ERROR-NOT: ld4d    {z23.d, z24.d, z25.d, z26.d}, p3/z, [x13, #-32, mul vl] 
0xff,0xff,0xef,0xa5
# CHECK: ld4d    {z31.d, z0.d, z1.d, z2.d}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xef,0xa5]
# CHECK-ERROR-NOT: ld4d    {z31.d, z0.d, z1.d, z2.d}, p7/z, [sp, #-4, mul vl] 
0x00,0xe0,0xe0,0xa5
# CHECK: ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xe0,0xa5]
# CHECK-ERROR-NOT: ld4d    {z0.d, z1.d, z2.d, z3.d}, p0/z, [x0] 
