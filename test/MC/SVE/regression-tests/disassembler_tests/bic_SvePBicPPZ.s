# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x55,0x05,0x25
# CHECK: bic     p5.b, p5/z, p10.b, p5.b // encoding: [0x55,0x55,0x05,0x25]
# CHECK-ERROR-NOT: bic     p5.b, p5/z, p10.b, p5.b 
0xb7,0x6d,0x08,0x25
# CHECK: bic     p7.b, p11/z, p13.b, p8.b // encoding: [0xb7,0x6d,0x08,0x25]
# CHECK-ERROR-NOT: bic     p7.b, p11/z, p13.b, p8.b 
0xff,0x7d,0x0f,0x25
# CHECK: bic     p15.b, p15/z, p15.b, p15.b // encoding: [0xff,0x7d,0x0f,0x25]
# CHECK-ERROR-NOT: bic     p15.b, p15/z, p15.b, p15.b 
0x10,0x40,0x00,0x25
# CHECK: bic     p0.b, p0/z, p0.b, p0.b // encoding: [0x10,0x40,0x00,0x25]
# CHECK-ERROR-NOT: bic     p0.b, p0/z, p0.b, p0.b 
