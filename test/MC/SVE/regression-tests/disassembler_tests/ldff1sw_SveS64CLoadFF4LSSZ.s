# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x60,0x80,0xa4
# CHECK: ldff1sw {z0.d}, p0/z, [x0, x0, lsl #2] // encoding: [0x00,0x60,0x80,0xa4]
# CHECK-ERROR-NOT: ldff1sw {z0.d}, p0/z, [x0, x0, lsl #2] 
0xff,0x7f,0x9f,0xa4
# CHECK: ldff1sw {z31.d}, p7/z, [sp, xzr, lsl #2] // encoding: [0xff,0x7f,0x9f,0xa4]
# CHECK-ERROR-NOT: ldff1sw {z31.d}, p7/z, [sp, xzr, lsl #2] 
0xb7,0x6d,0x88,0xa4
# CHECK: ldff1sw {z23.d}, p3/z, [x13, x8, lsl #2] // encoding: [0xb7,0x6d,0x88,0xa4]
# CHECK-ERROR-NOT: ldff1sw {z23.d}, p3/z, [x13, x8, lsl #2] 
0x55,0x75,0x95,0xa4
# CHECK: ldff1sw {z21.d}, p5/z, [x10, x21, lsl #2] // encoding: [0x55,0x75,0x95,0xa4]
# CHECK-ERROR-NOT: ldff1sw {z21.d}, p5/z, [x10, x21, lsl #2] 
