# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x89,0xab,0x25
# CHECK: uqdecp  w21, p10.s // encoding: [0x55,0x89,0xab,0x25]
# CHECK-ERROR-NOT: uqdecp  w21, p10.s 
0xff,0x89,0xab,0x25
# CHECK: uqdecp  wzr, p15.s // encoding: [0xff,0x89,0xab,0x25]
# CHECK-ERROR-NOT: uqdecp  wzr, p15.s 
0xb7,0x89,0xab,0x25
# CHECK: uqdecp  w23, p13.s // encoding: [0xb7,0x89,0xab,0x25]
# CHECK-ERROR-NOT: uqdecp  w23, p13.s 
0x00,0x88,0xab,0x25
# CHECK: uqdecp  w0, p0.s // encoding: [0x00,0x88,0xab,0x25]
# CHECK-ERROR-NOT: uqdecp  w0, p0.s 
