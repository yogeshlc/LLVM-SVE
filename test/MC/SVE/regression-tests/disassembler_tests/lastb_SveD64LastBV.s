# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0xe3,0x05
# CHECK: lastb   d23, p3, z13.d // encoding: [0xb7,0x8d,0xe3,0x05]
# CHECK-ERROR-NOT: lastb   d23, p3, z13.d 
0x00,0x80,0xe3,0x05
# CHECK: lastb   d0, p0, z0.d // encoding: [0x00,0x80,0xe3,0x05]
# CHECK-ERROR-NOT: lastb   d0, p0, z0.d 
0xff,0x9f,0xe3,0x05
# CHECK: lastb   d31, p7, z31.d // encoding: [0xff,0x9f,0xe3,0x05]
# CHECK-ERROR-NOT: lastb   d31, p7, z31.d 
0x55,0x95,0xe3,0x05
# CHECK: lastb   d21, p5, z10.d // encoding: [0x55,0x95,0xe3,0x05]
# CHECK-ERROR-NOT: lastb   d21, p5, z10.d 
