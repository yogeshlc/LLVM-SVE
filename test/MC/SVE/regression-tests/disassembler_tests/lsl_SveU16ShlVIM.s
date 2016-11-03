# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x97,0x03,0x04
# CHECK: lsl     z21.h, p5/m, z21.h, #10 // encoding: [0x55,0x97,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z21.h, p5/m, z21.h, #10 
0xb7,0x8f,0x03,0x04
# CHECK: lsl     z23.h, p3/m, z23.h, #13 // encoding: [0xb7,0x8f,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z23.h, p3/m, z23.h, #13 
0xff,0x9f,0x03,0x04
# CHECK: lsl     z31.h, p7/m, z31.h, #15 // encoding: [0xff,0x9f,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z31.h, p7/m, z31.h, #15 
0x00,0x82,0x03,0x04
# CHECK: lsl     z0.h, p0/m, z0.h, #0 // encoding: [0x00,0x82,0x03,0x04]
# CHECK-ERROR-NOT: lsl     z0.h, p0/m, z0.h, #0 
