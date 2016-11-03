# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xc9,0x65
# CHECK: fcvt    z23.d, p3/m, z13.h // encoding: [0xb7,0xad,0xc9,0x65]
# CHECK-ERROR-NOT: fcvt    z23.d, p3/m, z13.h 
0x55,0xb5,0xc9,0x65
# CHECK: fcvt    z21.d, p5/m, z10.h // encoding: [0x55,0xb5,0xc9,0x65]
# CHECK-ERROR-NOT: fcvt    z21.d, p5/m, z10.h 
0xff,0xbf,0xc9,0x65
# CHECK: fcvt    z31.d, p7/m, z31.h // encoding: [0xff,0xbf,0xc9,0x65]
# CHECK-ERROR-NOT: fcvt    z31.d, p7/m, z31.h 
0x00,0xa0,0xc9,0x65
# CHECK: fcvt    z0.d, p0/m, z0.h // encoding: [0x00,0xa0,0xc9,0x65]
# CHECK-ERROR-NOT: fcvt    z0.d, p0/m, z0.h 
