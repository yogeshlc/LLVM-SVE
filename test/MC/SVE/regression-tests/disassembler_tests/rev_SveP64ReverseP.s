# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0xf4,0x05
# CHECK: rev     p0.d, p0.d // encoding: [0x00,0x40,0xf4,0x05]
# CHECK-ERROR-NOT: rev     p0.d, p0.d 
0xef,0x41,0xf4,0x05
# CHECK: rev     p15.d, p15.d // encoding: [0xef,0x41,0xf4,0x05]
# CHECK-ERROR-NOT: rev     p15.d, p15.d 
0xa7,0x41,0xf4,0x05
# CHECK: rev     p7.d, p13.d // encoding: [0xa7,0x41,0xf4,0x05]
# CHECK-ERROR-NOT: rev     p7.d, p13.d 
0x45,0x41,0xf4,0x05
# CHECK: rev     p5.d, p10.d // encoding: [0x45,0x41,0xf4,0x05]
# CHECK-ERROR-NOT: rev     p5.d, p10.d 
