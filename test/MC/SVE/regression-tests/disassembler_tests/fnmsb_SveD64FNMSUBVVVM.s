# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0xff,0x65
# CHECK: fnmsb   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xff,0xff,0x65]
# CHECK-ERROR-NOT: fnmsb   z31.d, p7/m, z31.d, z31.d 
0xb7,0xed,0xe8,0x65
# CHECK: fnmsb   z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0xed,0xe8,0x65]
# CHECK-ERROR-NOT: fnmsb   z23.d, p3/m, z13.d, z8.d 
0x55,0xf5,0xf5,0x65
# CHECK: fnmsb   z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0xf5,0xf5,0x65]
# CHECK-ERROR-NOT: fnmsb   z21.d, p5/m, z10.d, z21.d 
0x00,0xe0,0xe0,0x65
# CHECK: fnmsb   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xe0,0xe0,0x65]
# CHECK-ERROR-NOT: fnmsb   z0.d, p0/m, z0.d, z0.d 
