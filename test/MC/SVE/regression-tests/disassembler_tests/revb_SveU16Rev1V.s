# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x64,0x05
# CHECK: revb    z23.h, p3/m, z13.h // encoding: [0xb7,0x8d,0x64,0x05]
# CHECK-ERROR-NOT: revb    z23.h, p3/m, z13.h 
0xff,0x9f,0x64,0x05
# CHECK: revb    z31.h, p7/m, z31.h // encoding: [0xff,0x9f,0x64,0x05]
# CHECK-ERROR-NOT: revb    z31.h, p7/m, z31.h 
0x00,0x80,0x64,0x05
# CHECK: revb    z0.h, p0/m, z0.h // encoding: [0x00,0x80,0x64,0x05]
# CHECK-ERROR-NOT: revb    z0.h, p0/m, z0.h 
0x55,0x95,0x64,0x05
# CHECK: revb    z21.h, p5/m, z10.h // encoding: [0x55,0x95,0x64,0x05]
# CHECK-ERROR-NOT: revb    z21.h, p5/m, z10.h 
