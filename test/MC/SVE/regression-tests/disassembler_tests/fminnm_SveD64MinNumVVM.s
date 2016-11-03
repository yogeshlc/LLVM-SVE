# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0xc5,0x65
# CHECK: fminnm  z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xc5,0x65]
# CHECK-ERROR-NOT: fminnm  z23.d, p3/m, z23.d, z13.d 
0x55,0x95,0xc5,0x65
# CHECK: fminnm  z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xc5,0x65]
# CHECK-ERROR-NOT: fminnm  z21.d, p5/m, z21.d, z10.d 
0xff,0x9f,0xc5,0x65
# CHECK: fminnm  z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xc5,0x65]
# CHECK-ERROR-NOT: fminnm  z31.d, p7/m, z31.d, z31.d 
0x00,0x80,0xc5,0x65
# CHECK: fminnm  z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xc5,0x65]
# CHECK-ERROR-NOT: fminnm  z0.d, p0/m, z0.d, z0.d 
