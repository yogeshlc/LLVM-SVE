# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x10,0xe5
# CHECK: stnt1w  {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0x10,0xe5]
# CHECK-ERROR-NOT: stnt1w  {z0.s}, p0, [x0] 
0x55,0xf5,0x15,0xe5
# CHECK: stnt1w  {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x15,0xe5]
# CHECK-ERROR-NOT: stnt1w  {z21.s}, p5, [x10, #5, mul vl] 
0xff,0xff,0x1f,0xe5
# CHECK: stnt1w  {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x1f,0xe5]
# CHECK-ERROR-NOT: stnt1w  {z31.s}, p7, [sp, #-1, mul vl] 
0xb7,0xed,0x18,0xe5
# CHECK: stnt1w  {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x18,0xe5]
# CHECK-ERROR-NOT: stnt1w  {z23.s}, p3, [x13, #-8, mul vl] 
