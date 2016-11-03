# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x05,0xa8,0x25
# CHECK: whilelt p7.s, w13, w8 // encoding: [0xa7,0x05,0xa8,0x25]
# CHECK-ERROR-NOT: whilelt p7.s, w13, w8 
0xef,0x07,0xbf,0x25
# CHECK: whilelt p15.s, wzr, wzr // encoding: [0xef,0x07,0xbf,0x25]
# CHECK-ERROR-NOT: whilelt p15.s, wzr, wzr 
0x00,0x04,0xa0,0x25
# CHECK: whilelt p0.s, w0, w0 // encoding: [0x00,0x04,0xa0,0x25]
# CHECK-ERROR-NOT: whilelt p0.s, w0, w0 
0x45,0x05,0xb5,0x25
# CHECK: whilelt p5.s, w10, w21 // encoding: [0x45,0x05,0xb5,0x25]
# CHECK-ERROR-NOT: whilelt p5.s, w10, w21 
