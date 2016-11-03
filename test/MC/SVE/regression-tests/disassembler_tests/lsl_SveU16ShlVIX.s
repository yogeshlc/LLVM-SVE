# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x9d,0x38,0x04
# CHECK: lsl     z23.h, z13.h, #8 // encoding: [0xb7,0x9d,0x38,0x04]
# CHECK-ERROR-NOT: lsl     z23.h, z13.h, #8 
0xff,0x9f,0x3f,0x04
# CHECK: lsl     z31.h, z31.h, #15 // encoding: [0xff,0x9f,0x3f,0x04]
# CHECK-ERROR-NOT: lsl     z31.h, z31.h, #15 
0x00,0x9c,0x30,0x04
# CHECK: lsl     z0.h, z0.h, #0 // encoding: [0x00,0x9c,0x30,0x04]
# CHECK-ERROR-NOT: lsl     z0.h, z0.h, #0 
0x55,0x9d,0x35,0x04
# CHECK: lsl     z21.h, z10.h, #5 // encoding: [0x55,0x9d,0x35,0x04]
# CHECK-ERROR-NOT: lsl     z21.h, z10.h, #5 
