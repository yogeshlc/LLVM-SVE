# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x89,0x6d,0x25
# CHECK: decp    xzr, p15.h // encoding: [0xff,0x89,0x6d,0x25]
# CHECK-ERROR-NOT: decp    xzr, p15.h 
0xb7,0x89,0x6d,0x25
# CHECK: decp    x23, p13.h // encoding: [0xb7,0x89,0x6d,0x25]
# CHECK-ERROR-NOT: decp    x23, p13.h 
0x55,0x89,0x6d,0x25
# CHECK: decp    x21, p10.h // encoding: [0x55,0x89,0x6d,0x25]
# CHECK-ERROR-NOT: decp    x21, p10.h 
0x00,0x88,0x6d,0x25
# CHECK: decp    x0, p0.h // encoding: [0x00,0x88,0x6d,0x25]
# CHECK-ERROR-NOT: decp    x0, p0.h 
