# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xc0,0xaa,0x25
# CHECK: smin    z0.s, z0.s, #0 // encoding: [0x00,0xc0,0xaa,0x25]
# CHECK-ERROR-NOT: smin    z0.s, z0.s, #0 
0xff,0xdf,0xaa,0x25
# CHECK: smin    z31.s, z31.s, #-1 // encoding: [0xff,0xdf,0xaa,0x25]
# CHECK-ERROR-NOT: smin    z31.s, z31.s, #-1 
0xb7,0xcd,0xaa,0x25
# CHECK: smin    z23.s, z23.s, #109 // encoding: [0xb7,0xcd,0xaa,0x25]
# CHECK-ERROR-NOT: smin    z23.s, z23.s, #109 
0x55,0xd5,0xaa,0x25
# CHECK: smin    z21.s, z21.s, #-86 // encoding: [0x55,0xd5,0xaa,0x25]
# CHECK-ERROR-NOT: smin    z21.s, z21.s, #-86 
