# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x91,0x28,0x04
# CHECK: asr     z23.b, z13.b, #8 // encoding: [0xb7,0x91,0x28,0x04]
# CHECK-ERROR-NOT: asr     z23.b, z13.b, #8 
0x55,0x91,0x2d,0x04
# CHECK: asr     z21.b, z10.b, #3 // encoding: [0x55,0x91,0x2d,0x04]
# CHECK-ERROR-NOT: asr     z21.b, z10.b, #3 
0xff,0x93,0x2f,0x04
# CHECK: asr     z31.b, z31.b, #1 // encoding: [0xff,0x93,0x2f,0x04]
# CHECK-ERROR-NOT: asr     z31.b, z31.b, #1 
0x00,0x90,0x28,0x04
# CHECK: asr     z0.b, z0.b, #8 // encoding: [0x00,0x90,0x28,0x04]
# CHECK-ERROR-NOT: asr     z0.b, z0.b, #8 
