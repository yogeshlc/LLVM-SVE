# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x03,0x04
# CHECK: lsl     z21.b, p5/m, z21.b, #2 // encoding: [0x55,0x95,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z21.b, p5/m, z21.b, #2 
0xff,0x9d,0x03,0x04
# CHECK: lsl     z31.b, p7/m, z31.b, #7 // encoding: [0xff,0x9d,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z31.b, p7/m, z31.b, #7 
0x00,0x81,0x03,0x04
# CHECK: lsl     z0.b, p0/m, z0.b, #0 // encoding: [0x00,0x81,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z0.b, p0/m, z0.b, #0 
0xb7,0x8d,0x03,0x04
# CHECK: lsl     z23.b, p3/m, z23.b, #5 // encoding: [0xb7,0x8d,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z23.b, p3/m, z23.b, #5 
