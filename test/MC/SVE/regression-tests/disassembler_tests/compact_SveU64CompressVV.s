# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x80,0xe1,0x05
# CHECK: compact z0.d, p0, z0.d // encoding: [0x00,0x80,0xe1,0x05]
# CHECK-ERROR-NOT: compact z0.d, p0, z0.d 
0xb7,0x8d,0xe1,0x05
# CHECK: compact z23.d, p3, z13.d // encoding: [0xb7,0x8d,0xe1,0x05]
# CHECK-ERROR-NOT: compact z23.d, p3, z13.d 
0x55,0x95,0xe1,0x05
# CHECK: compact z21.d, p5, z10.d // encoding: [0x55,0x95,0xe1,0x05]
# CHECK-ERROR-NOT: compact z21.d, p5, z10.d 
0xff,0x9f,0xe1,0x05
# CHECK: compact z31.d, p7, z31.d // encoding: [0xff,0x9f,0xe1,0x05]
# CHECK-ERROR-NOT: compact z31.d, p7, z31.d 
