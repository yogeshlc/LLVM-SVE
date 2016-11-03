# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x43,0x04
# CHECK: lsl     z31.s, p7/m, z31.s, #31 // encoding: [0xff,0x9f,0x43,0x04]
# CHECK-ERROR-NOT: lsl     z31.s, p7/m, z31.s, #31 
0xb7,0x8d,0x43,0x04
# CHECK: lsl     z23.s, p3/m, z23.s, #13 // encoding: [0xb7,0x8d,0x43,0x04]
# CHECK-ERROR-NOT: lsl     z23.s, p3/m, z23.s, #13 
0x55,0x95,0x43,0x04
# CHECK: lsl     z21.s, p5/m, z21.s, #10 // encoding: [0x55,0x95,0x43,0x04]
# CHECK-ERROR-NOT: lsl     z21.s, p5/m, z21.s, #10 
0x00,0x80,0x43,0x04
# CHECK: lsl     z0.s, p0/m, z0.s, #0 // encoding: [0x00,0x80,0x43,0x04]
# CHECK-ERROR-NOT: lsl     z0.s, p0/m, z0.s, #0 
