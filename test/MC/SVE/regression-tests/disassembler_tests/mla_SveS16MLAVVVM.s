# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x55,0x55,0x04
# CHECK: mla     z21.h, p5/m, z10.h, z21.h // encoding: [0x55,0x55,0x55,0x04]
# CHECK-ERROR-NOT: mla     z21.h, p5/m, z10.h, z21.h 
0xb7,0x4d,0x48,0x04
# CHECK: mla     z23.h, p3/m, z13.h, z8.h // encoding: [0xb7,0x4d,0x48,0x04]
# CHECK-ERROR-NOT: mla     z23.h, p3/m, z13.h, z8.h 
0x00,0x40,0x40,0x04
# CHECK: mla     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0x40,0x40,0x04]
# CHECK-ERROR-NOT: mla     z0.h, p0/m, z0.h, z0.h 
0xff,0x5f,0x5f,0x04
# CHECK: mla     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0x5f,0x5f,0x04]
# CHECK-ERROR-NOT: mla     z31.h, p7/m, z31.h, z31.h 
