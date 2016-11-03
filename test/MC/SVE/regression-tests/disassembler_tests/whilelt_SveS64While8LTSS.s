# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x15,0xf5,0x25
# CHECK: whilelt p5.d, x10, x21 // encoding: [0x45,0x15,0xf5,0x25]
# CHECK-ERROR-NOT: whilelt p5.d, x10, x21 
0xef,0x17,0xff,0x25
# CHECK: whilelt p15.d, xzr, xzr // encoding: [0xef,0x17,0xff,0x25]
# CHECK-ERROR-NOT: whilelt p15.d, xzr, xzr 
0x00,0x14,0xe0,0x25
# CHECK: whilelt p0.d, x0, x0 // encoding: [0x00,0x14,0xe0,0x25]
# CHECK-ERROR-NOT: whilelt p0.d, x0, x0 
0xa7,0x15,0xe8,0x25
# CHECK: whilelt p7.d, x13, x8 // encoding: [0xa7,0x15,0xe8,0x25]
# CHECK-ERROR-NOT: whilelt p7.d, x13, x8 
