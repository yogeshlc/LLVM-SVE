# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x75,0xf5,0xe4
# CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xf5,0xe4]
# CHECK-ERROR-NOT: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, x21, lsl #1] 
0xb7,0x6d,0xe8,0xe4
# CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xe8,0xe4]
# CHECK-ERROR-NOT: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, x8, lsl #1] 
0x00,0x60,0xe0,0xe4
# CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xe0,0xe4]
# CHECK-ERROR-NOT: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0, x0, lsl #1] 
0x25,0x6e,0xf0,0xe4
# CHECK: st4h    {z5.h, z6.h, z7.h, z8.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x6e,0xf0,0xe4]
# CHECK-ERROR-NOT: st4h    {z5.h, z6.h, z7.h, z8.h}, p3, [x17, x16, lsl #1] 
