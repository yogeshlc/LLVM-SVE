# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x0f,0xbf,0x25
# CHECK: whilels p15.s, wzr, wzr // encoding: [0xff,0x0f,0xbf,0x25]
# CHECK-ERROR-NOT: whilels p15.s, wzr, wzr 
0xb7,0x0d,0xa8,0x25
# CHECK: whilels p7.s, w13, w8 // encoding: [0xb7,0x0d,0xa8,0x25]
# CHECK-ERROR-NOT: whilels p7.s, w13, w8 
0x55,0x0d,0xb5,0x25
# CHECK: whilels p5.s, w10, w21 // encoding: [0x55,0x0d,0xb5,0x25]
# CHECK-ERROR-NOT: whilels p5.s, w10, w21 
0x10,0x0c,0xa0,0x25
# CHECK: whilels p0.s, w0, w0 // encoding: [0x10,0x0c,0xa0,0x25]
# CHECK-ERROR-NOT: whilels p0.s, w0, w0 
