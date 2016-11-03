# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x45,0x05,0x75,0x25
# CHECK: whilelt p5.h, w10, w21 // encoding: [0x45,0x05,0x75,0x25]
# CHECK-ERROR-NOT: whilelt p5.h, w10, w21 
0xa7,0x05,0x68,0x25
# CHECK: whilelt p7.h, w13, w8 // encoding: [0xa7,0x05,0x68,0x25]
# CHECK-ERROR-NOT: whilelt p7.h, w13, w8 
0x00,0x04,0x60,0x25
# CHECK: whilelt p0.h, w0, w0 // encoding: [0x00,0x04,0x60,0x25]
# CHECK-ERROR-NOT: whilelt p0.h, w0, w0 
0xef,0x07,0x7f,0x25
# CHECK: whilelt p15.h, wzr, wzr // encoding: [0xef,0x07,0x7f,0x25]
# CHECK-ERROR-NOT: whilelt p15.h, wzr, wzr 
