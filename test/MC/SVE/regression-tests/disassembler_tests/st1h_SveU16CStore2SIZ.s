# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xf5,0xa5,0xe4
# CHECK: st1h    {z21.h}, p5, [x10, #5, mul vl] // encoding: [0x55,0xf5,0xa5,0xe4]
# CHECK-ERROR-NOT: st1h    {z21.h}, p5, [x10, #5, mul vl] 
0xb7,0xed,0xa8,0xe4
# CHECK: st1h    {z23.h}, p3, [x13, #-8, mul vl] // encoding: [0xb7,0xed,0xa8,0xe4]
# CHECK-ERROR-NOT: st1h    {z23.h}, p3, [x13, #-8, mul vl] 
0x00,0xe0,0xa0,0xe4
# CHECK: st1h    {z0.h}, p0, [x0] // encoding: [0x00,0xe0,0xa0,0xe4]
# CHECK-ERROR-NOT: st1h    {z0.h}, p0, [x0] 
0xff,0xff,0xaf,0xe4
# CHECK: st1h    {z31.h}, p7, [sp, #-1, mul vl] // encoding: [0xff,0xff,0xaf,0xe4]
# CHECK-ERROR-NOT: st1h    {z31.h}, p7, [sp, #-1, mul vl] 
