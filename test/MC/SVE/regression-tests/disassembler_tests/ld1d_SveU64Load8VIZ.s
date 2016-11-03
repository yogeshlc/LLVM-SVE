# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0xb5,0xc5
# CHECK: ld1d    {z21.d}, p5/z, [z10.d, #168] // encoding: [0x55,0xd5,0xb5,0xc5]
# CHECK-ERROR-NOT: ld1d    {z21.d}, p5/z, [z10.d, #168] 
0x00,0xc0,0xa0,0xc5
# CHECK: ld1d    {z0.d}, p0/z, [z0.d] // encoding: [0x00,0xc0,0xa0,0xc5]
# CHECK-ERROR-NOT: ld1d    {z0.d}, p0/z, [z0.d] 
0xff,0xdf,0xbf,0xc5
# CHECK: ld1d    {z31.d}, p7/z, [z31.d, #248] // encoding: [0xff,0xdf,0xbf,0xc5]
# CHECK-ERROR-NOT: ld1d    {z31.d}, p7/z, [z31.d, #248] 
0xb7,0xcd,0xa8,0xc5
# CHECK: ld1d    {z23.d}, p3/z, [z13.d, #64] // encoding: [0xb7,0xcd,0xa8,0xc5]
# CHECK-ERROR-NOT: ld1d    {z23.d}, p3/z, [z13.d, #64] 
