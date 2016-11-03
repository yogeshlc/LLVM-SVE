# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x13,0xff,0x04
# CHECK: sqadd   z31.d, z31.d, z31.d // encoding: [0xff,0x13,0xff,0x04]
# CHECK-ERROR-NOT: sqadd   z31.d, z31.d, z31.d 
0x00,0x10,0xe0,0x04
# CHECK: sqadd   z0.d, z0.d, z0.d // encoding: [0x00,0x10,0xe0,0x04]
# CHECK-ERROR-NOT: sqadd   z0.d, z0.d, z0.d 
0xb7,0x11,0xe8,0x04
# CHECK: sqadd   z23.d, z13.d, z8.d // encoding: [0xb7,0x11,0xe8,0x04]
# CHECK-ERROR-NOT: sqadd   z23.d, z13.d, z8.d 
0x55,0x11,0xf5,0x04
# CHECK: sqadd   z21.d, z10.d, z21.d // encoding: [0x55,0x11,0xf5,0x04]
# CHECK-ERROR-NOT: sqadd   z21.d, z10.d, z21.d 
