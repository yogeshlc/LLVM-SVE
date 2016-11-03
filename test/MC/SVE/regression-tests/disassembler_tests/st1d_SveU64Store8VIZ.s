# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0xdf,0xe5
# CHECK: st1d    {z31.d}, p7, [z31.d, #248] // encoding: [0xff,0xbf,0xdf,0xe5]
# CHECK-ERROR-NOT: st1d    {z31.d}, p7, [z31.d, #248] 
0x55,0xb5,0xd5,0xe5
# CHECK: st1d    {z21.d}, p5, [z10.d, #168] // encoding: [0x55,0xb5,0xd5,0xe5]
# CHECK-ERROR-NOT: st1d    {z21.d}, p5, [z10.d, #168] 
0xb7,0xad,0xc8,0xe5
# CHECK: st1d    {z23.d}, p3, [z13.d, #64] // encoding: [0xb7,0xad,0xc8,0xe5]
# CHECK-ERROR-NOT: st1d    {z23.d}, p3, [z13.d, #64] 
0x00,0xa0,0xc0,0xe5
# CHECK: st1d    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe5]
# CHECK-ERROR-NOT: st1d    {z0.d}, p0, [z0.d] 
