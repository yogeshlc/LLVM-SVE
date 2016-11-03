# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0xa0,0x84
# CHECK: ld1h    {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xc0,0xa0,0x84]
# CHECK-ERROR-NOT: ld1h    {z0.s}, p0/z, [z0.s] 
0xff,0xdf,0xbf,0x84
# CHECK: ld1h    {z31.s}, p7/z, [z31.s, #62] // encoding: [0xff,0xdf,0xbf,0x84]
# CHECK-ERROR-NOT: ld1h    {z31.s}, p7/z, [z31.s, #62] 
0x55,0xd5,0xb5,0x84
# CHECK: ld1h    {z21.s}, p5/z, [z10.s, #42] // encoding: [0x55,0xd5,0xb5,0x84]
# CHECK-ERROR-NOT: ld1h    {z21.s}, p5/z, [z10.s, #42] 
0xb7,0xcd,0xa8,0x84
# CHECK: ld1h    {z23.s}, p3/z, [z13.s, #16] // encoding: [0xb7,0xcd,0xa8,0x84]
# CHECK-ERROR-NOT: ld1h    {z23.s}, p3/z, [z13.s, #16] 
