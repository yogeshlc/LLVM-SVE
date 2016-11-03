# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0xa8,0x05
# CHECK: clasta  z23.s, p3, z23.s, z13.s // encoding: [0xb7,0x8d,0xa8,0x05]
# CHECK-ERROR-NOT: clasta  z23.s, p3, z23.s, z13.s 
0x55,0x95,0xa8,0x05
# CHECK: clasta  z21.s, p5, z21.s, z10.s // encoding: [0x55,0x95,0xa8,0x05]
# CHECK-ERROR-NOT: clasta  z21.s, p5, z21.s, z10.s 
0xff,0x9f,0xa8,0x05
# CHECK: clasta  z31.s, p7, z31.s, z31.s // encoding: [0xff,0x9f,0xa8,0x05]
# CHECK-ERROR-NOT: clasta  z31.s, p7, z31.s, z31.s 
0x00,0x80,0xa8,0x05
# CHECK: clasta  z0.s, p0, z0.s, z0.s // encoding: [0x00,0x80,0xa8,0x05]
# CHECK-ERROR-NOT: clasta  z0.s, p0, z0.s, z0.s 
