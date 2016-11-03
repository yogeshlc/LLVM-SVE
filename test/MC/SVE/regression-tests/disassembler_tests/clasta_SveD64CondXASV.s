# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xea,0x05
# CHECK: clasta  d0, p0, d0, z0.d // encoding: [0x00,0x80,0xea,0x05]
# CHECK-ERROR-NOT: clasta  d0, p0, d0, z0.d 
0xb7,0x8d,0xea,0x05
# CHECK: clasta  d23, p3, d23, z13.d // encoding: [0xb7,0x8d,0xea,0x05]
# CHECK-ERROR-NOT: clasta  d23, p3, d23, z13.d 
0x55,0x95,0xea,0x05
# CHECK: clasta  d21, p5, d21, z10.d // encoding: [0x55,0x95,0xea,0x05]
# CHECK-ERROR-NOT: clasta  d21, p5, d21, z10.d 
0xff,0x9f,0xea,0x05
# CHECK: clasta  d31, p7, d31, z31.d // encoding: [0xff,0x9f,0xea,0x05]
# CHECK-ERROR-NOT: clasta  d31, p7, d31, z31.d 
