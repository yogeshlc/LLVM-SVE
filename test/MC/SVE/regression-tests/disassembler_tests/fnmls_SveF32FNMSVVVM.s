# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x75,0xb5,0x65
# CHECK: fnmls   z21.s, p5/m, z10.s, z21.s // encoding: [0x55,0x75,0xb5,0x65]
# CHECK-ERROR-NOT: fnmls   z21.s, p5/m, z10.s, z21.s 
0xff,0x7f,0xbf,0x65
# CHECK: fnmls   z31.s, p7/m, z31.s, z31.s // encoding: [0xff,0x7f,0xbf,0x65]
# CHECK-ERROR-NOT: fnmls   z31.s, p7/m, z31.s, z31.s 
0xb7,0x6d,0xa8,0x65
# CHECK: fnmls   z23.s, p3/m, z13.s, z8.s // encoding: [0xb7,0x6d,0xa8,0x65]
# CHECK-ERROR-NOT: fnmls   z23.s, p3/m, z13.s, z8.s 
0x00,0x60,0xa0,0x65
# CHECK: fnmls   z0.s, p0/m, z0.s, z0.s // encoding: [0x00,0x60,0xa0,0x65]
# CHECK-ERROR-NOT: fnmls   z0.s, p0/m, z0.s, z0.s 
