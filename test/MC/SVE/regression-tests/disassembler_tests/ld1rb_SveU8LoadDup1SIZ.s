# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x48,0x84
# CHECK: ld1rb   {z23.b}, p3/z, [x13, #8] // encoding: [0xb7,0x8d,0x48,0x84]
# CHECK-ERROR-NOT: ld1rb   {z23.b}, p3/z, [x13, #8] 
0x55,0x95,0x55,0x84
# CHECK: ld1rb   {z21.b}, p5/z, [x10, #21] // encoding: [0x55,0x95,0x55,0x84]
# CHECK-ERROR-NOT: ld1rb   {z21.b}, p5/z, [x10, #21] 
0x00,0x80,0x40,0x84
# CHECK: ld1rb   {z0.b}, p0/z, [x0] // encoding: [0x00,0x80,0x40,0x84]
# CHECK-ERROR-NOT: ld1rb   {z0.b}, p0/z, [x0] 
0xff,0x9f,0x7f,0x84
# CHECK: ld1rb   {z31.b}, p7/z, [sp, #63] // encoding: [0xff,0x9f,0x7f,0x84]
# CHECK-ERROR-NOT: ld1rb   {z31.b}, p7/z, [sp, #63] 
