# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0xe0,0xa5
# CHECK: ld1d    {z0.d}, p0/z, [x0, x0, lsl #3] // encoding: [0x00,0x40,0xe0,0xa5]
# CHECK-ERROR-NOT: ld1d    {z0.d}, p0/z, [x0, x0, lsl #3] 
0x25,0x4e,0xf0,0xa5
# CHECK: ld1d    {z5.d}, p3/z, [x17, x16, lsl #3] // encoding: [0x25,0x4e,0xf0,0xa5]
# CHECK-ERROR-NOT: ld1d    {z5.d}, p3/z, [x17, x16, lsl #3] 
0xb7,0x4d,0xe8,0xa5
# CHECK: ld1d    {z23.d}, p3/z, [x13, x8, lsl #3] // encoding: [0xb7,0x4d,0xe8,0xa5]
# CHECK-ERROR-NOT: ld1d    {z23.d}, p3/z, [x13, x8, lsl #3] 
0x55,0x55,0xf5,0xa5
# CHECK: ld1d    {z21.d}, p5/z, [x10, x21, lsl #3] // encoding: [0x55,0x55,0xf5,0xa5]
# CHECK-ERROR-NOT: ld1d    {z21.d}, p5/z, [x10, x21, lsl #3] 
