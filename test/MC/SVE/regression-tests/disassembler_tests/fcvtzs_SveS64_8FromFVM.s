# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0xdc,0x65
# CHECK: fcvtzs  z31.d, p7/m, z31.s // encoding: [0xff,0xbf,0xdc,0x65]
# CHECK-ERROR-NOT: fcvtzs  z31.d, p7/m, z31.s 
0x55,0xb5,0xdc,0x65
# CHECK: fcvtzs  z21.d, p5/m, z10.s // encoding: [0x55,0xb5,0xdc,0x65]
# CHECK-ERROR-NOT: fcvtzs  z21.d, p5/m, z10.s 
0xb7,0xad,0xdc,0x65
# CHECK: fcvtzs  z23.d, p3/m, z13.s // encoding: [0xb7,0xad,0xdc,0x65]
# CHECK-ERROR-NOT: fcvtzs  z23.d, p3/m, z13.s 
0x00,0xa0,0xdc,0x65
# CHECK: fcvtzs  z0.d, p0/m, z0.s // encoding: [0x00,0xa0,0xdc,0x65]
# CHECK-ERROR-NOT: fcvtzs  z0.d, p0/m, z0.s 
