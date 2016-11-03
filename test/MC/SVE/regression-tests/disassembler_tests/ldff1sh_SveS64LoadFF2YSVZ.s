# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x20,0xa0,0xc4
# CHECK: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1] // encoding: [0x00,0x20,0xa0,0xc4]
# CHECK-ERROR-NOT: ldff1sh {z0.d}, p0/z, [x0, z0.d, uxtw #1] 
0x55,0x35,0xb5,0xc4
# CHECK: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw #1] // encoding: [0x55,0x35,0xb5,0xc4]
# CHECK-ERROR-NOT: ldff1sh {z21.d}, p5/z, [x10, z21.d, uxtw #1] 
0xff,0x3f,0xbf,0xc4
# CHECK: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw #1] // encoding: [0xff,0x3f,0xbf,0xc4]
# CHECK-ERROR-NOT: ldff1sh {z31.d}, p7/z, [sp, z31.d, uxtw #1] 
0xb7,0x2d,0xa8,0xc4
# CHECK: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw #1] // encoding: [0xb7,0x2d,0xa8,0xc4]
# CHECK-ERROR-NOT: ldff1sh {z23.d}, p3/z, [x13, z8.d, uxtw #1] 
