# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x60,0xc5
# CHECK: ld1sw   {z0.d}, p0/z, [x0, z0.d, lsl #2] // encoding: [0x00,0x80,0x60,0xc5]
# CHECK-ERROR-NOT: ld1sw   {z0.d}, p0/z, [x0, z0.d, lsl #2] 
0xb7,0x8d,0x68,0xc5
# CHECK: ld1sw   {z23.d}, p3/z, [x13, z8.d, lsl #2] // encoding: [0xb7,0x8d,0x68,0xc5]
# CHECK-ERROR-NOT: ld1sw   {z23.d}, p3/z, [x13, z8.d, lsl #2] 
0x55,0x95,0x75,0xc5
# CHECK: ld1sw   {z21.d}, p5/z, [x10, z21.d, lsl #2] // encoding: [0x55,0x95,0x75,0xc5]
# CHECK-ERROR-NOT: ld1sw   {z21.d}, p5/z, [x10, z21.d, lsl #2] 
0xff,0x9f,0x7f,0xc5
# CHECK: ld1sw   {z31.d}, p7/z, [sp, z31.d, lsl #2] // encoding: [0xff,0x9f,0x7f,0xc5]
# CHECK-ERROR-NOT: ld1sw   {z31.d}, p7/z, [sp, z31.d, lsl #2] 
