# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xc8,0xe4
# CHECK: st1h    {z23.d}, p3, [z13.d, #16] // encoding: [0xb7,0xad,0xc8,0xe4]
# CHECK-ERROR-NOT: st1h    {z23.d}, p3, [z13.d, #16] 
0xff,0xbf,0xdf,0xe4
# CHECK: st1h    {z31.d}, p7, [z31.d, #62] // encoding: [0xff,0xbf,0xdf,0xe4]
# CHECK-ERROR-NOT: st1h    {z31.d}, p7, [z31.d, #62] 
0x00,0xa0,0xc0,0xe4
# CHECK: st1h    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0xc0,0xe4]
# CHECK-ERROR-NOT: st1h    {z0.d}, p0, [z0.d] 
0x55,0xb5,0xd5,0xe4
# CHECK: st1h    {z21.d}, p5, [z10.d, #42] // encoding: [0x55,0xb5,0xd5,0xe4]
# CHECK-ERROR-NOT: st1h    {z21.d}, p5, [z10.d, #42] 
