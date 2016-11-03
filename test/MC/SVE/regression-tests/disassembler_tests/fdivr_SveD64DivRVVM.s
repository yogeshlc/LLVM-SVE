# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xcc,0x65
# CHECK: fdivr   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x80,0xcc,0x65]
# CHECK-ERROR-NOT: fdivr   z0.d, p0/m, z0.d, z0.d 
0x55,0x95,0xcc,0x65
# CHECK: fdivr   z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0x95,0xcc,0x65]
# CHECK-ERROR-NOT: fdivr   z21.d, p5/m, z21.d, z10.d 
0xff,0x9f,0xcc,0x65
# CHECK: fdivr   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x9f,0xcc,0x65]
# CHECK-ERROR-NOT: fdivr   z31.d, p7/m, z31.d, z31.d 
0xb7,0x8d,0xcc,0x65
# CHECK: fdivr   z23.d, p3/m, z23.d, z13.d // encoding: [0xb7,0x8d,0xcc,0x65]
# CHECK-ERROR-NOT: fdivr   z23.d, p3/m, z23.d, z13.d 
