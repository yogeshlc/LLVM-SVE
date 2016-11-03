# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x17,0xbf,0x25
# CHECK: whilelt p15.s, xzr, xzr // encoding: [0xef,0x17,0xbf,0x25]
# CHECK-ERROR-NOT: whilelt p15.s, xzr, xzr 
0xa7,0x15,0xa8,0x25
# CHECK: whilelt p7.s, x13, x8 // encoding: [0xa7,0x15,0xa8,0x25]
# CHECK-ERROR-NOT: whilelt p7.s, x13, x8 
0x45,0x15,0xb5,0x25
# CHECK: whilelt p5.s, x10, x21 // encoding: [0x45,0x15,0xb5,0x25]
# CHECK-ERROR-NOT: whilelt p5.s, x10, x21 
0x00,0x14,0xa0,0x25
# CHECK: whilelt p0.s, x0, x0 // encoding: [0x00,0x14,0xa0,0x25]
# CHECK-ERROR-NOT: whilelt p0.s, x0, x0 
