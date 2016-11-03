# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x6d,0xa8,0xe5
# CHECK: st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3] // encoding: [0xb7,0x6d,0xa8,0xe5]
# CHECK-ERROR-NOT: st2d    {z23.d, z24.d}, p3, [x13, x8, lsl #3] 
0x25,0x6e,0xb0,0xe5
# CHECK: st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3] // encoding: [0x25,0x6e,0xb0,0xe5]
# CHECK-ERROR-NOT: st2d    {z5.d, z6.d}, p3, [x17, x16, lsl #3] 
0x55,0x75,0xb5,0xe5
# CHECK: st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3] // encoding: [0x55,0x75,0xb5,0xe5]
# CHECK-ERROR-NOT: st2d    {z21.d, z22.d}, p5, [x10, x21, lsl #3] 
0x00,0x60,0xa0,0xe5
# CHECK: st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3] // encoding: [0x00,0x60,0xa0,0xe5]
# CHECK-ERROR-NOT: st2d    {z0.d, z1.d}, p0, [x0, x0, lsl #3] 
