# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0x6e,0xd0,0xe4
# CHECK: st3h    {z5.h, z6.h, z7.h}, p3, [x17, x16, lsl #1] // encoding: [0x25,0x6e,0xd0,0xe4]
# CHECK-ERROR-NOT: st3h    {z5.h, z6.h, z7.h}, p3, [x17, x16, lsl #1] 
0xb7,0x6d,0xc8,0xe4
# CHECK: st3h    {z23.h, z24.h, z25.h}, p3, [x13, x8, lsl #1] // encoding: [0xb7,0x6d,0xc8,0xe4]
# CHECK-ERROR-NOT: st3h    {z23.h, z24.h, z25.h}, p3, [x13, x8, lsl #1] 
0x00,0x60,0xc0,0xe4
# CHECK: st3h    {z0.h, z1.h, z2.h}, p0, [x0, x0, lsl #1] // encoding: [0x00,0x60,0xc0,0xe4]
# CHECK-ERROR-NOT: st3h    {z0.h, z1.h, z2.h}, p0, [x0, x0, lsl #1] 
0x55,0x75,0xd5,0xe4
# CHECK: st3h    {z21.h, z22.h, z23.h}, p5, [x10, x21, lsl #1] // encoding: [0x55,0x75,0xd5,0xe4]
# CHECK-ERROR-NOT: st3h    {z21.h, z22.h, z23.h}, p5, [x10, x21, lsl #1] 
