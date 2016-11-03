# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0xe8,0x84
# CHECK: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw #1] // encoding: [0xb7,0x2d,0xe8,0x84]
# CHECK-ERROR-NOT: ldff1sh {z23.s}, p3/z, [x13, z8.s, sxtw #1] 
0x00,0x20,0xe0,0x84
# CHECK: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1] // encoding: [0x00,0x20,0xe0,0x84]
# CHECK-ERROR-NOT: ldff1sh {z0.s}, p0/z, [x0, z0.s, sxtw #1] 
0x55,0x35,0xf5,0x84
# CHECK: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw #1] // encoding: [0x55,0x35,0xf5,0x84]
# CHECK-ERROR-NOT: ldff1sh {z21.s}, p5/z, [x10, z21.s, sxtw #1] 
0xff,0x3f,0xff,0x84
# CHECK: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw #1] // encoding: [0xff,0x3f,0xff,0x84]
# CHECK-ERROR-NOT: ldff1sh {z31.s}, p7/z, [sp, z31.s, sxtw #1] 
