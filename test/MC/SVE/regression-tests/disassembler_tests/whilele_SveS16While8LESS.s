# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x14,0x60,0x25
# CHECK: whilele p0.h, x0, x0 // encoding: [0x10,0x14,0x60,0x25]
# CHECK-ERROR-NOT: whilele p0.h, x0, x0 
0xff,0x17,0x7f,0x25
# CHECK: whilele p15.h, xzr, xzr // encoding: [0xff,0x17,0x7f,0x25]
# CHECK-ERROR-NOT: whilele p15.h, xzr, xzr 
0xb7,0x15,0x68,0x25
# CHECK: whilele p7.h, x13, x8 // encoding: [0xb7,0x15,0x68,0x25]
# CHECK-ERROR-NOT: whilele p7.h, x13, x8 
0x55,0x15,0x75,0x25
# CHECK: whilele p5.h, x10, x21 // encoding: [0x55,0x15,0x75,0x25]
# CHECK-ERROR-NOT: whilele p5.h, x10, x21 
