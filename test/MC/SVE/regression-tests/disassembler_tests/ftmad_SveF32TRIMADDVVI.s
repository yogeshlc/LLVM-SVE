# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0x90,0x65
# CHECK: ftmad   z0.s, z0.s, z0.s, #0 // encoding: [0x00,0x80,0x90,0x65]
# CHECK-ERROR-NOT: ftmad   z0.s, z0.s, z0.s, #0 
0xb7,0x81,0x90,0x65
# CHECK: ftmad   z23.s, z23.s, z13.s, #0 // encoding: [0xb7,0x81,0x90,0x65]
# CHECK-ERROR-NOT: ftmad   z23.s, z23.s, z13.s, #0 
0xff,0x83,0x97,0x65
# CHECK: ftmad   z31.s, z31.s, z31.s, #7 // encoding: [0xff,0x83,0x97,0x65]
# CHECK-ERROR-NOT: ftmad   z31.s, z31.s, z31.s, #7 
0x55,0x81,0x95,0x65
# CHECK: ftmad   z21.s, z21.s, z10.s, #5 // encoding: [0x55,0x81,0x95,0x65]
# CHECK-ERROR-NOT: ftmad   z21.s, z21.s, z10.s, #5 
