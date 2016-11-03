# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x1f,0xff,0x25
# CHECK: whilels p15.d, xzr, xzr // encoding: [0xff,0x1f,0xff,0x25]
# CHECK-ERROR-NOT: whilels p15.d, xzr, xzr 
0x10,0x1c,0xe0,0x25
# CHECK: whilels p0.d, x0, x0 // encoding: [0x10,0x1c,0xe0,0x25]
# CHECK-ERROR-NOT: whilels p0.d, x0, x0 
0xb7,0x1d,0xe8,0x25
# CHECK: whilels p7.d, x13, x8 // encoding: [0xb7,0x1d,0xe8,0x25]
# CHECK-ERROR-NOT: whilels p7.d, x13, x8 
0x55,0x1d,0xf5,0x25
# CHECK: whilels p5.d, x10, x21 // encoding: [0x55,0x1d,0xf5,0x25]
# CHECK-ERROR-NOT: whilels p5.d, x10, x21 
