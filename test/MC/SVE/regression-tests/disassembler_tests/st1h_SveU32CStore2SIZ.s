# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0xcf,0xe4
# CHECK: st1h    {z31.s}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xcf,0xe4]
# CHECK-ERROR-NOT: st1h    {z31.s}, p7, [sp, #-1, mul vl] 
0x55,0xf5,0xc5,0xe4
# CHECK: st1h    {z21.s}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xc5,0xe4]
# CHECK-ERROR-NOT: st1h    {z21.s}, p5, [x10, #5, mul vl] 
0xb7,0xed,0xc8,0xe4
# CHECK: st1h    {z23.s}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xc8,0xe4]
# CHECK-ERROR-NOT: st1h    {z23.s}, p3, [x13, #-8, mul vl] 
0x00,0xe0,0xc0,0xe4
# CHECK: st1h    {z0.s}, p0, [x0] // encoding: [0x00,0xe0,0xc0,0xe4]
# CHECK-ERROR-NOT: st1h    {z0.s}, p0, [x0] 
