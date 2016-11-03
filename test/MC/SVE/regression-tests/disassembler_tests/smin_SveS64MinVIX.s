# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xdf,0xea,0x25
# CHECK: smin    z31.d, z31.d, #-1 // encoding: [0xff,0xdf,0xea,0x25]
# CHECK-ERROR-NOT: smin    z31.d, z31.d, #-1 
0x55,0xd5,0xea,0x25
# CHECK: smin    z21.d, z21.d, #-86 // encoding: [0x55,0xd5,0xea,0x25]
# CHECK-ERROR-NOT: smin    z21.d, z21.d, #-86 
0x00,0xc0,0xea,0x25
# CHECK: smin    z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xea,0x25]
# CHECK-ERROR-NOT: smin    z0.d, z0.d, #0 
0xb7,0xcd,0xea,0x25
# CHECK: smin    z23.d, z23.d, #109 // encoding: [0xb7,0xcd,0xea,0x25]
# CHECK-ERROR-NOT: smin    z23.d, z23.d, #109 
