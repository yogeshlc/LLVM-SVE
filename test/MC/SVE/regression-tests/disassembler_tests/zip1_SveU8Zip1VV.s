# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x63,0x3f,0x05
# CHECK: zip1    z31.b, z31.b, z31.b // encoding: [0xff,0x63,0x3f,0x05]
# CHECK-ERROR-NOT: zip1    z31.b, z31.b, z31.b 
0x55,0x61,0x35,0x05
# CHECK: zip1    z21.b, z10.b, z21.b // encoding: [0x55,0x61,0x35,0x05]
# CHECK-ERROR-NOT: zip1    z21.b, z10.b, z21.b 
0xb7,0x61,0x28,0x05
# CHECK: zip1    z23.b, z13.b, z8.b // encoding: [0xb7,0x61,0x28,0x05]
# CHECK-ERROR-NOT: zip1    z23.b, z13.b, z8.b 
0x00,0x60,0x20,0x05
# CHECK: zip1    z0.b, z0.b, z0.b // encoding: [0x00,0x60,0x20,0x05]
# CHECK-ERROR-NOT: zip1    z0.b, z0.b, z0.b 
