# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xc8,0xa4
# CHECK: ld1h    {z23.s}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xc8,0xa4]
# CHECK-ERROR-NOT: ld1h    {z23.s}, p3/z, [x13, #-8, mul vl] 
0x00,0xa0,0xc0,0xa4
# CHECK: ld1h    {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0xc0,0xa4]
# CHECK-ERROR-NOT: ld1h    {z0.s}, p0/z, [x0] 
0x55,0xb5,0xc5,0xa4
# CHECK: ld1h    {z21.s}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xc5,0xa4]
# CHECK-ERROR-NOT: ld1h    {z21.s}, p5/z, [x10, #5, mul vl] 
0xff,0xbf,0xcf,0xa4
# CHECK: ld1h    {z31.s}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xcf,0xa4]
# CHECK-ERROR-NOT: ld1h    {z31.s}, p7/z, [sp, #-1, mul vl] 
