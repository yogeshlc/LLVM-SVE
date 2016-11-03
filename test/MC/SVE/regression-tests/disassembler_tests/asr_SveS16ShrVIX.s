# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x91,0x35,0x04
# CHECK: asr     z21.h, z10.h, #11 // encoding: [0x55,0x91,0x35,0x04]
# CHECK-ERROR-NOT: asr     z21.h, z10.h, #11 
0xb7,0x91,0x38,0x04
# CHECK: asr     z23.h, z13.h, #8 // encoding: [0xb7,0x91,0x38,0x04]
# CHECK-ERROR-NOT: asr     z23.h, z13.h, #8 
0xff,0x93,0x3f,0x04
# CHECK: asr     z31.h, z31.h, #1 // encoding: [0xff,0x93,0x3f,0x04]
# CHECK-ERROR-NOT: asr     z31.h, z31.h, #1 
0x00,0x90,0x30,0x04
# CHECK: asr     z0.h, z0.h, #16 // encoding: [0x00,0x90,0x30,0x04]
# CHECK-ERROR-NOT: asr     z0.h, z0.h, #16 
