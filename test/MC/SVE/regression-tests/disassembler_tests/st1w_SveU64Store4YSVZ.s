# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x20,0xe5
# CHECK: st1w    {z0.d}, p0, [x0, z0.d, uxtw #2] // encoding: [0x00,0x80,0x20,0xe5]
# CHECK-ERROR-NOT: st1w    {z0.d}, p0, [x0, z0.d, uxtw #2] 
0xff,0x9f,0x3f,0xe5
# CHECK: st1w    {z31.d}, p7, [sp, z31.d, uxtw #2] // encoding: [0xff,0x9f,0x3f,0xe5]
# CHECK-ERROR-NOT: st1w    {z31.d}, p7, [sp, z31.d, uxtw #2] 
0x55,0x95,0x35,0xe5
# CHECK: st1w    {z21.d}, p5, [x10, z21.d, uxtw #2] // encoding: [0x55,0x95,0x35,0xe5]
# CHECK-ERROR-NOT: st1w    {z21.d}, p5, [x10, z21.d, uxtw #2] 
0xb7,0x8d,0x28,0xe5
# CHECK: st1w    {z23.d}, p3, [x13, z8.d, uxtw #2] // encoding: [0xb7,0x8d,0x28,0xe5]
# CHECK-ERROR-NOT: st1w    {z23.d}, p3, [x13, z8.d, uxtw #2] 
