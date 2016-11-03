# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x2d,0xa8,0x65
# CHECK: fmls    z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x2d,0xa8,0x65]
# CHECK-ERROR-NOT: fmls    z23.s, p3/m, z13.s, z8.s 
0x00,0x20,0xa0,0x65
# CHECK: fmls    z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x20,0xa0,0x65]
# CHECK-ERROR-NOT: fmls    z0.s, p0/m, z0.s, z0.s 
0xff,0x3f,0xbf,0x65
# CHECK: fmls    z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x3f,0xbf,0x65]
# CHECK-ERROR-NOT: fmls    z31.s, p7/m, z31.s, z31.s 
0x55,0x35,0xb5,0x65
# CHECK: fmls    z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x35,0xb5,0x65]
# CHECK-ERROR-NOT: fmls    z21.s, p5/m, z10.s, z21.s 
