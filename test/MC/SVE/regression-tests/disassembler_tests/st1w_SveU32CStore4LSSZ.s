# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x4d,0x48,0xe5
# CHECK: st1w    {z23.s}, p3, [x13, x8, lsl #2] // encoding: [0xb7,0x4d,0x48,0xe5]
# CHECK-ERROR-NOT: st1w    {z23.s}, p3, [x13, x8, lsl #2] 
0x25,0x4e,0x50,0xe5
# CHECK: st1w    {z5.s}, p3, [x17, x16, lsl #2] // encoding: [0x25,0x4e,0x50,0xe5]
# CHECK-ERROR-NOT: st1w    {z5.s}, p3, [x17, x16, lsl #2] 
0x55,0x55,0x55,0xe5
# CHECK: st1w    {z21.s}, p5, [x10, x21, lsl #2] // encoding: [0x55,0x55,0x55,0xe5]
# CHECK-ERROR-NOT: st1w    {z21.s}, p5, [x10, x21, lsl #2] 
0x00,0x40,0x40,0xe5
# CHECK: st1w    {z0.s}, p0, [x0, x0, lsl #2] // encoding: [0x00,0x40,0x40,0xe5]
# CHECK-ERROR-NOT: st1w    {z0.s}, p0, [x0, x0, lsl #2] 
