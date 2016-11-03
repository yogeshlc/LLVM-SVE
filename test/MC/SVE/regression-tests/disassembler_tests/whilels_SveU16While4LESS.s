# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x0f,0x7f,0x25
# CHECK: whilels p15.h, wzr, wzr // encoding: [0xff,0x0f,0x7f,0x25]
# CHECK-ERROR-NOT: whilels p15.h, wzr, wzr 
0x10,0x0c,0x60,0x25
# CHECK: whilels p0.h, w0, w0 // encoding: [0x10,0x0c,0x60,0x25]
# CHECK-ERROR-NOT: whilels p0.h, w0, w0 
0xb7,0x0d,0x68,0x25
# CHECK: whilels p7.h, w13, w8 // encoding: [0xb7,0x0d,0x68,0x25]
# CHECK-ERROR-NOT: whilels p7.h, w13, w8 
0x55,0x0d,0x75,0x25
# CHECK: whilels p5.h, w10, w21 // encoding: [0x55,0x0d,0x75,0x25]
# CHECK-ERROR-NOT: whilels p5.h, w10, w21 
