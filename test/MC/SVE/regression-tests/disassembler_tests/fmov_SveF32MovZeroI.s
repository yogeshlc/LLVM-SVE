# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x15,0xc0,0xb8,0x25
# CHECK: mov     z21.s, #0 // encoding: [0x15,0xc0,0xb8,0x25]
# CHECK-ERROR-NOT: mov     z21.s, #0 
0x1f,0xc0,0xb8,0x25
# CHECK: mov     z31.s, #0 // encoding: [0x1f,0xc0,0xb8,0x25]
# CHECK-ERROR-NOT: mov     z31.s, #0 
0x17,0xc0,0xb8,0x25
# CHECK: mov     z23.s, #0 // encoding: [0x17,0xc0,0xb8,0x25]
# CHECK-ERROR-NOT: mov     z23.s, #0 
