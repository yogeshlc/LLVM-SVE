# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x31,0x8f,0x65
# CHECK: frsqrte z21.s, z10.s // encoding: [0x55,0x31,0x8f,0x65]
# CHECK-ERROR-NOT: frsqrte z21.s, z10.s 
0xb7,0x31,0x8f,0x65
# CHECK: frsqrte z23.s, z13.s // encoding: [0xb7,0x31,0x8f,0x65]
# CHECK-ERROR-NOT: frsqrte z23.s, z13.s 
0x00,0x30,0x8f,0x65
# CHECK: frsqrte z0.s, z0.s // encoding: [0x00,0x30,0x8f,0x65]
# CHECK-ERROR-NOT: frsqrte z0.s, z0.s 
0xff,0x33,0x8f,0x65
# CHECK: frsqrte z31.s, z31.s // encoding: [0xff,0x33,0x8f,0x65]
# CHECK-ERROR-NOT: frsqrte z31.s, z31.s 
