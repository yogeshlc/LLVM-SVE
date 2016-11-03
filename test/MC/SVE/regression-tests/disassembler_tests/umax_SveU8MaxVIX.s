# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0x29,0x25
# CHECK: umax    z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x29,0x25]
# CHECK-ERROR-NOT: umax    z0.b, z0.b, #0 
0xff,0xdf,0x29,0x25
# CHECK: umax    z31.b, z31.b, #255 // encoding: [0xff,0xdf,0x29,0x25]
# CHECK-ERROR-NOT: umax    z31.b, z31.b, #255 
0x55,0xd5,0x29,0x25
# CHECK: umax    z21.b, z21.b, #170 // encoding: [0x55,0xd5,0x29,0x25]
# CHECK-ERROR-NOT: umax    z21.b, z21.b, #170 
0xb7,0xcd,0x29,0x25
# CHECK: umax    z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x29,0x25]
# CHECK-ERROR-NOT: umax    z23.b, z23.b, #109 
