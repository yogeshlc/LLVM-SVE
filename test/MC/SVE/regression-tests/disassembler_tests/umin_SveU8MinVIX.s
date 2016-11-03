# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xcd,0x2b,0x25
# CHECK: umin    z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x2b,0x25]
# CHECK-ERROR-NOT: umin    z23.b, z23.b, #109 
0x55,0xd5,0x2b,0x25
# CHECK: umin    z21.b, z21.b, #170 // encoding: [0x55,0xd5,0x2b,0x25]
# CHECK-ERROR-NOT: umin    z21.b, z21.b, #170 
0xff,0xdf,0x2b,0x25
# CHECK: umin    z31.b, z31.b, #255 // encoding: [0xff,0xdf,0x2b,0x25]
# CHECK-ERROR-NOT: umin    z31.b, z31.b, #255 
0x00,0xc0,0x2b,0x25
# CHECK: umin    z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x2b,0x25]
# CHECK-ERROR-NOT: umin    z0.b, z0.b, #0 
