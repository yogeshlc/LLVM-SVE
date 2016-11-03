# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0x48,0xe4
# CHECK: st1b    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0x48,0xe4]
# CHECK-ERROR-NOT: st1b    {z23.s}, p3, [x13, #-8, mul vl] 
0x55,0xf5,0x45,0xe4
# CHECK: st1b    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0x45,0xe4]
# CHECK-ERROR-NOT: st1b    {z21.s}, p5, [x10, #5, mul vl] 
0x00,0xe0,0x40,0xe4
# CHECK: st1b    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0x40,0xe4]
# CHECK-ERROR-NOT: st1b    {z0.s}, p0, [x0] 
0xff,0xff,0x4f,0xe4
# CHECK: st1b    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0x4f,0xe4]
# CHECK-ERROR-NOT: st1b    {z31.s}, p7, [sp, #-1, mul vl] 
