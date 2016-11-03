# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x84,0x20,0x04
# CHECK: lsr     z0.b, z0.b, z0.d // encoding: [0x00,0x84,0x20,0x04]
# CHECK-ERROR-NOT: lsr     z0.b, z0.b, z0.d 
0xff,0x87,0x3f,0x04
# CHECK: lsr     z31.b, z31.b, z31.d // encoding: [0xff,0x87,0x3f,0x04]
# CHECK-ERROR-NOT: lsr     z31.b, z31.b, z31.d 
0x55,0x85,0x35,0x04
# CHECK: lsr     z21.b, z10.b, z21.d // encoding: [0x55,0x85,0x35,0x04]
# CHECK-ERROR-NOT: lsr     z21.b, z10.b, z21.d 
0xb7,0x85,0x28,0x04
# CHECK: lsr     z23.b, z13.b, z8.d // encoding: [0xb7,0x85,0x28,0x04]
# CHECK-ERROR-NOT: lsr     z23.b, z13.b, z8.d 
