# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xa0,0x04
# CHECK: asr     z0.s, z0.s, z0.d // encoding: [0x00,0x80,0xa0,0x04]
# CHECK-ERROR-NOT: asr     z0.s, z0.s, z0.d 
0x55,0x81,0xb5,0x04
# CHECK: asr     z21.s, z10.s, z21.d // encoding: [0x55,0x81,0xb5,0x04]
# CHECK-ERROR-NOT: asr     z21.s, z10.s, z21.d 
0xb7,0x81,0xa8,0x04
# CHECK: asr     z23.s, z13.s, z8.d // encoding: [0xb7,0x81,0xa8,0x04]
# CHECK-ERROR-NOT: asr     z23.s, z13.s, z8.d 
0xff,0x83,0xbf,0x04
# CHECK: asr     z31.s, z31.s, z31.d // encoding: [0xff,0x83,0xbf,0x04]
# CHECK-ERROR-NOT: asr     z31.s, z31.s, z31.d 
