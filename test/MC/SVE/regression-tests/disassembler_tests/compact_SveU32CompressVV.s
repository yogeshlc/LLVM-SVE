# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0xa1,0x05
# CHECK: compact z31.s, p7, z31.s // encoding: [0xff,0x9f,0xa1,0x05]
# CHECK-ERROR-NOT: compact z31.s, p7, z31.s 
0x00,0x80,0xa1,0x05
# CHECK: compact z0.s, p0, z0.s // encoding: [0x00,0x80,0xa1,0x05]
# CHECK-ERROR-NOT: compact z0.s, p0, z0.s 
0xb7,0x8d,0xa1,0x05
# CHECK: compact z23.s, p3, z13.s // encoding: [0xb7,0x8d,0xa1,0x05]
# CHECK-ERROR-NOT: compact z23.s, p3, z13.s 
0x55,0x95,0xa1,0x05
# CHECK: compact z21.s, p5, z10.s // encoding: [0x55,0x95,0xa1,0x05]
# CHECK-ERROR-NOT: compact z21.s, p5, z10.s 
