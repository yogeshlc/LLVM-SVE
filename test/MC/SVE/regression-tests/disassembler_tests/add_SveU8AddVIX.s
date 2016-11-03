# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0xce,0x20,0x25
# CHECK: add     z5.b, z5.b, #113 // encoding: [0x25,0xce,0x20,0x25]
# CHECK-ERROR-NOT: add     z5.b, z5.b, #113 
0x21,0xc4,0x20,0x25
# CHECK: add     z1.b, z1.b, #33 // encoding: [0x21,0xc4,0x20,0x25]
# CHECK-ERROR-NOT: add     z1.b, z1.b, #33 
0x55,0xd5,0x20,0x25
# CHECK: add     z21.b, z21.b, #170 // encoding: [0x55,0xd5,0x20,0x25]
# CHECK-ERROR-NOT: add     z21.b, z21.b, #170 
0x00,0xc0,0x20,0x25
# CHECK: add     z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x20,0x25]
# CHECK-ERROR-NOT: add     z0.b, z0.b, #0 
