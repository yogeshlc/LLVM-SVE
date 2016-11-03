# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x8f,0x7f,0x04
# CHECK: lsl     z31.h, z31.h, z31.d // encoding: [0xff,0x8f,0x7f,0x04]
# CHECK-ERROR-NOT: lsl     z31.h, z31.h, z31.d 
0x00,0x8c,0x60,0x04
# CHECK: lsl     z0.h, z0.h, z0.d // encoding: [0x00,0x8c,0x60,0x04]
# CHECK-ERROR-NOT: lsl     z0.h, z0.h, z0.d 
0xb7,0x8d,0x68,0x04
# CHECK: lsl     z23.h, z13.h, z8.d // encoding: [0xb7,0x8d,0x68,0x04]
# CHECK-ERROR-NOT: lsl     z23.h, z13.h, z8.d 
0x55,0x8d,0x75,0x04
# CHECK: lsl     z21.h, z10.h, z21.d // encoding: [0x55,0x8d,0x75,0x04]
# CHECK-ERROR-NOT: lsl     z21.h, z10.h, z21.d 
