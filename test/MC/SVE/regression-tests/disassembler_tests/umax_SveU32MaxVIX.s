# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0xa9,0x25
# CHECK: umax    z21.s, z21.s, #170 // encoding: [0x55,0xd5,0xa9,0x25]
# CHECK-ERROR-NOT: umax    z21.s, z21.s, #170 
0xb7,0xcd,0xa9,0x25
# CHECK: umax    z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xa9,0x25]
# CHECK-ERROR-NOT: umax    z23.s, z23.s, #109 
0x00,0xc0,0xa9,0x25
# CHECK: umax    z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xa9,0x25]
# CHECK-ERROR-NOT: umax    z0.s, z0.s, #0 
0xff,0xdf,0xa9,0x25
# CHECK: umax    z31.s, z31.s, #255 // encoding: [0xff,0xdf,0xa9,0x25]
# CHECK-ERROR-NOT: umax    z31.s, z31.s, #255 
