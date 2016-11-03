# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0xc5,0x19,0x25
# CHECK: pnext   p7.b, p13, p7.b // encoding: [0xa7,0xc5,0x19,0x25]
# CHECK-ERROR-NOT: pnext   p7.b, p13, p7.b 
0x00,0xc4,0x19,0x25
# CHECK: pnext   p0.b, p0, p0.b // encoding: [0x00,0xc4,0x19,0x25]
# CHECK-ERROR-NOT: pnext   p0.b, p0, p0.b 
0xef,0xc5,0x19,0x25
# CHECK: pnext   p15.b, p15, p15.b // encoding: [0xef,0xc5,0x19,0x25]
# CHECK-ERROR-NOT: pnext   p15.b, p15, p15.b 
0x45,0xc5,0x19,0x25
# CHECK: pnext   p5.b, p10, p5.b // encoding: [0x45,0xc5,0x19,0x25]
# CHECK-ERROR-NOT: pnext   p5.b, p10, p5.b 
