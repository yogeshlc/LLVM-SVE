# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xc5,0x99,0x25
# CHECK: pnext   p5.s, p10, p5.s // encoding: [0x45,0xc5,0x99,0x25]
# CHECK-ERROR-NOT: pnext   p5.s, p10, p5.s 
0x00,0xc4,0x99,0x25
# CHECK: pnext   p0.s, p0, p0.s // encoding: [0x00,0xc4,0x99,0x25]
# CHECK-ERROR-NOT: pnext   p0.s, p0, p0.s 
0xa7,0xc5,0x99,0x25
# CHECK: pnext   p7.s, p13, p7.s // encoding: [0xa7,0xc5,0x99,0x25]
# CHECK-ERROR-NOT: pnext   p7.s, p13, p7.s 
0xef,0xc5,0x99,0x25
# CHECK: pnext   p15.s, p15, p15.s // encoding: [0xef,0xc5,0x99,0x25]
# CHECK-ERROR-NOT: pnext   p15.s, p15, p15.s 
