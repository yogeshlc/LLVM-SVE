# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x1d,0x75,0x25
# CHECK: whilels p5.h, x10, x21 // encoding: [0x55,0x1d,0x75,0x25]
# CHECK-ERROR-NOT: whilels p5.h, x10, x21 
0x10,0x1c,0x60,0x25
# CHECK: whilels p0.h, x0, x0 // encoding: [0x10,0x1c,0x60,0x25]
# CHECK-ERROR-NOT: whilels p0.h, x0, x0 
0xff,0x1f,0x7f,0x25
# CHECK: whilels p15.h, xzr, xzr // encoding: [0xff,0x1f,0x7f,0x25]
# CHECK-ERROR-NOT: whilels p15.h, xzr, xzr 
0xb7,0x1d,0x68,0x25
# CHECK: whilels p7.h, x13, x8 // encoding: [0xb7,0x1d,0x68,0x25]
# CHECK-ERROR-NOT: whilels p7.h, x13, x8 
