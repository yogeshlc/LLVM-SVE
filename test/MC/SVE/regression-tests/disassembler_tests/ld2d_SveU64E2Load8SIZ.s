# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xa5,0xa5
# CHECK: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa5]
# CHECK-ERROR-NOT: ld2d    {z21.d, z22.d}, p5/z, [x10, #10, mul vl] 
0x00,0xe0,0xa0,0xa5
# CHECK: ld2d    {z0.d, z1.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa5]
# CHECK-ERROR-NOT: ld2d    {z0.d, z1.d}, p0/z, [x0] 
0xb7,0xed,0xa8,0xa5
# CHECK: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa5]
# CHECK-ERROR-NOT: ld2d    {z23.d, z24.d}, p3/z, [x13, #-16, mul vl] 
0xff,0xff,0xaf,0xa5
# CHECK: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa5]
# CHECK-ERROR-NOT: ld2d    {z31.d, z0.d}, p7/z, [sp, #-2, mul vl] 
