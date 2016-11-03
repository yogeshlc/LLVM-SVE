# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x17,0xbf,0x25
# CHECK: whilele p15.s, xzr, xzr // encoding: [0xff,0x17,0xbf,0x25]
# CHECK-ERROR-NOT: whilele p15.s, xzr, xzr 
0x55,0x15,0xb5,0x25
# CHECK: whilele p5.s, x10, x21 // encoding: [0x55,0x15,0xb5,0x25]
# CHECK-ERROR-NOT: whilele p5.s, x10, x21 
0xb7,0x15,0xa8,0x25
# CHECK: whilele p7.s, x13, x8 // encoding: [0xb7,0x15,0xa8,0x25]
# CHECK-ERROR-NOT: whilele p7.s, x13, x8 
0x10,0x14,0xa0,0x25
# CHECK: whilele p0.s, x0, x0 // encoding: [0x10,0x14,0xa0,0x25]
# CHECK-ERROR-NOT: whilele p0.s, x0, x0 
