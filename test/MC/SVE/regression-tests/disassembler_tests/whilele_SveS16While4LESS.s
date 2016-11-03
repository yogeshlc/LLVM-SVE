# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x05,0x68,0x25
# CHECK: whilele p7.h, w13, w8 // encoding: [0xb7,0x05,0x68,0x25]
# CHECK-ERROR-NOT: whilele p7.h, w13, w8 
0x55,0x05,0x75,0x25
# CHECK: whilele p5.h, w10, w21 // encoding: [0x55,0x05,0x75,0x25]
# CHECK-ERROR-NOT: whilele p5.h, w10, w21 
0xff,0x07,0x7f,0x25
# CHECK: whilele p15.h, wzr, wzr // encoding: [0xff,0x07,0x7f,0x25]
# CHECK-ERROR-NOT: whilele p15.h, wzr, wzr 
0x10,0x04,0x60,0x25
# CHECK: whilele p0.h, w0, w0 // encoding: [0x10,0x04,0x60,0x25]
# CHECK-ERROR-NOT: whilele p0.h, w0, w0 
