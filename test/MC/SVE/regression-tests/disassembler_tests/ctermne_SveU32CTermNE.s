# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0x20,0xa0,0x25
# CHECK: ctermne w0, w0 // encoding: [0x10,0x20,0xa0,0x25]
# CHECK-ERROR-NOT: ctermne w0, w0 
0xf0,0x23,0xbf,0x25
# CHECK: ctermne wzr, wzr // encoding: [0xf0,0x23,0xbf,0x25]
# CHECK-ERROR-NOT: ctermne wzr, wzr 
0x50,0x21,0xb5,0x25
# CHECK: ctermne w10, w21 // encoding: [0x50,0x21,0xb5,0x25]
# CHECK-ERROR-NOT: ctermne w10, w21 
0xb0,0x21,0xa8,0x25
# CHECK: ctermne w13, w8 // encoding: [0xb0,0x21,0xa8,0x25]
# CHECK-ERROR-NOT: ctermne w13, w8 
