# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x20,0xa0,0x25
# CHECK: ctermeq w0, w0 // encoding: [0x00,0x20,0xa0,0x25]
# CHECK-ERROR-NOT: ctermeq w0, w0 
0xa0,0x21,0xa8,0x25
# CHECK: ctermeq w13, w8 // encoding: [0xa0,0x21,0xa8,0x25]
# CHECK-ERROR-NOT: ctermeq w13, w8 
0x40,0x21,0xb5,0x25
# CHECK: ctermeq w10, w21 // encoding: [0x40,0x21,0xb5,0x25]
# CHECK-ERROR-NOT: ctermeq w10, w21 
0xe0,0x23,0xbf,0x25
# CHECK: ctermeq wzr, wzr // encoding: [0xe0,0x23,0xbf,0x25]
# CHECK-ERROR-NOT: ctermeq wzr, wzr 
