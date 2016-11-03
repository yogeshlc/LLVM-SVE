# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x31,0x68,0x04
# CHECK: orr     z23.d, z13.d, z8.d // encoding: [0xb7,0x31,0x68,0x04]
# CHECK-ERROR-NOT: orr     z23.d, z13.d, z8.d 
0x55,0x31,0x75,0x04
# CHECK: orr     z21.d, z10.d, z21.d // encoding: [0x55,0x31,0x75,0x04]
# CHECK-ERROR-NOT: orr     z21.d, z10.d, z21.d 
0xff,0x33,0x7f,0x04
# CHECK: mov     z31.d, z31.d // encoding: [0xff,0x33,0x7f,0x04]
# CHECK-ERROR-NOT: mov     z31.d, z31.d 
0x00,0x30,0x60,0x04
# CHECK: mov     z0.d, z0.d // encoding: [0x00,0x30,0x60,0x04]
# CHECK-ERROR-NOT: mov     z0.d, z0.d 
