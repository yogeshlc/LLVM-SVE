# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0x0e,0x10,0x05
# CHECK: mov     z5.b, p0/z, #113 // encoding: [0x25,0x0e,0x10,0x05]
# CHECK-ERROR-NOT: mov     z5.b, p0/z, #113 
0x21,0x04,0x1e,0x05
# CHECK: mov     z1.b, p14/z, #33 // encoding: [0x21,0x04,0x1e,0x05]
# CHECK-ERROR-NOT: mov     z1.b, p14/z, #33 
0x55,0x15,0x15,0x05
# CHECK: mov     z21.b, p5/z, #-86 // encoding: [0x55,0x15,0x15,0x05]
# CHECK-ERROR-NOT: mov     z21.b, p5/z, #-86 
0x00,0x00,0x10,0x05
# CHECK: mov     z0.b, p0/z, #0 // encoding: [0x00,0x00,0x10,0x05]
# CHECK-ERROR-NOT: mov     z0.b, p0/z, #0 
