# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x4d,0x08,0x04
# CHECK: mla     z23.b, p3/m, z13.b, z8.b // encoding: [0xb7,0x4d,0x08,0x04]
# CHECK-ERROR-NOT: mla     z23.b, p3/m, z13.b, z8.b 
0x00,0x40,0x00,0x04
# CHECK: mla     z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x40,0x00,0x04]
# CHECK-ERROR-NOT: mla     z0.b, p0/m, z0.b, z0.b 
0xff,0x5f,0x1f,0x04
# CHECK: mla     z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x5f,0x1f,0x04]
# CHECK-ERROR-NOT: mla     z31.b, p7/m, z31.b, z31.b 
0x55,0x55,0x15,0x04
# CHECK: mla     z21.b, p5/m, z10.b, z21.b // encoding: [0x55,0x55,0x15,0x04]
# CHECK-ERROR-NOT: mla     z21.b, p5/m, z10.b, z21.b 
