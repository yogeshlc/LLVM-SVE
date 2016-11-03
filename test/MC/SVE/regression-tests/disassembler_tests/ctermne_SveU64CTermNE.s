# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xf0,0x23,0xff,0x25
# CHECK: ctermne xzr, xzr // encoding: [0xf0,0x23,0xff,0x25]
# CHECK-ERROR-NOT: ctermne xzr, xzr 
0xb0,0x21,0xe8,0x25
# CHECK: ctermne x13, x8 // encoding: [0xb0,0x21,0xe8,0x25]
# CHECK-ERROR-NOT: ctermne x13, x8 
0x50,0x21,0xf5,0x25
# CHECK: ctermne x10, x21 // encoding: [0x50,0x21,0xf5,0x25]
# CHECK-ERROR-NOT: ctermne x10, x21 
0x10,0x20,0xe0,0x25
# CHECK: ctermne x0, x0 // encoding: [0x10,0x20,0xe0,0x25]
# CHECK-ERROR-NOT: ctermne x0, x0 
