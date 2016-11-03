# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xd5,0x6b,0x25
# CHECK: umin    z21.h, z21.h, #170 // encoding: [0x55,0xd5,0x6b,0x25]
# CHECK-ERROR-NOT: umin    z21.h, z21.h, #170 
0xb7,0xcd,0x6b,0x25
# CHECK: umin    z23.h, z23.h, #109 // encoding: [0xb7,0xcd,0x6b,0x25]
# CHECK-ERROR-NOT: umin    z23.h, z23.h, #109 
0x00,0xc0,0x6b,0x25
# CHECK: umin    z0.h, z0.h, #0 // encoding: [0x00,0xc0,0x6b,0x25]
# CHECK-ERROR-NOT: umin    z0.h, z0.h, #0 
0xff,0xdf,0x6b,0x25
# CHECK: umin    z31.h, z31.h, #255 // encoding: [0xff,0xdf,0x6b,0x25]
# CHECK-ERROR-NOT: umin    z31.h, z31.h, #255 
