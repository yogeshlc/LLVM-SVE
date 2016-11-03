# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0x65,0xa4
# CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, #20, mul vl] // encoding: [0x55,0xf5,0x65,0xa4]
# CHECK-ERROR-NOT: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, #20, mul vl] 
0x00,0xe0,0x60,0xa4
# CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0] // encoding: [0x00,0xe0,0x60,0xa4]
# CHECK-ERROR-NOT: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0] 
0xb7,0xed,0x68,0xa4
# CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0x68,0xa4]
# CHECK-ERROR-NOT: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, #-32, mul vl] 
0xff,0xff,0x6f,0xa4
# CHECK: ld4b    {z31.b, z0.b, z1.b, z2.b}, p7/z, [sp, #-4, mul vl] // encoding: [0xff,0xff,0x6f,0xa4]
# CHECK-ERROR-NOT: ld4b    {z31.b, z0.b, z1.b, z2.b}, p7/z, [sp, #-4, mul vl] 
