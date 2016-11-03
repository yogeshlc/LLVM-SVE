# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x5f,0x5f,0x85
# CHECK: ld1w    {z31.s}, p7/z, [sp, z31.s, sxtw] // encoding: [0xff,0x5f,0x5f,0x85]
# CHECK-ERROR-NOT: ld1w    {z31.s}, p7/z, [sp, z31.s, sxtw] 
0x00,0x40,0x40,0x85
# CHECK: ld1w    {z0.s}, p0/z, [x0, z0.s, sxtw] // encoding: [0x00,0x40,0x40,0x85]
# CHECK-ERROR-NOT: ld1w    {z0.s}, p0/z, [x0, z0.s, sxtw] 
0x55,0x55,0x55,0x85
# CHECK: ld1w    {z21.s}, p5/z, [x10, z21.s, sxtw] // encoding: [0x55,0x55,0x55,0x85]
# CHECK-ERROR-NOT: ld1w    {z21.s}, p5/z, [x10, z21.s, sxtw] 
0xb7,0x4d,0x48,0x85
# CHECK: ld1w    {z23.s}, p3/z, [x13, z8.s, sxtw] // encoding: [0xb7,0x4d,0x48,0x85]
# CHECK-ERROR-NOT: ld1w    {z23.s}, p3/z, [x13, z8.s, sxtw] 
