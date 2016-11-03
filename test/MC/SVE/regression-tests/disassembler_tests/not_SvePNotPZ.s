# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x57,0x05,0x25
# CHECK: not     p5.b, p5/z, p10.b // encoding: [0x45,0x57,0x05,0x25]
# CHECK-ERROR-NOT: not     p5.b, p5/z, p10.b 
0x00,0x42,0x00,0x25
# CHECK: not     p0.b, p0/z, p0.b // encoding: [0x00,0x42,0x00,0x25]
# CHECK-ERROR-NOT: not     p0.b, p0/z, p0.b 
0xef,0x7f,0x0f,0x25
# CHECK: not     p15.b, p15/z, p15.b // encoding: [0xef,0x7f,0x0f,0x25]
# CHECK-ERROR-NOT: not     p15.b, p15/z, p15.b 
