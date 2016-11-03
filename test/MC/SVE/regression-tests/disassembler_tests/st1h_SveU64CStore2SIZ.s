# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0xe8,0xe4
# CHECK: st1h    {z23.d}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xe8,0xe4]
# CHECK-ERROR-NOT: st1h    {z23.d}, p3, [x13, #-8, mul vl] 
0x00,0xe0,0xe0,0xe4
# CHECK: st1h    {z0.d}, p0, [x0] // encoding: [0x00,0xe0,0xe0,0xe4]
# CHECK-ERROR-NOT: st1h    {z0.d}, p0, [x0] 
0x55,0xf5,0xe5,0xe4
# CHECK: st1h    {z21.d}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xe5,0xe4]
# CHECK-ERROR-NOT: st1h    {z21.d}, p5, [x10, #5, mul vl] 
0xff,0xff,0xef,0xe4
# CHECK: st1h    {z31.d}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xef,0xe4]
# CHECK-ERROR-NOT: st1h    {z31.d}, p7, [sp, #-1, mul vl] 
