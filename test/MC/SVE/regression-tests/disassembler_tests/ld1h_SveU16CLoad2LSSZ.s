# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x55,0xb5,0xa4
# CHECK: ld1h    {z21.h}, p5/z, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xb5,0xa4]
# CHECK-ERROR-NOT: ld1h    {z21.h}, p5/z, [x10, x21, lsl #1] 
0x25,0x4e,0xb0,0xa4
# CHECK: ld1h    {z5.h}, p3/z, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xb0,0xa4]
# CHECK-ERROR-NOT: ld1h    {z5.h}, p3/z, [x17, x16, lsl #1] 
0xb7,0x4d,0xa8,0xa4
# CHECK: ld1h    {z23.h}, p3/z, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xa8,0xa4]
# CHECK-ERROR-NOT: ld1h    {z23.h}, p3/z, [x13, x8, lsl #1] 
0x00,0x40,0xa0,0xa4
# CHECK: ld1h    {z0.h}, p0/z, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xa0,0xa4]
# CHECK-ERROR-NOT: ld1h    {z0.h}, p0/z, [x0, x0, lsl #1] 
