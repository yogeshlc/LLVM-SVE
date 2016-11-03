# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0xc8,0xa5
# CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0xc8,0xa5]
# CHECK-ERROR-NOT: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, #-24, mul vl] 
0xff,0xff,0xcf,0xa5
# CHECK: ld3d    {z31.d, z0.d, z1.d}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0xcf,0xa5]
# CHECK-ERROR-NOT: ld3d    {z31.d, z0.d, z1.d}, p7/z, [sp, #-3, mul vl] 
0x55,0xf5,0xc5,0xa5
# CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0xc5,0xa5]
# CHECK-ERROR-NOT: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, #15, mul vl] 
0x00,0xe0,0xc0,0xa5
# CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0xa5]
# CHECK-ERROR-NOT: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0] 
