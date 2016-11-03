# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0x48,0xa4
# CHECK: ld1b    {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0x48,0xa4]
# CHECK-ERROR-NOT: ld1b    {z23.s}, p3/z, [x13, #-8, mul vl] 
0x00,0xa0,0x40,0xa4
# CHECK: ld1b    {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0xa4]
# CHECK-ERROR-NOT: ld1b    {z0.s}, p0/z, [x0] 
0xff,0xbf,0x4f,0xa4
# CHECK: ld1b    {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0x4f,0xa4]
# CHECK-ERROR-NOT: ld1b    {z31.s}, p7/z, [sp, #-1, mul vl] 
0x55,0xb5,0x45,0xa4
# CHECK: ld1b    {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0x45,0xa4]
# CHECK-ERROR-NOT: ld1b    {z21.s}, p5/z, [x10, #5, mul vl] 
