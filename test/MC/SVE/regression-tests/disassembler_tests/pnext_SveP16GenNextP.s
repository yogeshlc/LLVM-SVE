# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0xc5,0x59,0x25
# CHECK: pnext   p7.h, p13, p7.h // encoding: [0xa7,0xc5,0x59,0x25]
# CHECK-ERROR-NOT: pnext   p7.h, p13, p7.h 
0x00,0xc4,0x59,0x25
# CHECK: pnext   p0.h, p0, p0.h // encoding: [0x00,0xc4,0x59,0x25]
# CHECK-ERROR-NOT: pnext   p0.h, p0, p0.h 
0x45,0xc5,0x59,0x25
# CHECK: pnext   p5.h, p10, p5.h // encoding: [0x45,0xc5,0x59,0x25]
# CHECK-ERROR-NOT: pnext   p5.h, p10, p5.h 
0xef,0xc5,0x59,0x25
# CHECK: pnext   p15.h, p15, p15.h // encoding: [0xef,0xc5,0x59,0x25]
# CHECK-ERROR-NOT: pnext   p15.h, p15, p15.h 
