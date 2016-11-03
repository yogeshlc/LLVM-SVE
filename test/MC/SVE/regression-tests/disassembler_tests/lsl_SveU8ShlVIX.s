# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x2f,0x04
# CHECK: lsl     z31.b, z31.b, #7 // encoding: [0xff,0x9f,0x2f,0x04]
# CHECK-ERROR-NOT: lsl     z31.b, z31.b, #7 
0x00,0x9c,0x28,0x04
# CHECK: lsl     z0.b, z0.b, #0 // encoding: [0x00,0x9c,0x28,0x04]
# CHECK-ERROR-NOT: lsl     z0.b, z0.b, #0 
0xb7,0x9d,0x28,0x04
# CHECK: lsl     z23.b, z13.b, #0 // encoding: [0xb7,0x9d,0x28,0x04]
# CHECK-ERROR-NOT: lsl     z23.b, z13.b, #0 
0x55,0x9d,0x2d,0x04
# CHECK: lsl     z21.b, z10.b, #5 // encoding: [0x55,0x9d,0x2d,0x04]
# CHECK-ERROR-NOT: lsl     z21.b, z10.b, #5 
