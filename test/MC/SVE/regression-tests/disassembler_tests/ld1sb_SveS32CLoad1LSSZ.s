# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0x4e,0xb0,0xa5
# CHECK: ld1sb   {z5.s}, p3/z, [x17, x16] // encoding: [0x25,0x4e,0xb0,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z5.s}, p3/z, [x17, x16] 
0x00,0x40,0xa0,0xa5
# CHECK: ld1sb   {z0.s}, p0/z, [x0, x0] // encoding: [0x00,0x40,0xa0,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z0.s}, p0/z, [x0, x0] 
0x55,0x55,0xb5,0xa5
# CHECK: ld1sb   {z21.s}, p5/z, [x10, x21] // encoding: [0x55,0x55,0xb5,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z21.s}, p5/z, [x10, x21] 
0xb7,0x4d,0xa8,0xa5
# CHECK: ld1sb   {z23.s}, p3/z, [x13, x8] // encoding: [0xb7,0x4d,0xa8,0xa5]
# CHECK-ERROR-NOT: ld1sb   {z23.s}, p3/z, [x13, x8] 
