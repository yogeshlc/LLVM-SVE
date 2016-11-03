# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x81,0xad,0x25
# CHECK: decp    z21.s, p10 // encoding: [0x55,0x81,0xad,0x25]
# CHECK-ERROR-NOT: decp    z21.s, p10 
0xff,0x81,0xad,0x25
# CHECK: decp    z31.s, p15 // encoding: [0xff,0x81,0xad,0x25]
# CHECK-ERROR-NOT: decp    z31.s, p15 
0xb7,0x81,0xad,0x25
# CHECK: decp    z23.s, p13 // encoding: [0xb7,0x81,0xad,0x25]
# CHECK-ERROR-NOT: decp    z23.s, p13 
0x00,0x80,0xad,0x25
# CHECK: decp    z0.s, p0 // encoding: [0x00,0x80,0xad,0x25]
# CHECK-ERROR-NOT: decp    z0.s, p0 
