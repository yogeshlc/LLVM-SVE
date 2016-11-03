# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0x28,0x84
# CHECK: ldff1b  {z23.s}, p3/z, [z13.s, #8] // encoding: [0xb7,0xed,0x28,0x84]
# CHECK-ERROR-NOT: ldff1b  {z23.s}, p3/z, [z13.s, #8] 
0x55,0xf5,0x35,0x84
# CHECK: ldff1b  {z21.s}, p5/z, [z10.s, #21] // encoding: [0x55,0xf5,0x35,0x84]
# CHECK-ERROR-NOT: ldff1b  {z21.s}, p5/z, [z10.s, #21] 
0x00,0xe0,0x20,0x84
# CHECK: ldff1b  {z0.s}, p0/z, [z0.s] // encoding: [0x00,0xe0,0x20,0x84]
# CHECK-ERROR-NOT: ldff1b  {z0.s}, p0/z, [z0.s] 
0xff,0xff,0x3f,0x84
# CHECK: ldff1b  {z31.s}, p7/z, [z31.s, #31] // encoding: [0xff,0xff,0x3f,0x84]
# CHECK-ERROR-NOT: ldff1b  {z31.s}, p7/z, [z31.s, #31] 
