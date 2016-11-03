# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0x22,0xf4,0x05
# CHECK: mov     z5.s, z17.s[14] // encoding: [0x25,0x22,0xf4,0x05]
# CHECK-ERROR-NOT: mov     z5.s, z17.s[14] 
0x55,0x21,0x74,0x05
# CHECK: mov     z21.s, z10.s[6] // encoding: [0x55,0x21,0x74,0x05]
# CHECK-ERROR-NOT: mov     z21.s, z10.s[6] 
0xff,0x23,0xfc,0x05
# CHECK: mov     z31.s, z31.s[15] // encoding: [0xff,0x23,0xfc,0x05]
# CHECK-ERROR-NOT: mov     z31.s, z31.s[15] 
0xb7,0x21,0x6c,0x05
# CHECK: mov     z23.s, z13.s[5] // encoding: [0xb7,0x21,0x6c,0x05]
# CHECK-ERROR-NOT: mov     z23.s, z13.s[5] 
