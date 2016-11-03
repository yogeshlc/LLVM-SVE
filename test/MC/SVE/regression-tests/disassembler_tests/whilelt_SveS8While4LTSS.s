# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x05,0x28,0x25
# CHECK: whilelt p7.b, w13, w8 // encoding: [0xa7,0x05,0x28,0x25]
# CHECK-ERROR-NOT: whilelt p7.b, w13, w8 
0x45,0x05,0x35,0x25
# CHECK: whilelt p5.b, w10, w21 // encoding: [0x45,0x05,0x35,0x25]
# CHECK-ERROR-NOT: whilelt p5.b, w10, w21 
0xef,0x07,0x3f,0x25
# CHECK: whilelt p15.b, wzr, wzr // encoding: [0xef,0x07,0x3f,0x25]
# CHECK-ERROR-NOT: whilelt p15.b, wzr, wzr 
0x00,0x04,0x20,0x25
# CHECK: whilelt p0.b, w0, w0 // encoding: [0x00,0x04,0x20,0x25]
# CHECK-ERROR-NOT: whilelt p0.b, w0, w0 
