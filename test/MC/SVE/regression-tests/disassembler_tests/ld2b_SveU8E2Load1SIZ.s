# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0x2f,0xa4
# CHECK: ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa4]
# CHECK-ERROR-NOT: ld2b    {z31.b, z0.b}, p7/z, [sp, #-2, mul vl] 
0x55,0xf5,0x25,0xa4
# CHECK: ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa4]
# CHECK-ERROR-NOT: ld2b    {z21.b, z22.b}, p5/z, [x10, #10, mul vl] 
0x00,0xe0,0x20,0xa4
# CHECK: ld2b    {z0.b, z1.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa4]
# CHECK-ERROR-NOT: ld2b    {z0.b, z1.b}, p0/z, [x0] 
0xb7,0xed,0x28,0xa4
# CHECK: ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa4]
# CHECK-ERROR-NOT: ld2b    {z23.b, z24.b}, p3/z, [x13, #-16, mul vl] 
