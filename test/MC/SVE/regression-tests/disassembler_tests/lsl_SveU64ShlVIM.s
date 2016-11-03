# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0xc3,0x04
# CHECK: lsl     z23.d, p3/m, z23.d, #45 // encoding: [0xb7,0x8d,0xc3,0x04]
# CHECK-ERROR-NOT: lsl     z23.d, p3/m, z23.d, #45 
0x00,0x80,0x83,0x04
# CHECK: lsl     z0.d, p0/m, z0.d, #0 // encoding: [0x00,0x80,0x83,0x04]
# CHECK-ERROR-NOT: lsl     z0.d, p0/m, z0.d, #0 
0xff,0x9f,0xc3,0x04
# CHECK: lsl     z31.d, p7/m, z31.d, #63 // encoding: [0xff,0x9f,0xc3,0x04]
# CHECK-ERROR-NOT: lsl     z31.d, p7/m, z31.d, #63 
0x55,0x95,0xc3,0x04
# CHECK: lsl     z21.d, p5/m, z21.d, #42 // encoding: [0x55,0x95,0xc3,0x04]
# CHECK-ERROR-NOT: lsl     z21.d, p5/m, z21.d, #42 
