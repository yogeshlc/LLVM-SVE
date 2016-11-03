# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x31,0xcf,0x65
# CHECK: frsqrte z21.d, z10.d // encoding: [0x55,0x31,0xcf,0x65]
# CHECK-ERROR-NOT: frsqrte z21.d, z10.d 
0xb7,0x31,0xcf,0x65
# CHECK: frsqrte z23.d, z13.d // encoding: [0xb7,0x31,0xcf,0x65]
# CHECK-ERROR-NOT: frsqrte z23.d, z13.d 
0x00,0x30,0xcf,0x65
# CHECK: frsqrte z0.d, z0.d // encoding: [0x00,0x30,0xcf,0x65]
# CHECK-ERROR-NOT: frsqrte z0.d, z0.d 
0xff,0x33,0xcf,0x65
# CHECK: frsqrte z31.d, z31.d // encoding: [0xff,0x33,0xcf,0x65]
# CHECK-ERROR-NOT: frsqrte z31.d, z31.d 
