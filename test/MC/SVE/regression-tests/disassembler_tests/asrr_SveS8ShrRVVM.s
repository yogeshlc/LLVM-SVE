# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x14,0x04
# CHECK: asrr    z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x95,0x14,0x04]
# CHECK-ERROR-NOT: asrr    z21.b, p5/m, z21.b, z10.b 
0xff,0x9f,0x14,0x04
# CHECK: asrr    z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x9f,0x14,0x04]
# CHECK-ERROR-NOT: asrr    z31.b, p7/m, z31.b, z31.b 
0x00,0x80,0x14,0x04
# CHECK: asrr    z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x80,0x14,0x04]
# CHECK-ERROR-NOT: asrr    z0.b, p0/m, z0.b, z0.b 
0xb7,0x8d,0x14,0x04
# CHECK: asrr    z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x8d,0x14,0x04]
# CHECK-ERROR-NOT: asrr    z23.b, p3/m, z23.b, z13.b 
