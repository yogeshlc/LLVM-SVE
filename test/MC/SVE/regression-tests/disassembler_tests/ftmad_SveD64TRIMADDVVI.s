# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x83,0xd7,0x65
# CHECK: ftmad   z31.d, z31.d, z31.d, #7 // encoding: [0xff,0x83,0xd7,0x65]
# CHECK-ERROR-NOT: ftmad   z31.d, z31.d, z31.d, #7 
0x55,0x81,0xd5,0x65
# CHECK: ftmad   z21.d, z21.d, z10.d, #5 // encoding: [0x55,0x81,0xd5,0x65]
# CHECK-ERROR-NOT: ftmad   z21.d, z21.d, z10.d, #5 
0xb7,0x81,0xd0,0x65
# CHECK: ftmad   z23.d, z23.d, z13.d, #0 // encoding: [0xb7,0x81,0xd0,0x65]
# CHECK-ERROR-NOT: ftmad   z23.d, z23.d, z13.d, #0 
0x00,0x80,0xd0,0x65
# CHECK: ftmad   z0.d, z0.d, z0.d, #0 // encoding: [0x00,0x80,0xd0,0x65]
# CHECK-ERROR-NOT: ftmad   z0.d, z0.d, z0.d, #0 
