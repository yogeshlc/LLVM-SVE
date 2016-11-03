# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0xa8,0xa4
# CHECK: ld2h    {z23.h, z24.h}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xa8,0xa4]
# CHECK-ERROR-NOT: ld2h    {z23.h, z24.h}, p3/z, [x13, #-16, mul vl] 
0x55,0xf5,0xa5,0xa4
# CHECK: ld2h    {z21.h, z22.h}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xa5,0xa4]
# CHECK-ERROR-NOT: ld2h    {z21.h, z22.h}, p5/z, [x10, #10, mul vl] 
0xff,0xff,0xaf,0xa4
# CHECK: ld2h    {z31.h, z0.h}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xaf,0xa4]
# CHECK-ERROR-NOT: ld2h    {z31.h, z0.h}, p7/z, [sp, #-2, mul vl] 
0x00,0xe0,0xa0,0xa4
# CHECK: ld2h    {z0.h, z1.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xa0,0xa4]
# CHECK-ERROR-NOT: ld2h    {z0.h, z1.h}, p0/z, [x0] 
