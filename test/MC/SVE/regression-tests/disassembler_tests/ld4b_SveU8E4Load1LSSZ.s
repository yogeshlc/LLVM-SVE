# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0x75,0xa4
# CHECK: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, x21] // encoding: [0x55,0xd5,0x75,0xa4]
# CHECK-ERROR-NOT: ld4b    {z21.b, z22.b, z23.b, z24.b}, p5/z, [x10, x21] 
0x25,0xce,0x70,0xa4
# CHECK: ld4b    {z5.b, z6.b, z7.b, z8.b}, p3/z, [x17, x16] // encoding: [0x25,0xce,0x70,0xa4]
# CHECK-ERROR-NOT: ld4b    {z5.b, z6.b, z7.b, z8.b}, p3/z, [x17, x16] 
0xb7,0xcd,0x68,0xa4
# CHECK: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, x8] // encoding: [0xb7,0xcd,0x68,0xa4]
# CHECK-ERROR-NOT: ld4b    {z23.b, z24.b, z25.b, z26.b}, p3/z, [x13, x8] 
0x00,0xc0,0x60,0xa4
# CHECK: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x0] // encoding: [0x00,0xc0,0x60,0xa4]
# CHECK-ERROR-NOT: ld4b    {z0.b, z1.b, z2.b, z3.b}, p0/z, [x0, x0] 
