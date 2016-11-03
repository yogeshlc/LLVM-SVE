# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x55,0xc4
# CHECK: ld1sb   {z21.d}, p5/z, [x10, z21.d] // encoding: [0x55,0x95,0x55,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z21.d}, p5/z, [x10, z21.d] 
0xb7,0x8d,0x48,0xc4
# CHECK: ld1sb   {z23.d}, p3/z, [x13, z8.d] // encoding: [0xb7,0x8d,0x48,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z23.d}, p3/z, [x13, z8.d] 
0x00,0x80,0x40,0xc4
# CHECK: ld1sb   {z0.d}, p0/z, [x0, z0.d] // encoding: [0x00,0x80,0x40,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z0.d}, p0/z, [x0, z0.d] 
0xff,0x9f,0x5f,0xc4
# CHECK: ld1sb   {z31.d}, p7/z, [sp, z31.d] // encoding: [0xff,0x9f,0x5f,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z31.d}, p7/z, [sp, z31.d] 
