# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x90,0xa0,0x04
# CHECK: asr     z0.d, z0.d, #64 // encoding: [0x00,0x90,0xa0,0x04]
# CHECK-ERROR-NOT: asr     z0.d, z0.d, #64 
0x55,0x91,0xf5,0x04
# CHECK: asr     z21.d, z10.d, #11 // encoding: [0x55,0x91,0xf5,0x04]
# CHECK-ERROR-NOT: asr     z21.d, z10.d, #11 
0xff,0x93,0xff,0x04
# CHECK: asr     z31.d, z31.d, #1 // encoding: [0xff,0x93,0xff,0x04]
# CHECK-ERROR-NOT: asr     z31.d, z31.d, #1 
0xb7,0x91,0xe8,0x04
# CHECK: asr     z23.d, z13.d, #24 // encoding: [0xb7,0x91,0xe8,0x04]
# CHECK-ERROR-NOT: asr     z23.d, z13.d, #24 
