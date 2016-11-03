# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0x15,0xe4
# CHECK: st1b    {z21.d}, p5, [x10, z21.d, sxtw] // encoding: [0x55,0xd5,0x15,0xe4]
# CHECK-ERROR-NOT: st1b    {z21.d}, p5, [x10, z21.d, sxtw] 
0xff,0xdf,0x1f,0xe4
# CHECK: st1b    {z31.d}, p7, [sp, z31.d, sxtw] // encoding: [0xff,0xdf,0x1f,0xe4]
# CHECK-ERROR-NOT: st1b    {z31.d}, p7, [sp, z31.d, sxtw] 
0x00,0xc0,0x00,0xe4
# CHECK: st1b    {z0.d}, p0, [x0, z0.d, sxtw] // encoding: [0x00,0xc0,0x00,0xe4]
# CHECK-ERROR-NOT: st1b    {z0.d}, p0, [x0, z0.d, sxtw] 
0xb7,0xcd,0x08,0xe4
# CHECK: st1b    {z23.d}, p3, [x13, z8.d, sxtw] // encoding: [0xb7,0xcd,0x08,0xe4]
# CHECK-ERROR-NOT: st1b    {z23.d}, p3, [x13, z8.d, sxtw] 
