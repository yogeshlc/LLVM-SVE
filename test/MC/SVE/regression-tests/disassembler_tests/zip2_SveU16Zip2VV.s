# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x64,0x60,0x05
# CHECK: zip2    z0.h, z0.h, z0.h // encoding: [0x00,0x64,0x60,0x05]
# CHECK-ERROR-NOT: zip2    z0.h, z0.h, z0.h 
0x55,0x65,0x75,0x05
# CHECK: zip2    z21.h, z10.h, z21.h // encoding: [0x55,0x65,0x75,0x05]
# CHECK-ERROR-NOT: zip2    z21.h, z10.h, z21.h 
0xff,0x67,0x7f,0x05
# CHECK: zip2    z31.h, z31.h, z31.h // encoding: [0xff,0x67,0x7f,0x05]
# CHECK-ERROR-NOT: zip2    z31.h, z31.h, z31.h 
0xb7,0x65,0x68,0x05
# CHECK: zip2    z23.h, z13.h, z8.h // encoding: [0xb7,0x65,0x68,0x05]
# CHECK-ERROR-NOT: zip2    z23.h, z13.h, z8.h 
