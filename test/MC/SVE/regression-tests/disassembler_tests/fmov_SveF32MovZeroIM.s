# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x17,0x40,0x98,0x05
# CHECK: mov     z23.s, p8/m, #0 // encoding: [0x17,0x40,0x98,0x05]
# CHECK-ERROR-NOT: mov     z23.s, p8/m, #0 
0x1f,0x40,0x9f,0x05
# CHECK: mov     z31.s, p15/m, #0 // encoding: [0x1f,0x40,0x9f,0x05]
# CHECK-ERROR-NOT: mov     z31.s, p15/m, #0 
0x15,0x40,0x95,0x05
# CHECK: mov     z21.s, p5/m, #0 // encoding: [0x15,0x40,0x95,0x05]
# CHECK-ERROR-NOT: mov     z21.s, p5/m, #0 
