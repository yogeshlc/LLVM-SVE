# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x6d,0x88,0x25
# CHECK: orr     p7.b, p11/z, p13.b, p8.b // encoding: [0xa7,0x6d,0x88,0x25]
# CHECK-ERROR-NOT: orr     p7.b, p11/z, p13.b, p8.b 
0xef,0x7d,0x8f,0x25
# CHECK: mov     p15.b, p15.b // encoding: [0xef,0x7d,0x8f,0x25]
# CHECK-ERROR-NOT: mov     p15.b, p15.b 
0x00,0x40,0x80,0x25
# CHECK: mov     p0.b, p0.b // encoding: [0x00,0x40,0x80,0x25]
# CHECK-ERROR-NOT: mov     p0.b, p0.b 
0x45,0x55,0x85,0x25
# CHECK: orr     p5.b, p5/z, p10.b, p5.b // encoding: [0x45,0x55,0x85,0x25]
# CHECK-ERROR-NOT: orr     p5.b, p5/z, p10.b, p5.b 
