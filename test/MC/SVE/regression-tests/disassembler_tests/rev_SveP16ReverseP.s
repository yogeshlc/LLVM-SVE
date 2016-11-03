# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x40,0x74,0x05
# CHECK: rev     p0.h, p0.h // encoding: [0x00,0x40,0x74,0x05]
# CHECK-ERROR-NOT: rev     p0.h, p0.h 
0x45,0x41,0x74,0x05
# CHECK: rev     p5.h, p10.h // encoding: [0x45,0x41,0x74,0x05]
# CHECK-ERROR-NOT: rev     p5.h, p10.h 
0xa7,0x41,0x74,0x05
# CHECK: rev     p7.h, p13.h // encoding: [0xa7,0x41,0x74,0x05]
# CHECK-ERROR-NOT: rev     p7.h, p13.h 
0xef,0x41,0x74,0x05
# CHECK: rev     p15.h, p15.h // encoding: [0xef,0x41,0x74,0x05]
# CHECK-ERROR-NOT: rev     p15.h, p15.h 
