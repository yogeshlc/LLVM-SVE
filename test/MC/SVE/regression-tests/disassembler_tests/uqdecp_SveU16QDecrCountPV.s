# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x81,0x6b,0x25
# CHECK: uqdecp  z31.h, p15 // encoding: [0xff,0x81,0x6b,0x25]
# CHECK-ERROR-NOT: uqdecp  z31.h, p15 
0x55,0x81,0x6b,0x25
# CHECK: uqdecp  z21.h, p10 // encoding: [0x55,0x81,0x6b,0x25]
# CHECK-ERROR-NOT: uqdecp  z21.h, p10 
0xb7,0x81,0x6b,0x25
# CHECK: uqdecp  z23.h, p13 // encoding: [0xb7,0x81,0x6b,0x25]
# CHECK-ERROR-NOT: uqdecp  z23.h, p13 
0x00,0x80,0x6b,0x25
# CHECK: uqdecp  z0.h, p0 // encoding: [0x00,0x80,0x6b,0x25]
# CHECK-ERROR-NOT: uqdecp  z0.h, p0 
