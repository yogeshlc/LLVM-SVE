# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x55,0xe5
# CHECK: st1w    {z21.s}, p5, [x10, z21.s, uxtw] // encoding: [0x55,0x95,0x55,0xe5]
# CHECK-ERROR-NOT: st1w    {z21.s}, p5, [x10, z21.s, uxtw] 
0x00,0x80,0x40,0xe5
# CHECK: st1w    {z0.s}, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x80,0x40,0xe5]
# CHECK-ERROR-NOT: st1w    {z0.s}, p0, [x0, z0.s, uxtw] 
0xff,0x9f,0x5f,0xe5
# CHECK: st1w    {z31.s}, p7, [sp, z31.s, uxtw] // encoding: [0xff,0x9f,0x5f,0xe5]
# CHECK-ERROR-NOT: st1w    {z31.s}, p7, [sp, z31.s, uxtw] 
0xb7,0x8d,0x48,0xe5
# CHECK: st1w    {z23.s}, p3, [x13, z8.s, uxtw] // encoding: [0xb7,0x8d,0x48,0xe5]
# CHECK-ERROR-NOT: st1w    {z23.s}, p3, [x13, z8.s, uxtw] 
