# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0xb0,0xe4
# CHECK: st2h    {z0.h, z1.h}, p0, [x0] // encoding: [0x00,0xe0,0xb0,0xe4]
# CHECK-ERROR-NOT: st2h    {z0.h, z1.h}, p0, [x0] 
0xff,0xff,0xbf,0xe4
# CHECK: st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl] // encoding: [0xff,0xff,0xbf,0xe4]
# CHECK-ERROR-NOT: st2h    {z31.h, z0.h}, p7, [sp, #-2, mul vl] 
0x55,0xf5,0xb5,0xe4
# CHECK: st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl] // encoding: [0x55,0xf5,0xb5,0xe4]
# CHECK-ERROR-NOT: st2h    {z21.h, z22.h}, p5, [x10, #10, mul vl] 
0xb7,0xed,0xb8,0xe4
# CHECK: st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl] // encoding: [0xb7,0xed,0xb8,0xe4]
# CHECK-ERROR-NOT: st2h    {z23.h, z24.h}, p3, [x13, #-16, mul vl] 
