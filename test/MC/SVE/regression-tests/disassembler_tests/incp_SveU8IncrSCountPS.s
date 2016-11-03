# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x88,0x2c,0x25
# CHECK: incp    x0, p0.b // encoding: [0x00,0x88,0x2c,0x25]
# CHECK-ERROR-NOT: incp    x0, p0.b 
0xb7,0x89,0x2c,0x25
# CHECK: incp    x23, p13.b // encoding: [0xb7,0x89,0x2c,0x25]
# CHECK-ERROR-NOT: incp    x23, p13.b 
0x55,0x89,0x2c,0x25
# CHECK: incp    x21, p10.b // encoding: [0x55,0x89,0x2c,0x25]
# CHECK-ERROR-NOT: incp    x21, p10.b 
0xff,0x89,0x2c,0x25
# CHECK: incp    xzr, p15.b // encoding: [0xff,0x89,0x2c,0x25]
# CHECK-ERROR-NOT: incp    xzr, p15.b 
