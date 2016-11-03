# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0x10,0x25
# CHECK: brka    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x10,0x25]
# CHECK-ERROR-NOT: brka    p0.b, p0/z, p0.b 
0xa7,0x6d,0x10,0x25
# CHECK: brka    p7.b, p11/z, p13.b // encoding: [0xa7,0x6d,0x10,0x25]
# CHECK-ERROR-NOT: brka    p7.b, p11/z, p13.b 
0xef,0x7d,0x10,0x25
# CHECK: brka    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x10,0x25]
# CHECK-ERROR-NOT: brka    p15.b, p15/z, p15.b 
0x45,0x55,0x10,0x25
# CHECK: brka    p5.b, p5/z, p10.b // encoding: [0x45,0x55,0x10,0x25]
# CHECK-ERROR-NOT: brka    p5.b, p5/z, p10.b 
