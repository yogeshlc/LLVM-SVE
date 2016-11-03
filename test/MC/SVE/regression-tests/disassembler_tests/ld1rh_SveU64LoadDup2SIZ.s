# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0xc8,0x84
# CHECK: ld1rh   {z23.d}, p3/z, [x13, #16] // encoding: [0xb7,0xed,0xc8,0x84]
# CHECK-ERROR-NOT: ld1rh   {z23.d}, p3/z, [x13, #16] 
0x55,0xf5,0xd5,0x84
# CHECK: ld1rh   {z21.d}, p5/z, [x10, #42] // encoding: [0x55,0xf5,0xd5,0x84]
# CHECK-ERROR-NOT: ld1rh   {z21.d}, p5/z, [x10, #42] 
0xff,0xff,0xff,0x84
# CHECK: ld1rh   {z31.d}, p7/z, [sp, #126] // encoding: [0xff,0xff,0xff,0x84]
# CHECK-ERROR-NOT: ld1rh   {z31.d}, p7/z, [sp, #126] 
0x00,0xe0,0xc0,0x84
# CHECK: ld1rh   {z0.d}, p0/z, [x0] // encoding: [0x00,0xe0,0xc0,0x84]
# CHECK-ERROR-NOT: ld1rh   {z0.d}, p0/z, [x0] 
