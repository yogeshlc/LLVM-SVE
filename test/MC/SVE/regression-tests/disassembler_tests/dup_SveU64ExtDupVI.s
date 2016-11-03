# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x23,0xf8,0x05
# CHECK: mov     z31.d, z31.d[7] // encoding: [0xff,0x23,0xf8,0x05]
# CHECK-ERROR-NOT: mov     z31.d, z31.d[7] 
0x25,0x22,0xf8,0x05
# CHECK: mov     z5.d, z17.d[7] // encoding: [0x25,0x22,0xf8,0x05]
# CHECK-ERROR-NOT: mov     z5.d, z17.d[7] 
0x00,0x20,0x28,0x05
# CHECK: mov     z0.d, d0 // encoding: [0x00,0x20,0x28,0x05]
# CHECK-ERROR-NOT: mov     z0.d, d0 
0x80,0x21,0x28,0x05
# CHECK: mov     z0.d, d12 // encoding: [0x80,0x21,0x28,0x05]
# CHECK-ERROR-NOT: mov     z0.d, d12 
0x55,0x21,0x78,0x05
# CHECK: mov     z21.d, z10.d[3] // encoding: [0x55,0x21,0x78,0x05]
# CHECK-ERROR-NOT: mov     z21.d, z10.d[3] 
0xb7,0x21,0x68,0x05
# CHECK: mov     z23.d, z13.d[2] // encoding: [0xb7,0x21,0x68,0x05]
# CHECK-ERROR-NOT: mov     z23.d, z13.d[2] 
