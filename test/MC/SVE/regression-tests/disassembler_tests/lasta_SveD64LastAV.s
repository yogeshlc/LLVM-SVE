# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xe2,0x05
# CHECK: lasta   d0, p0, z0.d // encoding: [0x00,0x80,0xe2,0x05]
# CHECK-ERROR-NOT: lasta   d0, p0, z0.d 
0xb7,0x8d,0xe2,0x05
# CHECK: lasta   d23, p3, z13.d // encoding: [0xb7,0x8d,0xe2,0x05]
# CHECK-ERROR-NOT: lasta   d23, p3, z13.d 
0x55,0x95,0xe2,0x05
# CHECK: lasta   d21, p5, z10.d // encoding: [0x55,0x95,0xe2,0x05]
# CHECK-ERROR-NOT: lasta   d21, p5, z10.d 
0xff,0x9f,0xe2,0x05
# CHECK: lasta   d31, p7, z31.d // encoding: [0xff,0x9f,0xe2,0x05]
# CHECK-ERROR-NOT: lasta   d31, p7, z31.d 
