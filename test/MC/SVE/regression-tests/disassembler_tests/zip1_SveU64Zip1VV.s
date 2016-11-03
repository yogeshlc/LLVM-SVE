# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x61,0xf5,0x05
# CHECK: zip1    z21.d, z10.d, z21.d // encoding: [0x55,0x61,0xf5,0x05]
# CHECK-ERROR-NOT: zip1    z21.d, z10.d, z21.d 
0x00,0x60,0xe0,0x05
# CHECK: zip1    z0.d, z0.d, z0.d // encoding: [0x00,0x60,0xe0,0x05]
# CHECK-ERROR-NOT: zip1    z0.d, z0.d, z0.d 
0xff,0x63,0xff,0x05
# CHECK: zip1    z31.d, z31.d, z31.d // encoding: [0xff,0x63,0xff,0x05]
# CHECK-ERROR-NOT: zip1    z31.d, z31.d, z31.d 
0xb7,0x61,0xe8,0x05
# CHECK: zip1    z23.d, z13.d, z8.d // encoding: [0xb7,0x61,0xe8,0x05]
# CHECK-ERROR-NOT: zip1    z23.d, z13.d, z8.d 
