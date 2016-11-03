# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x40,0x90,0x25
# CHECK: brkb    p0.b, p0/m, p0.b // encoding: [0x10,0x40,0x90,0x25]
# CHECK-ERROR-NOT: brkb    p0.b, p0/m, p0.b 
0xb7,0x6d,0x90,0x25
# CHECK: brkb    p7.b, p11/m, p13.b // encoding: [0xb7,0x6d,0x90,0x25]
# CHECK-ERROR-NOT: brkb    p7.b, p11/m, p13.b 
0x55,0x55,0x90,0x25
# CHECK: brkb    p5.b, p5/m, p10.b // encoding: [0x55,0x55,0x90,0x25]
# CHECK-ERROR-NOT: brkb    p5.b, p5/m, p10.b 
0xff,0x7d,0x90,0x25
# CHECK: brkb    p15.b, p15/m, p15.b // encoding: [0xff,0x7d,0x90,0x25]
# CHECK-ERROR-NOT: brkb    p15.b, p15/m, p15.b 
