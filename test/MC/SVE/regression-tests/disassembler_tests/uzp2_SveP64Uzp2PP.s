# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x4d,0xe8,0x05
# CHECK: uzp2    p7.d, p13.d, p8.d // encoding: [0xa7,0x4d,0xe8,0x05]
# CHECK-ERROR-NOT: uzp2    p7.d, p13.d, p8.d 
0xef,0x4d,0xef,0x05
# CHECK: uzp2    p15.d, p15.d, p15.d // encoding: [0xef,0x4d,0xef,0x05]
# CHECK-ERROR-NOT: uzp2    p15.d, p15.d, p15.d 
0x00,0x4c,0xe0,0x05
# CHECK: uzp2    p0.d, p0.d, p0.d // encoding: [0x00,0x4c,0xe0,0x05]
# CHECK-ERROR-NOT: uzp2    p0.d, p0.d, p0.d 
0x45,0x4d,0xe5,0x05
# CHECK: uzp2    p5.d, p10.d, p5.d // encoding: [0x45,0x4d,0xe5,0x05]
# CHECK-ERROR-NOT: uzp2    p5.d, p10.d, p5.d 
