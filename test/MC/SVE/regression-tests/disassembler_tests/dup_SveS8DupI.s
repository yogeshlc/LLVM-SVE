# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0xce,0x38,0x25
# CHECK: mov     z5.b, #113 // encoding: [0x25,0xce,0x38,0x25]
# CHECK-ERROR-NOT: mov     z5.b, #113 
0x00,0xc0,0x38,0x25
# CHECK: mov     z0.b, #0 // encoding: [0x00,0xc0,0x38,0x25]
# CHECK-ERROR-NOT: mov     z0.b, #0 
0x55,0xd5,0x38,0x25
# CHECK: mov     z21.b, #-86 // encoding: [0x55,0xd5,0x38,0x25]
# CHECK-ERROR-NOT: mov     z21.b, #-86 
0x21,0xc4,0x38,0x25
# CHECK: mov     z1.b, #33 // encoding: [0x21,0xc4,0x38,0x25]
# CHECK-ERROR-NOT: mov     z1.b, #33 
