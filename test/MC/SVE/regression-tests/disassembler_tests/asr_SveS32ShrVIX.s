# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x93,0x7f,0x04
# CHECK: asr     z31.s, z31.s, #1 // encoding: [0xff,0x93,0x7f,0x04]
# CHECK-ERROR-NOT: asr     z31.s, z31.s, #1 
0x00,0x90,0x60,0x04
# CHECK: asr     z0.s, z0.s, #32 // encoding: [0x00,0x90,0x60,0x04]
# CHECK-ERROR-NOT: asr     z0.s, z0.s, #32 
0xb7,0x91,0x68,0x04
# CHECK: asr     z23.s, z13.s, #24 // encoding: [0xb7,0x91,0x68,0x04]
# CHECK-ERROR-NOT: asr     z23.s, z13.s, #24 
0x55,0x91,0x75,0x04
# CHECK: asr     z21.s, z10.s, #11 // encoding: [0x55,0x91,0x75,0x04]
# CHECK-ERROR-NOT: asr     z21.s, z10.s, #11 
