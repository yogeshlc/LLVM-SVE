# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x1f,0x12,0x04
# CHECK: smulh   z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x1f,0x12,0x04]
# CHECK-ERROR-NOT: smulh   z31.b, p7/m, z31.b, z31.b 
0xb7,0x0d,0x12,0x04
# CHECK: smulh   z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x0d,0x12,0x04]
# CHECK-ERROR-NOT: smulh   z23.b, p3/m, z23.b, z13.b 
0x00,0x00,0x12,0x04
# CHECK: smulh   z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x00,0x12,0x04]
# CHECK-ERROR-NOT: smulh   z0.b, p0/m, z0.b, z0.b 
0x55,0x15,0x12,0x04
# CHECK: smulh   z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x15,0x12,0x04]
# CHECK-ERROR-NOT: smulh   z21.b, p5/m, z21.b, z10.b 
