# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xa4,0x05
# CHECK: revb    z0.s, p0/m, z0.s // encoding: [0x00,0x80,0xa4,0x05]
# CHECK-ERROR-NOT: revb    z0.s, p0/m, z0.s 
0xff,0x9f,0xa4,0x05
# CHECK: revb    z31.s, p7/m, z31.s // encoding: [0xff,0x9f,0xa4,0x05]
# CHECK-ERROR-NOT: revb    z31.s, p7/m, z31.s 
0xb7,0x8d,0xa4,0x05
# CHECK: revb    z23.s, p3/m, z13.s // encoding: [0xb7,0x8d,0xa4,0x05]
# CHECK-ERROR-NOT: revb    z23.s, p3/m, z13.s 
0x55,0x95,0xa4,0x05
# CHECK: revb    z21.s, p5/m, z10.s // encoding: [0x55,0x95,0xa4,0x05]
# CHECK-ERROR-NOT: revb    z21.s, p5/m, z10.s 
