# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0x8f,0xa5
# CHECK: ldnt1d  {z31.d}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x8f,0xa5]
# CHECK-ERROR-NOT: ldnt1d  {z31.d}, p7/z, [sp, #-1, mul vl] 
0x55,0xf5,0x85,0xa5
# CHECK: ldnt1d  {z21.d}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x85,0xa5]
# CHECK-ERROR-NOT: ldnt1d  {z21.d}, p5/z, [x10, #5, mul vl] 
0x00,0xe0,0x80,0xa5
# CHECK: ldnt1d  {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0x80,0xa5]
# CHECK-ERROR-NOT: ldnt1d  {z0.d}, p0/z, [x0] 
0xb7,0xed,0x88,0xa5
# CHECK: ldnt1d  {z23.d}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x88,0xa5]
# CHECK-ERROR-NOT: ldnt1d  {z23.d}, p3/z, [x13, #-8, mul vl] 
