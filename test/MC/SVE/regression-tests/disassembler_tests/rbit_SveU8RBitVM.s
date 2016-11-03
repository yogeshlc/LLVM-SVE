# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x27,0x05
# CHECK: rbit    z21.b, p5/m, z10.b // encoding: [0x55,0x95,0x27,0x05]
# CHECK-ERROR-NOT: rbit    z21.b, p5/m, z10.b 
0x00,0x80,0x27,0x05
# CHECK: rbit    z0.b, p0/m, z0.b // encoding: [0x00,0x80,0x27,0x05]
# CHECK-ERROR-NOT: rbit    z0.b, p0/m, z0.b 
0xff,0x9f,0x27,0x05
# CHECK: rbit    z31.b, p7/m, z31.b // encoding: [0xff,0x9f,0x27,0x05]
# CHECK-ERROR-NOT: rbit    z31.b, p7/m, z31.b 
0xb7,0x8d,0x27,0x05
# CHECK: rbit    z23.b, p3/m, z13.b // encoding: [0xb7,0x8d,0x27,0x05]
# CHECK-ERROR-NOT: rbit    z23.b, p3/m, z13.b 
