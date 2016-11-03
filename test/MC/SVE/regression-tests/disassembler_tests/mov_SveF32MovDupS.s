# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x80,0x21,0x24,0x05
# CHECK: mov     z0.s, s12 // encoding: [0x80,0x21,0x24,0x05]
# CHECK-ERROR-NOT: mov     z0.s, s12 
0x00,0x20,0x24,0x05
# CHECK: mov     z0.s, s0 // encoding: [0x00,0x20,0x24,0x05]
# CHECK-ERROR-NOT: mov     z0.s, s0 
