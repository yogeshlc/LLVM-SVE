# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x41,0x34,0x05
# CHECK: rev     p5.b, p10.b // encoding: [0x45,0x41,0x34,0x05]
# CHECK-ERROR-NOT: rev     p5.b, p10.b 
0x00,0x40,0x34,0x05
# CHECK: rev     p0.b, p0.b // encoding: [0x00,0x40,0x34,0x05]
# CHECK-ERROR-NOT: rev     p0.b, p0.b 
0xef,0x41,0x34,0x05
# CHECK: rev     p15.b, p15.b // encoding: [0xef,0x41,0x34,0x05]
# CHECK-ERROR-NOT: rev     p15.b, p15.b 
0xa7,0x41,0x34,0x05
# CHECK: rev     p7.b, p13.b // encoding: [0xa7,0x41,0x34,0x05]
# CHECK-ERROR-NOT: rev     p7.b, p13.b 
