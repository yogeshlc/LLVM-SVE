# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0xc8,0x65
# CHECK: fcvt    z31.h, p7/m, z31.d // encoding: [0xff,0xbf,0xc8,0x65]
# CHECK-ERROR-NOT: fcvt    z31.h, p7/m, z31.d 
0xb7,0xad,0xc8,0x65
# CHECK: fcvt    z23.h, p3/m, z13.d // encoding: [0xb7,0xad,0xc8,0x65]
# CHECK-ERROR-NOT: fcvt    z23.h, p3/m, z13.d 
0x00,0xa0,0xc8,0x65
# CHECK: fcvt    z0.h, p0/m, z0.d // encoding: [0x00,0xa0,0xc8,0x65]
# CHECK-ERROR-NOT: fcvt    z0.h, p0/m, z0.d 
0x55,0xb5,0xc8,0x65
# CHECK: fcvt    z21.h, p5/m, z10.d // encoding: [0x55,0xb5,0xc8,0x65]
# CHECK-ERROR-NOT: fcvt    z21.h, p5/m, z10.d 
