# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x0c,0xc0,0x65
# CHECK: ftsmul  z0.d, z0.d, z0.d // encoding: [0x00,0x0c,0xc0,0x65]
# CHECK-ERROR-NOT: ftsmul  z0.d, z0.d, z0.d 
0xb7,0x0d,0xc8,0x65
# CHECK: ftsmul  z23.d, z13.d, z8.d // encoding: [0xb7,0x0d,0xc8,0x65]
# CHECK-ERROR-NOT: ftsmul  z23.d, z13.d, z8.d 
0x55,0x0d,0xd5,0x65
# CHECK: ftsmul  z21.d, z10.d, z21.d // encoding: [0x55,0x0d,0xd5,0x65]
# CHECK-ERROR-NOT: ftsmul  z21.d, z10.d, z21.d 
0xff,0x0f,0xdf,0x65
# CHECK: ftsmul  z31.d, z31.d, z31.d // encoding: [0xff,0x0f,0xdf,0x65]
# CHECK-ERROR-NOT: ftsmul  z31.d, z31.d, z31.d 
