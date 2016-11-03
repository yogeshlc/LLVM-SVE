# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0x00,0xc4
# CHECK: ld1sb   {z0.d}, p0/z, [x0, z0.d, uxtw] // encoding: [0x00,0x00,0x00,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z0.d}, p0/z, [x0, z0.d, uxtw] 
0xff,0x1f,0x1f,0xc4
# CHECK: ld1sb   {z31.d}, p7/z, [sp, z31.d, uxtw] // encoding: [0xff,0x1f,0x1f,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z31.d}, p7/z, [sp, z31.d, uxtw] 
0x55,0x15,0x15,0xc4
# CHECK: ld1sb   {z21.d}, p5/z, [x10, z21.d, uxtw] // encoding: [0x55,0x15,0x15,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z21.d}, p5/z, [x10, z21.d, uxtw] 
0xb7,0x0d,0x08,0xc4
# CHECK: ld1sb   {z23.d}, p3/z, [x13, z8.d, uxtw] // encoding: [0xb7,0x0d,0x08,0xc4]
# CHECK-ERROR-NOT: ld1sb   {z23.d}, p3/z, [x13, z8.d, uxtw] 
