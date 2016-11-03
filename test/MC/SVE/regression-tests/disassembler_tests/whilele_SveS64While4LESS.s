# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x07,0xff,0x25
# CHECK: whilele p15.d, wzr, wzr // encoding: [0xff,0x07,0xff,0x25]
# CHECK-ERROR-NOT: whilele p15.d, wzr, wzr 
0x55,0x05,0xf5,0x25
# CHECK: whilele p5.d, w10, w21 // encoding: [0x55,0x05,0xf5,0x25]
# CHECK-ERROR-NOT: whilele p5.d, w10, w21 
0x10,0x04,0xe0,0x25
# CHECK: whilele p0.d, w0, w0 // encoding: [0x10,0x04,0xe0,0x25]
# CHECK-ERROR-NOT: whilele p0.d, w0, w0 
0xb7,0x05,0xe8,0x25
# CHECK: whilele p7.d, w13, w8 // encoding: [0xb7,0x05,0xe8,0x25]
# CHECK-ERROR-NOT: whilele p7.d, w13, w8 
