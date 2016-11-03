# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x55,0xd5,0xe4
# CHECK: st1h    {z21.s}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x55,0xd5,0xe4]
# CHECK-ERROR-NOT: st1h    {z21.s}, p5, [x10, x21, lsl #1] 
0x00,0x40,0xc0,0xe4
# CHECK: st1h    {z0.s}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x40,0xc0,0xe4]
# CHECK-ERROR-NOT: st1h    {z0.s}, p0, [x0, x0, lsl #1] 
0x25,0x4e,0xd0,0xe4
# CHECK: st1h    {z5.s}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x4e,0xd0,0xe4]
# CHECK-ERROR-NOT: st1h    {z5.s}, p3, [x17, x16, lsl #1] 
0xb7,0x4d,0xc8,0xe4
# CHECK: st1h    {z23.s}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x4d,0xc8,0xe4]
# CHECK-ERROR-NOT: st1h    {z23.s}, p3, [x13, x8, lsl #1] 
