# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0xe0,0x05
# CHECK: mov     z21.d, p5/m, d10 // encoding: [0x55,0x95,0xe0,0x05]
# CHECK-ERROR-NOT: mov     z21.d, p5/m, d10 
0xff,0x9f,0xe0,0x05
# CHECK: mov     z31.d, p7/m, d31 // encoding: [0xff,0x9f,0xe0,0x05]
# CHECK-ERROR-NOT: mov     z31.d, p7/m, d31 
0xb7,0x8d,0xe0,0x05
# CHECK: mov     z23.d, p3/m, d13 // encoding: [0xb7,0x8d,0xe0,0x05]
# CHECK-ERROR-NOT: mov     z23.d, p3/m, d13 
0x00,0x80,0xe0,0x05
# CHECK: mov     z0.d, p0/m, d0 // encoding: [0x00,0x80,0xe0,0x05]
# CHECK-ERROR-NOT: mov     z0.d, p0/m, d0 
