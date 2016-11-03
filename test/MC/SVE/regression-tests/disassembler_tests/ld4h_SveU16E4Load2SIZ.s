# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0xef,0xa4
# CHECK: ld4h    {z31.h, z0.h, z1.h, z2.h}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xef,0xa4]
# CHECK-ERROR-NOT: ld4h    {z31.h, z0.h, z1.h, z2.h}, p7/z, [sp, #-4, mul vl] 
0xb7,0xed,0xe8,0xa4
# CHECK: ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xe8,0xa4]
# CHECK-ERROR-NOT: ld4h    {z23.h, z24.h, z25.h, z26.h}, p3/z, [x13, #-32, mul vl] 
0x00,0xe0,0xe0,0xa4
# CHECK: ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xe0,0xa4]
# CHECK-ERROR-NOT: ld4h    {z0.h, z1.h, z2.h, z3.h}, p0/z, [x0] 
0x55,0xf5,0xe5,0xa4
# CHECK: ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xe5,0xa4]
# CHECK-ERROR-NOT: ld4h    {z21.h, z22.h, z23.h, z24.h}, p5/z, [x10, #20, mul vl] 
