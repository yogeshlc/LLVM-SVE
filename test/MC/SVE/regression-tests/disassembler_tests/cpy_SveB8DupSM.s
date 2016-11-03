# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x20,0x05
# CHECK: mov     z31.b, p7/m, b31 // encoding: [0xff,0x9f,0x20,0x05]
# CHECK-ERROR-NOT: mov     z31.b, p7/m, b31 
0x55,0x95,0x20,0x05
# CHECK: mov     z21.b, p5/m, b10 // encoding: [0x55,0x95,0x20,0x05]
# CHECK-ERROR-NOT: mov     z21.b, p5/m, b10 
0x00,0x80,0x20,0x05
# CHECK: mov     z0.b, p0/m, b0 // encoding: [0x00,0x80,0x20,0x05]
# CHECK-ERROR-NOT: mov     z0.b, p0/m, b0 
0xb7,0x8d,0x20,0x05
# CHECK: mov     z23.b, p3/m, b13 // encoding: [0xb7,0x8d,0x20,0x05]
# CHECK-ERROR-NOT: mov     z23.b, p3/m, b13 
