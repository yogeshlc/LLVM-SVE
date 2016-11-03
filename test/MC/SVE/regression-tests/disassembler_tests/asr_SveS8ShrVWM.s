# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x18,0x04
# CHECK: asr     z31.b, p7/m, z31.b, z31.d // encoding: [0xff,0x9f,0x18,0x04]
# CHECK-ERROR-NOT: asr     z31.b, p7/m, z31.b, z31.d 
0x55,0x95,0x18,0x04
# CHECK: asr     z21.b, p5/m, z21.b, z10.d // encoding: [0x55,0x95,0x18,0x04]
# CHECK-ERROR-NOT: asr     z21.b, p5/m, z21.b, z10.d 
0x00,0x80,0x18,0x04
# CHECK: asr     z0.b, p0/m, z0.b, z0.d // encoding: [0x00,0x80,0x18,0x04]
# CHECK-ERROR-NOT: asr     z0.b, p0/m, z0.b, z0.d 
0xb7,0x8d,0x18,0x04
# CHECK: asr     z23.b, p3/m, z23.b, z13.d // encoding: [0xb7,0x8d,0x18,0x04]
# CHECK-ERROR-NOT: asr     z23.b, p3/m, z23.b, z13.d 
