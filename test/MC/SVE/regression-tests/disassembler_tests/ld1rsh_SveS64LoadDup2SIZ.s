# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x48,0x85
# CHECK: ld1rsh  {z23.d}, p3/z, [x13, #16] // encoding: [0xb7,0x8d,0x48,0x85]
# CHECK-ERROR-NOT: ld1rsh  {z23.d}, p3/z, [x13, #16] 
0x55,0x95,0x55,0x85
# CHECK: ld1rsh  {z21.d}, p5/z, [x10, #42] // encoding: [0x55,0x95,0x55,0x85]
# CHECK-ERROR-NOT: ld1rsh  {z21.d}, p5/z, [x10, #42] 
0x00,0x80,0x40,0x85
# CHECK: ld1rsh  {z0.d}, p0/z, [x0] // encoding: [0x00,0x80,0x40,0x85]
# CHECK-ERROR-NOT: ld1rsh  {z0.d}, p0/z, [x0] 
0xff,0x9f,0x7f,0x85
# CHECK: ld1rsh  {z31.d}, p7/z, [sp, #126] // encoding: [0xff,0x9f,0x7f,0x85]
# CHECK-ERROR-NOT: ld1rsh  {z31.d}, p7/z, [sp, #126] 
