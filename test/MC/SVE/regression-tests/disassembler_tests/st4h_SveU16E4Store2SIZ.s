# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xf5,0xe4
# CHECK: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, #20, mul vl] // encoding: [0x55,0xf5,0xf5,0xe4]
# CHECK-ERROR-NOT: st4h    {z21.h, z22.h, z23.h, z24.h}, p5, [x10, #20, mul vl] 
0x00,0xe0,0xf0,0xe4
# CHECK: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0] // encoding: [0x00,0xe0,0xf0,0xe4]
# CHECK-ERROR-NOT: st4h    {z0.h, z1.h, z2.h, z3.h}, p0, [x0] 
0xff,0xff,0xff,0xe4
# CHECK: st4h    {z31.h, z0.h, z1.h, z2.h}, p7, [sp, #-4, mul vl] // encoding: [0xff,0xff,0xff,0xe4]
# CHECK-ERROR-NOT: st4h    {z31.h, z0.h, z1.h, z2.h}, p7, [sp, #-4, mul vl] 
0xb7,0xed,0xf8,0xe4
# CHECK: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, #-32, mul vl] // encoding: [0xb7,0xed,0xf8,0xe4]
# CHECK-ERROR-NOT: st4h    {z23.h, z24.h, z25.h, z26.h}, p3, [x13, #-32, mul vl] 
