# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0x5f,0xe4
# CHECK: st1b    {z31.d}, p7, [z31.d, #31] // encoding: [0xff,0xbf,0x5f,0xe4]
# CHECK-ERROR-NOT: st1b    {z31.d}, p7, [z31.d, #31] 
0xb7,0xad,0x48,0xe4
# CHECK: st1b    {z23.d}, p3, [z13.d, #8] // encoding: [0xb7,0xad,0x48,0xe4]
# CHECK-ERROR-NOT: st1b    {z23.d}, p3, [z13.d, #8] 
0x00,0xa0,0x40,0xe4
# CHECK: st1b    {z0.d}, p0, [z0.d] // encoding: [0x00,0xa0,0x40,0xe4]
# CHECK-ERROR-NOT: st1b    {z0.d}, p0, [z0.d] 
0x55,0xb5,0x55,0xe4
# CHECK: st1b    {z21.d}, p5, [z10.d, #21] // encoding: [0x55,0xb5,0x55,0xe4]
# CHECK-ERROR-NOT: st1b    {z21.d}, p5, [z10.d, #21] 
