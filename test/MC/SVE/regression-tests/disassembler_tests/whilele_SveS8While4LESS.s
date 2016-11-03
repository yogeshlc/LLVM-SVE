# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x07,0x3f,0x25
# CHECK: whilele p15.b, wzr, wzr // encoding: [0xff,0x07,0x3f,0x25]
# CHECK-ERROR-NOT: whilele p15.b, wzr, wzr 
0xb7,0x05,0x28,0x25
# CHECK: whilele p7.b, w13, w8 // encoding: [0xb7,0x05,0x28,0x25]
# CHECK-ERROR-NOT: whilele p7.b, w13, w8 
0x10,0x04,0x20,0x25
# CHECK: whilele p0.b, w0, w0 // encoding: [0x10,0x04,0x20,0x25]
# CHECK-ERROR-NOT: whilele p0.b, w0, w0 
0x55,0x05,0x35,0x25
# CHECK: whilele p5.b, w10, w21 // encoding: [0x55,0x05,0x35,0x25]
# CHECK-ERROR-NOT: whilele p5.b, w10, w21 
