# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0xa0,0x05
# CHECK: mov     z21.s, p5/m, s10 // encoding: [0x55,0x95,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z21.s, p5/m, s10 
0xff,0x9f,0xa0,0x05
# CHECK: mov     z31.s, p7/m, s31 // encoding: [0xff,0x9f,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z31.s, p7/m, s31 
0x00,0x80,0xa0,0x05
# CHECK: mov     z0.s, p0/m, s0 // encoding: [0x00,0x80,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z0.s, p0/m, s0 
0xb7,0x8d,0xa0,0x05
# CHECK: mov     z23.s, p3/m, s13 // encoding: [0xb7,0x8d,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z23.s, p3/m, s13 
