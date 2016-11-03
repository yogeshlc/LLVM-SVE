# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x20,0xa5
# CHECK: ld2w    {z0.s, z1.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x20,0xa5]
# CHECK-ERROR-NOT: ld2w    {z0.s, z1.s}, p0/z, [x0] 
0xff,0xff,0x2f,0xa5
# CHECK: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl] // encoding: [0xff,0xff,0x2f,0xa5]
# CHECK-ERROR-NOT: ld2w    {z31.s, z0.s}, p7/z, [sp, #-2, mul vl] 
0x55,0xf5,0x25,0xa5
# CHECK: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl] // encoding: [0x55,0xf5,0x25,0xa5]
# CHECK-ERROR-NOT: ld2w    {z21.s, z22.s}, p5/z, [x10, #10, mul vl] 
0xb7,0xed,0x28,0xa5
# CHECK: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0x28,0xa5]
# CHECK-ERROR-NOT: ld2w    {z23.s, z24.s}, p3/z, [x13, #-16, mul vl] 
