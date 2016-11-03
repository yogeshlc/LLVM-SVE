# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x60,0x05
# CHECK: mov     z23.h, p3/m, h13 // encoding: [0xb7,0x8d,0x60,0x05]
# CHECK-ERROR-NOT: mov     z23.h, p3/m, h13 
0xff,0x9f,0x60,0x05
# CHECK: mov     z31.h, p7/m, h31 // encoding: [0xff,0x9f,0x60,0x05]
# CHECK-ERROR-NOT: mov     z31.h, p7/m, h31 
0x55,0x95,0x60,0x05
# CHECK: mov     z21.h, p5/m, h10 // encoding: [0x55,0x95,0x60,0x05]
# CHECK-ERROR-NOT: mov     z21.h, p5/m, h10 
0x00,0x80,0x60,0x05
# CHECK: mov     z0.h, p0/m, h0 // encoding: [0x00,0x80,0x60,0x05]
# CHECK-ERROR-NOT: mov     z0.h, p0/m, h0 
