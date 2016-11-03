# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0xf1,0x18,0x25
# CHECK: rdffr   p15.b, p15/z // encoding: [0xef,0xf1,0x18,0x25]
# CHECK-ERROR-NOT: rdffr   p15.b, p15/z 
0x00,0xf0,0x18,0x25
# CHECK: rdffr   p0.b, p0/z // encoding: [0x00,0xf0,0x18,0x25]
# CHECK-ERROR-NOT: rdffr   p0.b, p0/z 
0xa7,0xf1,0x18,0x25
# CHECK: rdffr   p7.b, p13/z // encoding: [0xa7,0xf1,0x18,0x25]
# CHECK-ERROR-NOT: rdffr   p7.b, p13/z 
0x45,0xf1,0x18,0x25
# CHECK: rdffr   p5.b, p10/z // encoding: [0x45,0xf1,0x18,0x25]
# CHECK-ERROR-NOT: rdffr   p5.b, p10/z 
