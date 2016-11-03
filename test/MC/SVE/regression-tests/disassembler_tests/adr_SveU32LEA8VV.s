# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xaf,0xbf,0x04
# CHECK: adr     z31.s, [z31.s, z31.s, lsl #3] // encoding: [0xff,0xaf,0xbf,0x04]
# CHECK-ERROR-NOT: adr     z31.s, [z31.s, z31.s, lsl #3] 
0x00,0xac,0xa0,0x04
# CHECK: adr     z0.s, [z0.s, z0.s, lsl #3] // encoding: [0x00,0xac,0xa0,0x04]
# CHECK-ERROR-NOT: adr     z0.s, [z0.s, z0.s, lsl #3] 
0xb7,0xad,0xa8,0x04
# CHECK: adr     z23.s, [z13.s, z8.s, lsl #3] // encoding: [0xb7,0xad,0xa8,0x04]
# CHECK-ERROR-NOT: adr     z23.s, [z13.s, z8.s, lsl #3] 
0x55,0xad,0xb5,0x04
# CHECK: adr     z21.s, [z10.s, z21.s, lsl #3] // encoding: [0x55,0xad,0xb5,0x04]
# CHECK-ERROR-NOT: adr     z21.s, [z10.s, z21.s, lsl #3] 
