# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x41,0xb4,0x05
# CHECK: rev     p15.s, p15.s // encoding: [0xef,0x41,0xb4,0x05]
# CHECK-ERROR-NOT: rev     p15.s, p15.s 
0xa7,0x41,0xb4,0x05
# CHECK: rev     p7.s, p13.s // encoding: [0xa7,0x41,0xb4,0x05]
# CHECK-ERROR-NOT: rev     p7.s, p13.s 
0x00,0x40,0xb4,0x05
# CHECK: rev     p0.s, p0.s // encoding: [0x00,0x40,0xb4,0x05]
# CHECK-ERROR-NOT: rev     p0.s, p0.s 
0x45,0x41,0xb4,0x05
# CHECK: rev     p5.s, p10.s // encoding: [0x45,0x41,0xb4,0x05]
# CHECK-ERROR-NOT: rev     p5.s, p10.s 
