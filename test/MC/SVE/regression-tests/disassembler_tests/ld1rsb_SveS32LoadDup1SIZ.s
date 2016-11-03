# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xc8,0x85
# CHECK: ld1rsb  {z23.s}, p3/z, [x13, #8] // encoding: [0xb7,0xad,0xc8,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z23.s}, p3/z, [x13, #8] 
0xff,0xbf,0xff,0x85
# CHECK: ld1rsb  {z31.s}, p7/z, [sp, #63] // encoding: [0xff,0xbf,0xff,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z31.s}, p7/z, [sp, #63] 
0x00,0xa0,0xc0,0x85
# CHECK: ld1rsb  {z0.s}, p0/z, [x0] // encoding: [0x00,0xa0,0xc0,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z0.s}, p0/z, [x0] 
0x55,0xb5,0xd5,0x85
# CHECK: ld1rsb  {z21.s}, p5/z, [x10, #21] // encoding: [0x55,0xb5,0xd5,0x85]
# CHECK-ERROR-NOT: ld1rsb  {z21.s}, p5/z, [x10, #21] 
