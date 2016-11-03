# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0xc5,0xd9,0x25
# CHECK: pnext   p5.d, p10, p5.d // encoding: [0x45,0xc5,0xd9,0x25]
# CHECK-ERROR-NOT: pnext   p5.d, p10, p5.d 
0xa7,0xc5,0xd9,0x25
# CHECK: pnext   p7.d, p13, p7.d // encoding: [0xa7,0xc5,0xd9,0x25]
# CHECK-ERROR-NOT: pnext   p7.d, p13, p7.d 
0x00,0xc4,0xd9,0x25
# CHECK: pnext   p0.d, p0, p0.d // encoding: [0x00,0xc4,0xd9,0x25]
# CHECK-ERROR-NOT: pnext   p0.d, p0, p0.d 
0xef,0xc5,0xd9,0x25
# CHECK: pnext   p15.d, p15, p15.d // encoding: [0xef,0xc5,0xd9,0x25]
# CHECK-ERROR-NOT: pnext   p15.d, p15, p15.d 
