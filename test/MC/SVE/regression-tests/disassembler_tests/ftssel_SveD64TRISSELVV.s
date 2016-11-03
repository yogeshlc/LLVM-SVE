# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xb1,0xe8,0x04
# CHECK: ftssel  z23.d, z13.d, z8.d // encoding: [0xb7,0xb1,0xe8,0x04]
# CHECK-ERROR-NOT: ftssel  z23.d, z13.d, z8.d 
0x00,0xb0,0xe0,0x04
# CHECK: ftssel  z0.d, z0.d, z0.d // encoding: [0x00,0xb0,0xe0,0x04]
# CHECK-ERROR-NOT: ftssel  z0.d, z0.d, z0.d 
0xff,0xb3,0xff,0x04
# CHECK: ftssel  z31.d, z31.d, z31.d // encoding: [0xff,0xb3,0xff,0x04]
# CHECK-ERROR-NOT: ftssel  z31.d, z31.d, z31.d 
0x55,0xb1,0xf5,0x04
# CHECK: ftssel  z21.d, z10.d, z21.d // encoding: [0x55,0xb1,0xf5,0x04]
# CHECK-ERROR-NOT: ftssel  z21.d, z10.d, z21.d 
