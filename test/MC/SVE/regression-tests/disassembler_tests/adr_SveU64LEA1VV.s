# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xa1,0xf5,0x04
# CHECK: adr     z21.d, [z10.d, z21.d] // encoding: [0x55,0xa1,0xf5,0x04]
# CHECK-ERROR-NOT: adr     z21.d, [z10.d, z21.d] 
0xff,0xa3,0xff,0x04
# CHECK: adr     z31.d, [z31.d, z31.d] // encoding: [0xff,0xa3,0xff,0x04]
# CHECK-ERROR-NOT: adr     z31.d, [z31.d, z31.d] 
0xb7,0xa1,0xe8,0x04
# CHECK: adr     z23.d, [z13.d, z8.d] // encoding: [0xb7,0xa1,0xe8,0x04]
# CHECK-ERROR-NOT: adr     z23.d, [z13.d, z8.d] 
0x00,0xa0,0xe0,0x04
# CHECK: adr     z0.d, [z0.d, z0.d] // encoding: [0x00,0xa0,0xe0,0x04]
# CHECK-ERROR-NOT: adr     z0.d, [z0.d, z0.d] 
