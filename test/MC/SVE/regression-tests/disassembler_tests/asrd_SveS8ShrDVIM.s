# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x04,0x04
# CHECK: asrd    z23.b, p3/m, z23.b, #3 // encoding: [0xb7,0x8d,0x04,0x04]
# CHECK-ERROR-NOT: asrd    z23.b, p3/m, z23.b, #3 
0xff,0x9d,0x04,0x04
# CHECK: asrd    z31.b, p7/m, z31.b, #1 // encoding: [0xff,0x9d,0x04,0x04]
# CHECK-ERROR-NOT: asrd    z31.b, p7/m, z31.b, #1 
0x00,0x81,0x04,0x04
# CHECK: asrd    z0.b, p0/m, z0.b, #8 // encoding: [0x00,0x81,0x04,0x04]
# CHECK-ERROR-NOT: asrd    z0.b, p0/m, z0.b, #8 
0x55,0x95,0x04,0x04
# CHECK: asrd    z21.b, p5/m, z21.b, #6 // encoding: [0x55,0x95,0x04,0x04]
# CHECK-ERROR-NOT: asrd    z21.b, p5/m, z21.b, #6 
