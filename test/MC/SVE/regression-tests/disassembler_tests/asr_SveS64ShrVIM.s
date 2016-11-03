# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0xc0,0x04
# CHECK: asr     z23.d, p3/m, z23.d, #19 // encoding: [0xb7,0x8d,0xc0,0x04]
# CHECK-ERROR-NOT: asr     z23.d, p3/m, z23.d, #19 
0xff,0x9f,0xc0,0x04
# CHECK: asr     z31.d, p7/m, z31.d, #1 // encoding: [0xff,0x9f,0xc0,0x04]
# CHECK-ERROR-NOT: asr     z31.d, p7/m, z31.d, #1 
0x00,0x80,0x80,0x04
# CHECK: asr     z0.d, p0/m, z0.d, #64 // encoding: [0x00,0x80,0x80,0x04]
# CHECK-ERROR-NOT: asr     z0.d, p0/m, z0.d, #64 
0x55,0x95,0xc0,0x04
# CHECK: asr     z21.d, p5/m, z21.d, #22 // encoding: [0x55,0x95,0xc0,0x04]
# CHECK-ERROR-NOT: asr     z21.d, p5/m, z21.d, #22 
