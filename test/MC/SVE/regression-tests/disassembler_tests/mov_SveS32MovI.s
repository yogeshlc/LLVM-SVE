# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xff,0xb8,0x25
# CHECK: mov     z31.s, #-256 // encoding: [0xff,0xff,0xb8,0x25]
# CHECK-ERROR-NOT: mov     z31.s, #-256 
0xb7,0xed,0xb8,0x25
# CHECK: mov     z23.s, #27904 // encoding: [0xb7,0xed,0xb8,0x25]
# CHECK-ERROR-NOT: mov     z23.s, #27904 
0x00,0xc0,0xb8,0x25
# CHECK: mov     z0.s, #0 // encoding: [0x00,0xc0,0xb8,0x25]
# CHECK-ERROR-NOT: mov     z0.s, #0 
0x55,0xd5,0xb8,0x25
# CHECK: mov     z21.s, #-86 // encoding: [0x55,0xd5,0xb8,0x25]
# CHECK-ERROR-NOT: mov     z21.s, #-86 
