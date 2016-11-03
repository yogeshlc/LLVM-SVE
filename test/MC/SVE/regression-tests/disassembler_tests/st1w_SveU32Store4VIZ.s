# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0x75,0xe5
# CHECK: st1w    {z21.s}, p5, [z10.s, #84] // encoding: [0x55,0xb5,0x75,0xe5]
# CHECK-ERROR-NOT: st1w    {z21.s}, p5, [z10.s, #84] 
0xb7,0xad,0x68,0xe5
# CHECK: st1w    {z23.s}, p3, [z13.s, #32] // encoding: [0xb7,0xad,0x68,0xe5]
# CHECK-ERROR-NOT: st1w    {z23.s}, p3, [z13.s, #32] 
0x00,0xa0,0x60,0xe5
# CHECK: st1w    {z0.s}, p0, [z0.s] // encoding: [0x00,0xa0,0x60,0xe5]
# CHECK-ERROR-NOT: st1w    {z0.s}, p0, [z0.s] 
0xff,0xbf,0x7f,0xe5
# CHECK: st1w    {z31.s}, p7, [z31.s, #124] // encoding: [0xff,0xbf,0x7f,0xe5]
# CHECK-ERROR-NOT: st1w    {z31.s}, p7, [z31.s, #124] 
