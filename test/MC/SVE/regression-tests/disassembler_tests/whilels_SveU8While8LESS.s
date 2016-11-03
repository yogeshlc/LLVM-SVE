# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x1d,0x28,0x25
# CHECK: whilels p7.b, x13, x8 // encoding: [0xb7,0x1d,0x28,0x25]
# CHECK-ERROR-NOT: whilels p7.b, x13, x8 
0x55,0x1d,0x35,0x25
# CHECK: whilels p5.b, x10, x21 // encoding: [0x55,0x1d,0x35,0x25]
# CHECK-ERROR-NOT: whilels p5.b, x10, x21 
0xff,0x1f,0x3f,0x25
# CHECK: whilels p15.b, xzr, xzr // encoding: [0xff,0x1f,0x3f,0x25]
# CHECK-ERROR-NOT: whilels p15.b, xzr, xzr 
0x10,0x1c,0x20,0x25
# CHECK: whilels p0.b, x0, x0 // encoding: [0x10,0x1c,0x20,0x25]
# CHECK-ERROR-NOT: whilels p0.b, x0, x0 
