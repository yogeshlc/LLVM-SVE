# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x00,0xc0,0x65
# CHECK: fadd    z0.d, z0.d, z0.d // encoding: [0x00,0x00,0xc0,0x65]
# CHECK-ERROR-NOT: fadd    z0.d, z0.d, z0.d 
0xff,0x03,0xdf,0x65
# CHECK: fadd    z31.d, z31.d, z31.d // encoding: [0xff,0x03,0xdf,0x65]
# CHECK-ERROR-NOT: fadd    z31.d, z31.d, z31.d 
0xb7,0x01,0xc8,0x65
# CHECK: fadd    z23.d, z13.d, z8.d // encoding: [0xb7,0x01,0xc8,0x65]
# CHECK-ERROR-NOT: fadd    z23.d, z13.d, z8.d 
0x55,0x01,0xd5,0x65
# CHECK: fadd    z21.d, z10.d, z21.d // encoding: [0x55,0x01,0xd5,0x65]
# CHECK-ERROR-NOT: fadd    z21.d, z10.d, z21.d 
