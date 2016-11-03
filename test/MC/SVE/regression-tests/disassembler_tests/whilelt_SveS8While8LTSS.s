# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x14,0x20,0x25
# CHECK: whilelt p0.b, x0, x0 // encoding: [0x00,0x14,0x20,0x25]
# CHECK-ERROR-NOT: whilelt p0.b, x0, x0 
0x45,0x15,0x35,0x25
# CHECK: whilelt p5.b, x10, x21 // encoding: [0x45,0x15,0x35,0x25]
# CHECK-ERROR-NOT: whilelt p5.b, x10, x21 
0xef,0x17,0x3f,0x25
# CHECK: whilelt p15.b, xzr, xzr // encoding: [0xef,0x17,0x3f,0x25]
# CHECK-ERROR-NOT: whilelt p15.b, xzr, xzr 
0xa7,0x15,0x28,0x25
# CHECK: whilelt p7.b, x13, x8 // encoding: [0xa7,0x15,0x28,0x25]
# CHECK-ERROR-NOT: whilelt p7.b, x13, x8 
