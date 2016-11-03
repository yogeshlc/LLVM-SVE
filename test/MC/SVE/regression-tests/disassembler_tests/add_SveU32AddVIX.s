# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0xa0,0x25
# CHECK: add     z31.s, z31.s, #65280 // encoding: [0xff,0xff,0xa0,0x25]
# CHECK-ERROR-NOT: add     z31.s, z31.s, #65280 
0x55,0xd5,0xa0,0x25
# CHECK: add     z21.s, z21.s, #170 // encoding: [0x55,0xd5,0xa0,0x25]
# CHECK-ERROR-NOT: add     z21.s, z21.s, #170 
0x00,0xc0,0xa0,0x25
# CHECK: add     z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xa0,0x25]
# CHECK-ERROR-NOT: add     z0.s, z0.s, #0 
0xb7,0xed,0xa0,0x25
# CHECK: add     z23.s, z23.s, #27904 // encoding: [0xb7,0xed,0xa0,0x25]
# CHECK-ERROR-NOT: add     z23.s, z23.s, #27904 
