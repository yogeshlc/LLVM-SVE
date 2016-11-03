# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x89,0x2b,0x25
# CHECK: uqdecp  wzr, p15.b // encoding: [0xff,0x89,0x2b,0x25]
# CHECK-ERROR-NOT: uqdecp  wzr, p15.b 
0x55,0x89,0x2b,0x25
# CHECK: uqdecp  w21, p10.b // encoding: [0x55,0x89,0x2b,0x25]
# CHECK-ERROR-NOT: uqdecp  w21, p10.b 
0xb7,0x89,0x2b,0x25
# CHECK: uqdecp  w23, p13.b // encoding: [0xb7,0x89,0x2b,0x25]
# CHECK-ERROR-NOT: uqdecp  w23, p13.b 
0x00,0x88,0x2b,0x25
# CHECK: uqdecp  w0, p0.b // encoding: [0x00,0x88,0x2b,0x25]
# CHECK-ERROR-NOT: uqdecp  w0, p0.b 
