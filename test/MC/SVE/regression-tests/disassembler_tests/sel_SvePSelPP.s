# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x7f,0x0f,0x25
# CHECK: mov     p15.b, p15/m, p15.b // encoding: [0xff,0x7f,0x0f,0x25]
# CHECK-ERROR-NOT: mov     p15.b, p15/m, p15.b 
0x10,0x42,0x00,0x25
# CHECK: mov     p0.b, p0/m, p0.b // encoding: [0x10,0x42,0x00,0x25]
# CHECK-ERROR-NOT: mov     p0.b, p0/m, p0.b 
0xb7,0x6f,0x08,0x25
# CHECK: sel     p7.b, p11, p13.b, p8.b // encoding: [0xb7,0x6f,0x08,0x25]
# CHECK-ERROR-NOT: sel     p7.b, p11, p13.b, p8.b 
0x55,0x57,0x05,0x25
# CHECK: mov     p5.b, p5/m, p10.b // encoding: [0x55,0x57,0x05,0x25]
# CHECK-ERROR-NOT: mov     p5.b, p5/m, p10.b 
