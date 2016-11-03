# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xa0,0x40,0x84
# CHECK: ld1rb   {z0.h}, p0/z, [x0] // encoding: [0x00,0xa0,0x40,0x84]
# CHECK-ERROR-NOT: ld1rb   {z0.h}, p0/z, [x0] 
0xff,0xbf,0x7f,0x84
# CHECK: ld1rb   {z31.h}, p7/z, [sp, #63] // encoding: [0xff,0xbf,0x7f,0x84]
# CHECK-ERROR-NOT: ld1rb   {z31.h}, p7/z, [sp, #63] 
0xb7,0xad,0x48,0x84
# CHECK: ld1rb   {z23.h}, p3/z, [x13, #8] // encoding: [0xb7,0xad,0x48,0x84]
# CHECK-ERROR-NOT: ld1rb   {z23.h}, p3/z, [x13, #8] 
0x55,0xb5,0x55,0x84
# CHECK: ld1rb   {z21.h}, p5/z, [x10, #21] // encoding: [0x55,0xb5,0x55,0x84]
# CHECK-ERROR-NOT: ld1rb   {z21.h}, p5/z, [x10, #21] 
