# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x40,0xa5
# CHECK: ld3w    {z0.s, z1.s, z2.s}, p0/z, [x0] // encoding: [0x00,0xe0,0x40,0xa5]
# CHECK-ERROR-NOT: ld3w    {z0.s, z1.s, z2.s}, p0/z, [x0] 
0xb7,0xed,0x48,0xa5
# CHECK: ld3w    {z23.s, z24.s, z25.s}, p3/z, [x13, #-24, mul vl] // encoding: [0xb7,0xed,0x48,0xa5]
# CHECK-ERROR-NOT: ld3w    {z23.s, z24.s, z25.s}, p3/z, [x13, #-24, mul vl] 
0x55,0xf5,0x45,0xa5
# CHECK: ld3w    {z21.s, z22.s, z23.s}, p5/z, [x10, #15, mul vl] // encoding: [0x55,0xf5,0x45,0xa5]
# CHECK-ERROR-NOT: ld3w    {z21.s, z22.s, z23.s}, p5/z, [x10, #15, mul vl] 
0xff,0xff,0x4f,0xa5
# CHECK: ld3w    {z31.s, z0.s, z1.s}, p7/z, [sp, #-3, mul vl] // encoding: [0xff,0xff,0x4f,0xa5]
# CHECK-ERROR-NOT: ld3w    {z31.s, z0.s, z1.s}, p7/z, [sp, #-3, mul vl] 
