# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x05,0xb5,0x25
# CHECK: whilele p5.s, w10, w21 // encoding: [0x55,0x05,0xb5,0x25]
# CHECK-ERROR-NOT: whilele p5.s, w10, w21 
0xb7,0x05,0xa8,0x25
# CHECK: whilele p7.s, w13, w8 // encoding: [0xb7,0x05,0xa8,0x25]
# CHECK-ERROR-NOT: whilele p7.s, w13, w8 
0x10,0x04,0xa0,0x25
# CHECK: whilele p0.s, w0, w0 // encoding: [0x10,0x04,0xa0,0x25]
# CHECK-ERROR-NOT: whilele p0.s, w0, w0 
0xff,0x07,0xbf,0x25
# CHECK: whilele p15.s, wzr, wzr // encoding: [0xff,0x07,0xbf,0x25]
# CHECK-ERROR-NOT: whilele p15.s, wzr, wzr 
