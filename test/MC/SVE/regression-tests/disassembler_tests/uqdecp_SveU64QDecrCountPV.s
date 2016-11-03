# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x81,0xeb,0x25
# CHECK: uqdecp  z31.d, p15 // encoding: [0xff,0x81,0xeb,0x25]
# CHECK-ERROR-NOT: uqdecp  z31.d, p15 
0x55,0x81,0xeb,0x25
# CHECK: uqdecp  z21.d, p10 // encoding: [0x55,0x81,0xeb,0x25]
# CHECK-ERROR-NOT: uqdecp  z21.d, p10 
0x00,0x80,0xeb,0x25
# CHECK: uqdecp  z0.d, p0 // encoding: [0x00,0x80,0xeb,0x25]
# CHECK-ERROR-NOT: uqdecp  z0.d, p0 
0xb7,0x81,0xeb,0x25
# CHECK: uqdecp  z23.d, p13 // encoding: [0xb7,0x81,0xeb,0x25]
# CHECK-ERROR-NOT: uqdecp  z23.d, p13 
