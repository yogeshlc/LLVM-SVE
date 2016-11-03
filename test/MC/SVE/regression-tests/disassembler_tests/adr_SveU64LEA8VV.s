# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xad,0xf5,0x04
# CHECK: adr     z21.d, [z10.d, z21.d, lsl #3] // encoding: [0x55,0xad,0xf5,0x04]
# CHECK-ERROR-NOT: adr     z21.d, [z10.d, z21.d, lsl #3] 
0xb7,0xad,0xe8,0x04
# CHECK: adr     z23.d, [z13.d, z8.d, lsl #3] // encoding: [0xb7,0xad,0xe8,0x04]
# CHECK-ERROR-NOT: adr     z23.d, [z13.d, z8.d, lsl #3] 
0x00,0xac,0xe0,0x04
# CHECK: adr     z0.d, [z0.d, z0.d, lsl #3] // encoding: [0x00,0xac,0xe0,0x04]
# CHECK-ERROR-NOT: adr     z0.d, [z0.d, z0.d, lsl #3] 
0xff,0xaf,0xff,0x04
# CHECK: adr     z31.d, [z31.d, z31.d, lsl #3] // encoding: [0xff,0xaf,0xff,0x04]
# CHECK-ERROR-NOT: adr     z31.d, [z31.d, z31.d, lsl #3] 
