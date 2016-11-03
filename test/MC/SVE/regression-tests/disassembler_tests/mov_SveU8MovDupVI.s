# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0x22,0xf1,0x05
# CHECK: mov     z5.b, z17.b[56] // encoding: [0x25,0x22,0xf1,0x05]
# CHECK-ERROR-NOT: mov     z5.b, z17.b[56] 
0xb7,0x21,0x69,0x05
# CHECK: mov     z23.b, z13.b[20] // encoding: [0xb7,0x21,0x69,0x05]
# CHECK-ERROR-NOT: mov     z23.b, z13.b[20] 
0xff,0x23,0xff,0x05
# CHECK: mov     z31.b, z31.b[63] // encoding: [0xff,0x23,0xff,0x05]
# CHECK-ERROR-NOT: mov     z31.b, z31.b[63] 
0x55,0x21,0x75,0x05
# CHECK: mov     z21.b, z10.b[26] // encoding: [0x55,0x21,0x75,0x05]
# CHECK-ERROR-NOT: mov     z21.b, z10.b[26] 
