# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0x90,0x05
# CHECK: mov     z0.s, p0/m, #0 // encoding: [0x00,0x40,0x90,0x05]
# CHECK-ERROR-NOT: mov     z0.s, p0/m, #0 
0x55,0x55,0x95,0x05
# CHECK: mov     z21.s, p5/m, #-86 // encoding: [0x55,0x55,0x95,0x05]
# CHECK-ERROR-NOT: mov     z21.s, p5/m, #-86 
0xff,0x7f,0x9f,0x05
# CHECK: mov     z31.s, p15/m, #-256 // encoding: [0xff,0x7f,0x9f,0x05]
# CHECK-ERROR-NOT: mov     z31.s, p15/m, #-256 
0xb7,0x6d,0x98,0x05
# CHECK: mov     z23.s, p8/m, #27904 // encoding: [0xb7,0x6d,0x98,0x05]
# CHECK-ERROR-NOT: mov     z23.s, p8/m, #27904 
