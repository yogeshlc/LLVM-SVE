# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x30,0xe0,0x04
# CHECK: bic     z0.d, z0.d, z0.d // encoding: [0x00,0x30,0xe0,0x04]
# CHECK-ERROR-NOT: bic     z0.d, z0.d, z0.d 
0x55,0x31,0xf5,0x04
# CHECK: bic     z21.d, z10.d, z21.d // encoding: [0x55,0x31,0xf5,0x04]
# CHECK-ERROR-NOT: bic     z21.d, z10.d, z21.d 
0xff,0x33,0xff,0x04
# CHECK: bic     z31.d, z31.d, z31.d // encoding: [0xff,0x33,0xff,0x04]
# CHECK-ERROR-NOT: bic     z31.d, z31.d, z31.d 
0xb7,0x31,0xe8,0x04
# CHECK: bic     z23.d, z13.d, z8.d // encoding: [0xb7,0x31,0xe8,0x04]
# CHECK-ERROR-NOT: bic     z23.d, z13.d, z8.d 
