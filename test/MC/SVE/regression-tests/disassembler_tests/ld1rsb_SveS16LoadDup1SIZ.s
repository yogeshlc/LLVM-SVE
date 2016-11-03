# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xcd,0xc8,0x85
# CHECK: ld1rsb  {z23.h}, p3/z, [x13, #8] // encoding: [0xb7,0xcd,0xc8,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z23.h}, p3/z, [x13, #8] 
0x55,0xd5,0xd5,0x85
# CHECK: ld1rsb  {z21.h}, p5/z, [x10, #21] // encoding: [0x55,0xd5,0xd5,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z21.h}, p5/z, [x10, #21] 
0xff,0xdf,0xff,0x85
# CHECK: ld1rsb  {z31.h}, p7/z, [sp, #63] // encoding: [0xff,0xdf,0xff,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z31.h}, p7/z, [sp, #63] 
0x00,0xc0,0xc0,0x85
# CHECK: ld1rsb  {z0.h}, p0/z, [x0] // encoding: [0x00,0xc0,0xc0,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z0.h}, p0/z, [x0] 
