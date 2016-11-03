# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0xe8,0x05
# CHECK: mov     z23.d, p3/m, x13 // encoding: [0xb7,0xad,0xe8,0x05]
# CHECK-ERROR-NOT: mov     z23.d, p3/m, x13 
0xff,0xbf,0xe8,0x05
# CHECK: mov     z31.d, p7/m, sp // encoding: [0xff,0xbf,0xe8,0x05]
# CHECK-ERROR-NOT: mov     z31.d, p7/m, sp 
0x55,0xb5,0xe8,0x05
# CHECK: mov     z21.d, p5/m, x10 // encoding: [0x55,0xb5,0xe8,0x05]
# CHECK-ERROR-NOT: mov     z21.d, p5/m, x10 
0x00,0xa0,0xe8,0x05
# CHECK: mov     z0.d, p0/m, x0 // encoding: [0x00,0xa0,0xe8,0x05]
# CHECK-ERROR-NOT: mov     z0.d, p0/m, x0 
