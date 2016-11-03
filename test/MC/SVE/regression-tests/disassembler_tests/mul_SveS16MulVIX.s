# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xcd,0x70,0x25
# CHECK: mul     z23.h, z23.h, #109 // encoding: [0xb7,0xcd,0x70,0x25]
# CHECK-ERROR-NOT: mul     z23.h, z23.h, #109 
0x00,0xc0,0x70,0x25
# CHECK: mul     z0.h, z0.h, #0 // encoding: [0x00,0xc0,0x70,0x25]
# CHECK-ERROR-NOT: mul     z0.h, z0.h, #0 
0x55,0xd5,0x70,0x25
# CHECK: mul     z21.h, z21.h, #-86 // encoding: [0x55,0xd5,0x70,0x25]
# CHECK-ERROR-NOT: mul     z21.h, z21.h, #-86 
0xff,0xdf,0x70,0x25
# CHECK: mul     z31.h, z31.h, #-1 // encoding: [0xff,0xdf,0x70,0x25]
# CHECK-ERROR-NOT: mul     z31.h, z31.h, #-1 
