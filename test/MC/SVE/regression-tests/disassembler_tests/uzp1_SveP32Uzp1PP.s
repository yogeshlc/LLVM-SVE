# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x48,0xa0,0x05
# CHECK: uzp1    p0.s, p0.s, p0.s // encoding: [0x00,0x48,0xa0,0x05]
# CHECK-ERROR-NOT: uzp1    p0.s, p0.s, p0.s 
0xa7,0x49,0xa8,0x05
# CHECK: uzp1    p7.s, p13.s, p8.s // encoding: [0xa7,0x49,0xa8,0x05]
# CHECK-ERROR-NOT: uzp1    p7.s, p13.s, p8.s 
0x45,0x49,0xa5,0x05
# CHECK: uzp1    p5.s, p10.s, p5.s // encoding: [0x45,0x49,0xa5,0x05]
# CHECK-ERROR-NOT: uzp1    p5.s, p10.s, p5.s 
0xef,0x49,0xaf,0x05
# CHECK: uzp1    p15.s, p15.s, p15.s // encoding: [0xef,0x49,0xaf,0x05]
# CHECK-ERROR-NOT: uzp1    p15.s, p15.s, p15.s 
