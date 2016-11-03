# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xc5,0xa4
# CHECK: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xc5,0xa4]
# CHECK-ERROR-NOT: ld3h    {z21.h, z22.h, z23.h}, p5/z, [x10, #15, mul vl] 
0xff,0xff,0xcf,0xa4
# CHECK: ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xcf,0xa4]
# CHECK-ERROR-NOT: ld3h    {z31.h, z0.h, z1.h}, p7/z, [sp, #-3, mul vl] 
0x00,0xe0,0xc0,0xa4
# CHECK: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0xa4]
# CHECK-ERROR-NOT: ld3h    {z0.h, z1.h, z2.h}, p0/z, [x0] 
0xb7,0xed,0xc8,0xa4
# CHECK: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xc8,0xa4]
# CHECK-ERROR-NOT: ld3h    {z23.h, z24.h, z25.h}, p3/z, [x13, #-24, mul vl] 
