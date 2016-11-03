# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x1f,0x40,0xdf,0x05
# CHECK: mov     z31.d, p15/m, #0 // encoding: [0x1f,0x40,0xdf,0x05]
# CHECK-ERROR-NOT: mov     z31.d, p15/m, #0 
0x17,0x40,0xd8,0x05
# CHECK: mov     z23.d, p8/m, #0 // encoding: [0x17,0x40,0xd8,0x05]
# CHECK-ERROR-NOT: mov     z23.d, p8/m, #0 
0x15,0x40,0xd5,0x05
# CHECK: mov     z21.d, p5/m, #0 // encoding: [0x15,0x40,0xd5,0x05]
# CHECK-ERROR-NOT: mov     z21.d, p5/m, #0 
