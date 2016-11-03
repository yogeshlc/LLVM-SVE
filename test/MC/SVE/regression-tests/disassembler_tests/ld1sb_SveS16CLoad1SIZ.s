# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xa0,0xc0,0xa5
# CHECK: ld1sb   {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0xc0,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z0.h}, p0/z, [x0] 
0xb7,0xad,0xc8,0xa5
# CHECK: ld1sb   {z23.h}, p3/z, [x13, #-8, mul vl] // encoding: [0xb7,0xad,0xc8,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z23.h}, p3/z, [x13, #-8, mul vl] 
0xff,0xbf,0xcf,0xa5
# CHECK: ld1sb   {z31.h}, p7/z, [sp, #-1, mul vl] // encoding: [0xff,0xbf,0xcf,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z31.h}, p7/z, [sp, #-1, mul vl] 
0x55,0xb5,0xc5,0xa5
# CHECK: ld1sb   {z21.h}, p5/z, [x10, #5, mul vl] // encoding: [0x55,0xb5,0xc5,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z21.h}, p5/z, [x10, #5, mul vl] 
