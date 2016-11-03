# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xcd,0x28,0xc4
# CHECK: ld1b    {z23.d}, p3/z, [z13.d, #8] // encoding: [0xb7,0xcd,0x28,0xc4]
# CHECK-ERROR-NOT: ld1b    {z23.d}, p3/z, [z13.d, #8] 
0xff,0xdf,0x3f,0xc4
# CHECK: ld1b    {z31.d}, p7/z, [z31.d, #31] // encoding: [0xff,0xdf,0x3f,0xc4]
# CHECK-ERROR-NOT: ld1b    {z31.d}, p7/z, [z31.d, #31] 
0x55,0xd5,0x35,0xc4
# CHECK: ld1b    {z21.d}, p5/z, [z10.d, #21] // encoding: [0x55,0xd5,0x35,0xc4]
# CHECK-ERROR-NOT: ld1b    {z21.d}, p5/z, [z10.d, #21] 
0x00,0xc0,0x20,0xc4
# CHECK: ld1b    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0x20,0xc4]
# CHECK-ERROR-NOT: ld1b    {z0.d}, p0/z, [z0.d] 
