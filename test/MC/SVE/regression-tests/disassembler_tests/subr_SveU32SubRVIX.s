# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0xa3,0x25
# CHECK: subr    z23.s, z23.s, #27904 // encoding: [0xb7,0xed,0xa3,0x25]
# CHECK-ERROR-NOT: subr    z23.s, z23.s, #27904 
0xff,0xff,0xa3,0x25
# CHECK: subr    z31.s, z31.s, #65280 // encoding: [0xff,0xff,0xa3,0x25]
# CHECK-ERROR-NOT: subr    z31.s, z31.s, #65280 
0x55,0xd5,0xa3,0x25
# CHECK: subr    z21.s, z21.s, #170 // encoding: [0x55,0xd5,0xa3,0x25]
# CHECK-ERROR-NOT: subr    z21.s, z21.s, #170 
0x00,0xc0,0xa3,0x25
# CHECK: subr    z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xa3,0x25]
# CHECK-ERROR-NOT: subr    z0.s, z0.s, #0 
