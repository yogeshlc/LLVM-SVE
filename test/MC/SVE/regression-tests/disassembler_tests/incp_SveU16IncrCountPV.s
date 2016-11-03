# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x81,0x6c,0x25
# CHECK: incp    z31.h, p15 // encoding: [0xff,0x81,0x6c,0x25]
# CHECK-ERROR-NOT: incp    z31.h, p15 
0x55,0x81,0x6c,0x25
# CHECK: incp    z21.h, p10 // encoding: [0x55,0x81,0x6c,0x25]
# CHECK-ERROR-NOT: incp    z21.h, p10 
0x00,0x80,0x6c,0x25
# CHECK: incp    z0.h, p0 // encoding: [0x00,0x80,0x6c,0x25]
# CHECK-ERROR-NOT: incp    z0.h, p0 
0xb7,0x81,0x6c,0x25
# CHECK: incp    z23.h, p13 // encoding: [0xb7,0x81,0x6c,0x25]
# CHECK-ERROR-NOT: incp    z23.h, p13 
