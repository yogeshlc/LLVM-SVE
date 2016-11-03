# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0xd8,0x65
# CHECK: fcvtzs  z31.s, p7/m, z31.d // encoding: [0xff,0xbf,0xd8,0x65]
# CHECK-ERROR-NOT: fcvtzs  z31.s, p7/m, z31.d 
0x00,0xa0,0xd8,0x65
# CHECK: fcvtzs  z0.s, p0/m, z0.d // encoding: [0x00,0xa0,0xd8,0x65]
# CHECK-ERROR-NOT: fcvtzs  z0.s, p0/m, z0.d 
0x55,0xb5,0xd8,0x65
# CHECK: fcvtzs  z21.s, p5/m, z10.d // encoding: [0x55,0xb5,0xd8,0x65]
# CHECK-ERROR-NOT: fcvtzs  z21.s, p5/m, z10.d 
0xb7,0xad,0xd8,0x65
# CHECK: fcvtzs  z23.s, p3/m, z13.d // encoding: [0xb7,0xad,0xd8,0x65]
# CHECK-ERROR-NOT: fcvtzs  z23.s, p3/m, z13.d 
