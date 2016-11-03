# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xe0,0x23,0xff,0x25
# CHECK: ctermeq xzr, xzr // encoding: [0xe0,0x23,0xff,0x25]
# CHECK-ERROR-NOT: ctermeq xzr, xzr 
0xa0,0x21,0xe8,0x25
# CHECK: ctermeq x13, x8 // encoding: [0xa0,0x21,0xe8,0x25]
# CHECK-ERROR-NOT: ctermeq x13, x8 
0x00,0x20,0xe0,0x25
# CHECK: ctermeq x0, x0 // encoding: [0x00,0x20,0xe0,0x25]
# CHECK-ERROR-NOT: ctermeq x0, x0 
0x40,0x21,0xf5,0x25
# CHECK: ctermeq x10, x21 // encoding: [0x40,0x21,0xf5,0x25]
# CHECK-ERROR-NOT: ctermeq x10, x21 
