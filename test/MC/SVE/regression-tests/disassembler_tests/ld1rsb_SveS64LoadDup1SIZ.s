# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0xd5,0x85
# CHECK: ld1rsb  {z21.d}, p5/z, [x10, #21] // encoding: [0x55,0x95,0xd5,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z21.d}, p5/z, [x10, #21] 
0xb7,0x8d,0xc8,0x85
# CHECK: ld1rsb  {z23.d}, p3/z, [x13, #8] // encoding: [0xb7,0x8d,0xc8,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z23.d}, p3/z, [x13, #8] 
0x00,0x80,0xc0,0x85
# CHECK: ld1rsb  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0xc0,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z0.d}, p0/z, [x0] 
0xff,0x9f,0xff,0x85
# CHECK: ld1rsb  {z31.d}, p7/z, [sp, #63] // encoding: [0xff,0x9f,0xff,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z31.d}, p7/z, [sp, #63] 
