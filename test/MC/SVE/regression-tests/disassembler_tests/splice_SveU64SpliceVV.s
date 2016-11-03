# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0xec,0x05
# CHECK: splice  z21.d, p5, z21.d, z10.d // encoding: [0x55,0x95,0xec,0x05]
# CHECK-ERROR-NOT: splice  z21.d, p5, z21.d, z10.d 
0xff,0x9f,0xec,0x05
# CHECK: splice  z31.d, p7, z31.d, z31.d // encoding: [0xff,0x9f,0xec,0x05]
# CHECK-ERROR-NOT: splice  z31.d, p7, z31.d, z31.d 
0x00,0x80,0xec,0x05
# CHECK: splice  z0.d, p0, z0.d, z0.d // encoding: [0x00,0x80,0xec,0x05]
# CHECK-ERROR-NOT: splice  z0.d, p0, z0.d, z0.d 
0xb7,0x8d,0xec,0x05
# CHECK: splice  z23.d, p3, z23.d, z13.d // encoding: [0xb7,0x8d,0xec,0x05]
# CHECK-ERROR-NOT: splice  z23.d, p3, z23.d, z13.d 
