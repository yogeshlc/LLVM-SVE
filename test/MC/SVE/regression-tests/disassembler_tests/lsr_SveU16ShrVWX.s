# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x84,0x60,0x04
# CHECK: lsr     z0.h, z0.h, z0.d // encoding: [0x00,0x84,0x60,0x04]
# CHECK-ERROR-NOT: lsr     z0.h, z0.h, z0.d 
0x55,0x85,0x75,0x04
# CHECK: lsr     z21.h, z10.h, z21.d // encoding: [0x55,0x85,0x75,0x04]
# CHECK-ERROR-NOT: lsr     z21.h, z10.h, z21.d 
0xff,0x87,0x7f,0x04
# CHECK: lsr     z31.h, z31.h, z31.d // encoding: [0xff,0x87,0x7f,0x04]
# CHECK-ERROR-NOT: lsr     z31.h, z31.h, z31.d 
0xb7,0x85,0x68,0x04
# CHECK: lsr     z23.h, z13.h, z8.d // encoding: [0xb7,0x85,0x68,0x04]
# CHECK-ERROR-NOT: lsr     z23.h, z13.h, z8.d 
