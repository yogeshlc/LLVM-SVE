# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0x48,0xa4
# CHECK: ld3b    {z23.b, z24.b, z25.b}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0x48,0xa4]
# CHECK-ERROR-NOT: ld3b    {z23.b, z24.b, z25.b}, p3/z, [x13, #-24, mul vl] 
0xff,0xff,0x4f,0xa4
# CHECK: ld3b    {z31.b, z0.b, z1.b}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0x4f,0xa4]
# CHECK-ERROR-NOT: ld3b    {z31.b, z0.b, z1.b}, p7/z, [sp, #-3, mul vl] 
0x00,0xe0,0x40,0xa4
# CHECK: ld3b    {z0.b, z1.b, z2.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x40,0xa4]
# CHECK-ERROR-NOT: ld3b    {z0.b, z1.b, z2.b}, p0/z, [x0] 
0x55,0xf5,0x45,0xa4
# CHECK: ld3b    {z21.b, z22.b, z23.b}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0x45,0xa4]
# CHECK-ERROR-NOT: ld3b    {z21.b, z22.b, z23.b}, p5/z, [x10, #15, mul vl] 
