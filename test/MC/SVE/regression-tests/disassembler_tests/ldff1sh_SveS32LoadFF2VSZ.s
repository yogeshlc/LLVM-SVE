# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0x88,0x84
# CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw] // encoding: [0xb7,0x2d,0x88,0x84]
# CHECK-ERROR-NOT: ldff1sh {z23.s}, p3/z, [x13, z8.s, uxtw] 
0xff,0x3f,0x9f,0x84
# CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw] // encoding: [0xff,0x3f,0x9f,0x84]
# CHECK-ERROR-NOT: ldff1sh {z31.s}, p7/z, [sp, z31.s, uxtw] 
0x55,0x35,0x95,0x84
# CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw] // encoding: [0x55,0x35,0x95,0x84]
# CHECK-ERROR-NOT: ldff1sh {z21.s}, p5/z, [x10, z21.s, uxtw] 
0x00,0x20,0x80,0x84
# CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw] // encoding: [0x00,0x20,0x80,0x84]
# CHECK-ERROR-NOT: ldff1sh {z0.s}, p0/z, [x0, z0.s, uxtw] 
