# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xdf,0x28,0x25
# CHECK: smax    z31.b, z31.b, #-1 // encoding: [0xff,0xdf,0x28,0x25]
# CHECK-ERROR-NOT: smax    z31.b, z31.b, #-1 
0xb7,0xcd,0x28,0x25
# CHECK: smax    z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x28,0x25]
# CHECK-ERROR-NOT: smax    z23.b, z23.b, #109 
0x00,0xc0,0x28,0x25
# CHECK: smax    z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x28,0x25]
# CHECK-ERROR-NOT: smax    z0.b, z0.b, #0 
0x55,0xd5,0x28,0x25
# CHECK: smax    z21.b, z21.b, #-86 // encoding: [0x55,0xd5,0x28,0x25]
# CHECK-ERROR-NOT: smax    z21.b, z21.b, #-86 
