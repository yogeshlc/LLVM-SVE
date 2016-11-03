# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0xf5,0xe4
# CHECK: st1h    {z21.s}, p5, [x10, z21.s, sxtw #1] // encoding: [0x55,0xd5,0xf5,0xe4]
# CHECK-ERROR-NOT: st1h    {z21.s}, p5, [x10, z21.s, sxtw #1] 
0xff,0xdf,0xff,0xe4
# CHECK: st1h    {z31.s}, p7, [sp, z31.s, sxtw #1] // encoding: [0xff,0xdf,0xff,0xe4]
# CHECK-ERROR-NOT: st1h    {z31.s}, p7, [sp, z31.s, sxtw #1] 
0x00,0xc0,0xe0,0xe4
# CHECK: st1h    {z0.s}, p0, [x0, z0.s, sxtw #1] // encoding: [0x00,0xc0,0xe0,0xe4]
# CHECK-ERROR-NOT: st1h    {z0.s}, p0, [x0, z0.s, sxtw #1] 
0xb7,0xcd,0xe8,0xe4
# CHECK: st1h    {z23.s}, p3, [x13, z8.s, sxtw #1] // encoding: [0xb7,0xcd,0xe8,0xe4]
# CHECK-ERROR-NOT: st1h    {z23.s}, p3, [x13, z8.s, sxtw #1] 
