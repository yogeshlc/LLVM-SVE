# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0xd5,0xa5
# CHECK: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0xd5,0xd5,0xa5]
# CHECK-ERROR-NOT: ld3d    {z21.d, z22.d, z23.d}, p5/z, [x10, x21, lsl #3] 
0x00,0xc0,0xc0,0xa5
# CHECK: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0xc0,0xa5]
# CHECK-ERROR-NOT: ld3d    {z0.d, z1.d, z2.d}, p0/z, [x0, x0, lsl #3] 
0x25,0xce,0xd0,0xa5
# CHECK: ld3d    {z5.d, z6.d, z7.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0xce,0xd0,0xa5]
# CHECK-ERROR-NOT: ld3d    {z5.d, z6.d, z7.d}, p3/z, [x17, x16, lsl #3] 
0xb7,0xcd,0xc8,0xa5
# CHECK: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0xcd,0xc8,0xa5]
# CHECK-ERROR-NOT: ld3d    {z23.d, z24.d, z25.d}, p3/z, [x13, x8, lsl #3] 
