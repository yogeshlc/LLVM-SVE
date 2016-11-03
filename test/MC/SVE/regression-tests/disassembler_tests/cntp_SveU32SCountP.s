# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xa0,0x25
# CHECK: cntp    x23, p11, p13.s // encoding: [0xb7,0xad,0xa0,0x25]
# CHECK-ERROR-NOT: cntp    x23, p11, p13.s 
0x00,0x80,0xa0,0x25
# CHECK: cntp    x0, p0, p0.s // encoding: [0x00,0x80,0xa0,0x25]
# CHECK-ERROR-NOT: cntp    x0, p0, p0.s 
0xff,0xbd,0xa0,0x25
# CHECK: cntp    xzr, p15, p15.s // encoding: [0xff,0xbd,0xa0,0x25]
# CHECK-ERROR-NOT: cntp    xzr, p15, p15.s 
0x55,0x95,0xa0,0x25
# CHECK: cntp    x21, p5, p10.s // encoding: [0x55,0x95,0xa0,0x25]
# CHECK-ERROR-NOT: cntp    x21, p5, p10.s 
