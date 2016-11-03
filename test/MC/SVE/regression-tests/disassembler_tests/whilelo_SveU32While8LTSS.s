# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xef,0x1f,0xbf,0x25
# CHECK: whilelo p15.s, xzr, xzr // encoding: [0xef,0x1f,0xbf,0x25]
# CHECK-ERROR-NOT: whilelo p15.s, xzr, xzr 
0xa7,0x1d,0xa8,0x25
# CHECK: whilelo p7.s, x13, x8 // encoding: [0xa7,0x1d,0xa8,0x25]
# CHECK-ERROR-NOT: whilelo p7.s, x13, x8 
0x45,0x1d,0xb5,0x25
# CHECK: whilelo p5.s, x10, x21 // encoding: [0x45,0x1d,0xb5,0x25]
# CHECK-ERROR-NOT: whilelo p5.s, x10, x21 
0x00,0x1c,0xa0,0x25
# CHECK: whilelo p0.s, x0, x0 // encoding: [0x00,0x1c,0xa0,0x25]
# CHECK-ERROR-NOT: whilelo p0.s, x0, x0 
