# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0xe7,0x05
# CHECK: rbit    z31.d, p7/m, z31.d // encoding: [0xff,0x9f,0xe7,0x05]
# CHECK-ERROR-NOT: rbit    z31.d, p7/m, z31.d 
0xb7,0x8d,0xe7,0x05
# CHECK: rbit    z23.d, p3/m, z13.d // encoding: [0xb7,0x8d,0xe7,0x05]
# CHECK-ERROR-NOT: rbit    z23.d, p3/m, z13.d 
0x00,0x80,0xe7,0x05
# CHECK: rbit    z0.d, p0/m, z0.d // encoding: [0x00,0x80,0xe7,0x05]
# CHECK-ERROR-NOT: rbit    z0.d, p0/m, z0.d 
0x55,0x95,0xe7,0x05
# CHECK: rbit    z21.d, p5/m, z10.d // encoding: [0x55,0x95,0xe7,0x05]
# CHECK-ERROR-NOT: rbit    z21.d, p5/m, z10.d 
