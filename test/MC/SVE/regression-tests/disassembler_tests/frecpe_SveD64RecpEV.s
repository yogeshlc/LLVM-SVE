# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x33,0xce,0x65
# CHECK: frecpe  z31.d, z31.d // encoding: [0xff,0x33,0xce,0x65]
# CHECK-ERROR-NOT: frecpe  z31.d, z31.d 
0x55,0x31,0xce,0x65
# CHECK: frecpe  z21.d, z10.d // encoding: [0x55,0x31,0xce,0x65]
# CHECK-ERROR-NOT: frecpe  z21.d, z10.d 
0xb7,0x31,0xce,0x65
# CHECK: frecpe  z23.d, z13.d // encoding: [0xb7,0x31,0xce,0x65]
# CHECK-ERROR-NOT: frecpe  z23.d, z13.d 
0x00,0x30,0xce,0x65
# CHECK: frecpe  z0.d, z0.d // encoding: [0x00,0x30,0xce,0x65]
# CHECK-ERROR-NOT: frecpe  z0.d, z0.d 
