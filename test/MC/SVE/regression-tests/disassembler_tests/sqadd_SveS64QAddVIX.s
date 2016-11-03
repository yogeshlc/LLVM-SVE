# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0xe4,0x25
# CHECK: sqadd   z21.d, z21.d, #170 // encoding: [0x55,0xd5,0xe4,0x25]
# CHECK-ERROR-NOT: sqadd   z21.d, z21.d, #170 
0x00,0xc0,0xe4,0x25
# CHECK: sqadd   z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xe4,0x25]
# CHECK-ERROR-NOT: sqadd   z0.d, z0.d, #0 
0xff,0xff,0xe4,0x25
# CHECK: sqadd   z31.d, z31.d, #65280 // encoding: [0xff,0xff,0xe4,0x25]
# CHECK-ERROR-NOT: sqadd   z31.d, z31.d, #65280 
0xb7,0xed,0xe4,0x25
# CHECK: sqadd   z23.d, z23.d, #27904 // encoding: [0xb7,0xed,0xe4,0x25]
# CHECK-ERROR-NOT: sqadd   z23.d, z23.d, #27904 
