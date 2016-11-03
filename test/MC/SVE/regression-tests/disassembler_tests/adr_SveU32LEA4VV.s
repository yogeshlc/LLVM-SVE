# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xa9,0xa8,0x04
# CHECK: adr     z23.s, [z13.s, z8.s, lsl #2] // encoding: [0xb7,0xa9,0xa8,0x04]
# CHECK-ERROR-NOT: adr     z23.s, [z13.s, z8.s, lsl #2] 
0x55,0xa9,0xb5,0x04
# CHECK: adr     z21.s, [z10.s, z21.s, lsl #2] // encoding: [0x55,0xa9,0xb5,0x04]
# CHECK-ERROR-NOT: adr     z21.s, [z10.s, z21.s, lsl #2] 
0xff,0xab,0xbf,0x04
# CHECK: adr     z31.s, [z31.s, z31.s, lsl #2] // encoding: [0xff,0xab,0xbf,0x04]
# CHECK-ERROR-NOT: adr     z31.s, [z31.s, z31.s, lsl #2] 
0x00,0xa8,0xa0,0x04
# CHECK: adr     z0.s, [z0.s, z0.s, lsl #2] // encoding: [0x00,0xa8,0xa0,0x04]
# CHECK-ERROR-NOT: adr     z0.s, [z0.s, z0.s, lsl #2] 
