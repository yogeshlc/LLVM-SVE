# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x89,0x2d,0x25
# CHECK: decp    x23, p13.b // encoding: [0xb7,0x89,0x2d,0x25]
# CHECK-ERROR-NOT: decp    x23, p13.b 
0x00,0x88,0x2d,0x25
# CHECK: decp    x0, p0.b // encoding: [0x00,0x88,0x2d,0x25]
# CHECK-ERROR-NOT: decp    x0, p0.b 
0x55,0x89,0x2d,0x25
# CHECK: decp    x21, p10.b // encoding: [0x55,0x89,0x2d,0x25]
# CHECK-ERROR-NOT: decp    x21, p10.b 
0xff,0x89,0x2d,0x25
# CHECK: decp    xzr, p15.b // encoding: [0xff,0x89,0x2d,0x25]
# CHECK-ERROR-NOT: decp    xzr, p15.b 
