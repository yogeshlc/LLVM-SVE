# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x49,0xe8,0x05
# CHECK: uzp1    p7.d, p13.d, p8.d // encoding: [0xa7,0x49,0xe8,0x05]
# CHECK-ERROR-NOT: uzp1    p7.d, p13.d, p8.d 
0xef,0x49,0xef,0x05
# CHECK: uzp1    p15.d, p15.d, p15.d // encoding: [0xef,0x49,0xef,0x05]
# CHECK-ERROR-NOT: uzp1    p15.d, p15.d, p15.d 
0x45,0x49,0xe5,0x05
# CHECK: uzp1    p5.d, p10.d, p5.d // encoding: [0x45,0x49,0xe5,0x05]
# CHECK-ERROR-NOT: uzp1    p5.d, p10.d, p5.d 
0x00,0x48,0xe0,0x05
# CHECK: uzp1    p0.d, p0.d, p0.d // encoding: [0x00,0x48,0xe0,0x05]
# CHECK-ERROR-NOT: uzp1    p0.d, p0.d, p0.d 
