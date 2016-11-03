# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x0c,0xe0,0x25
# CHECK: whilelo p0.d, w0, w0 // encoding: [0x00,0x0c,0xe0,0x25]
# CHECK-ERROR-NOT: whilelo p0.d, w0, w0 
0x45,0x0d,0xf5,0x25
# CHECK: whilelo p5.d, w10, w21 // encoding: [0x45,0x0d,0xf5,0x25]
# CHECK-ERROR-NOT: whilelo p5.d, w10, w21 
0xef,0x0f,0xff,0x25
# CHECK: whilelo p15.d, wzr, wzr // encoding: [0xef,0x0f,0xff,0x25]
# CHECK-ERROR-NOT: whilelo p15.d, wzr, wzr 
0xa7,0x0d,0xe8,0x25
# CHECK: whilelo p7.d, w13, w8 // encoding: [0xa7,0x0d,0xe8,0x25]
# CHECK-ERROR-NOT: whilelo p7.d, w13, w8 
