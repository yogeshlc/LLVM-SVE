# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0xff,0x65
# CHECK: fmad    z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xff,0x65]
# CHECK-ERROR-NOT: fmad    z31.d, p7/m, z31.d, z31.d 
0x55,0x95,0xf5,0x65
# CHECK: fmad    z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x95,0xf5,0x65]
# CHECK-ERROR-NOT: fmad    z21.d, p5/m, z10.d, z21.d 
0x00,0x80,0xe0,0x65
# CHECK: fmad    z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xe0,0x65]
# CHECK-ERROR-NOT: fmad    z0.d, p0/m, z0.d, z0.d 
0xb7,0x8d,0xe8,0x65
# CHECK: fmad    z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x8d,0xe8,0x65]
# CHECK-ERROR-NOT: fmad    z23.d, p3/m, z13.d, z8.d 
