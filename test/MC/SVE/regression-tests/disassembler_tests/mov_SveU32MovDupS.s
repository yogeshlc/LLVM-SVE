# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x39,0xa0,0x05
# CHECK: mov     z23.s, w13 // encoding: [0xb7,0x39,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z23.s, w13 
0x00,0x38,0xa0,0x05
# CHECK: mov     z0.s, w0 // encoding: [0x00,0x38,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z0.s, w0 
0xff,0x3b,0xa0,0x05
# CHECK: mov     z31.s, wsp // encoding: [0xff,0x3b,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z31.s, wsp 
0x55,0x39,0xa0,0x05
# CHECK: mov     z21.s, w10 // encoding: [0x55,0x39,0xa0,0x05]
# CHECK-ERROR-NOT: mov     z21.s, w10 
