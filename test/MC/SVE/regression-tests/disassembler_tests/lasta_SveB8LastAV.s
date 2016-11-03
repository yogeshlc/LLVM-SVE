# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x22,0x05
# CHECK: lasta   b23, p3, z13.b // encoding: [0xb7,0x8d,0x22,0x05]
# CHECK-ERROR-NOT: lasta   b23, p3, z13.b 
0x00,0x80,0x22,0x05
# CHECK: lasta   b0, p0, z0.b // encoding: [0x00,0x80,0x22,0x05]
# CHECK-ERROR-NOT: lasta   b0, p0, z0.b 
0x55,0x95,0x22,0x05
# CHECK: lasta   b21, p5, z10.b // encoding: [0x55,0x95,0x22,0x05]
# CHECK-ERROR-NOT: lasta   b21, p5, z10.b 
0xff,0x9f,0x22,0x05
# CHECK: lasta   b31, p7, z31.b // encoding: [0xff,0x9f,0x22,0x05]
# CHECK-ERROR-NOT: lasta   b31, p7, z31.b 
