# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0xd0,0x05
# CHECK: mov     z0.d, p0/z, #0 // encoding: [0x00,0x00,0xd0,0x05]
# CHECK-ERROR-NOT: mov     z0.d, p0/z, #0 
0xff,0x3f,0xdf,0x05
# CHECK: mov     z31.d, p15/z, #-256 // encoding: [0xff,0x3f,0xdf,0x05]
# CHECK-ERROR-NOT: mov     z31.d, p15/z, #-256 
0xb7,0x2d,0xd8,0x05
# CHECK: mov     z23.d, p8/z, #27904 // encoding: [0xb7,0x2d,0xd8,0x05]
# CHECK-ERROR-NOT: mov     z23.d, p8/z, #27904 
0x55,0x15,0xd5,0x05
# CHECK: mov     z21.d, p5/z, #-86 // encoding: [0x55,0x15,0xd5,0x05]
# CHECK-ERROR-NOT: mov     z21.d, p5/z, #-86 
