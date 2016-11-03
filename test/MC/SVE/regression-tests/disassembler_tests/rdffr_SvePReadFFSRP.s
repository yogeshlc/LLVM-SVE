# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xf0,0x19,0x25
# CHECK: rdffr   p0.b // encoding: [0x00,0xf0,0x19,0x25]
# CHECK-ERROR-NOT: rdffr   p0.b 
0x05,0xf0,0x19,0x25
# CHECK: rdffr   p5.b // encoding: [0x05,0xf0,0x19,0x25]
# CHECK-ERROR-NOT: rdffr   p5.b 
0x0f,0xf0,0x19,0x25
# CHECK: rdffr   p15.b // encoding: [0x0f,0xf0,0x19,0x25]
# CHECK-ERROR-NOT: rdffr   p15.b 
0x07,0xf0,0x19,0x25
# CHECK: rdffr   p7.b // encoding: [0x07,0xf0,0x19,0x25]
# CHECK-ERROR-NOT: rdffr   p7.b 
