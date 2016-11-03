# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x20,0x22,0x05
# CHECK: mov     z0.h, h0 // encoding: [0x00,0x20,0x22,0x05]
# CHECK-ERROR-NOT: mov     z0.h, h0 
0x80,0x21,0x22,0x05
# CHECK: mov     z0.h, h12 // encoding: [0x80,0x21,0x22,0x05]
# CHECK-ERROR-NOT: mov     z0.h, h12 
0xb7,0x21,0x6a,0x05
# CHECK: mov     z23.h, z13.h[10] // encoding: [0xb7,0x21,0x6a,0x05]
# CHECK-ERROR-NOT: mov     z23.h, z13.h[10] 
0x25,0x22,0xf2,0x05
# CHECK: mov     z5.h, z17.h[28] // encoding: [0x25,0x22,0xf2,0x05]
# CHECK-ERROR-NOT: mov     z5.h, z17.h[28] 
0xff,0x23,0xfe,0x05
# CHECK: mov     z31.h, z31.h[31] // encoding: [0xff,0x23,0xfe,0x05]
# CHECK-ERROR-NOT: mov     z31.h, z31.h[31] 
0x55,0x21,0x76,0x05
# CHECK: mov     z21.h, z10.h[13] // encoding: [0x55,0x21,0x76,0x05]
# CHECK-ERROR-NOT: mov     z21.h, z10.h[13] 
