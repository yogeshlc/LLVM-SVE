# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x6d,0xc8,0x04
# CHECK: mls     z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x6d,0xc8,0x04]
# CHECK-ERROR-NOT: mls     z23.d, p3/m, z13.d, z8.d 
0x55,0x75,0xd5,0x04
# CHECK: mls     z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x75,0xd5,0x04]
# CHECK-ERROR-NOT: mls     z21.d, p5/m, z10.d, z21.d 
0x00,0x60,0xc0,0x04
# CHECK: mls     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x60,0xc0,0x04]
# CHECK-ERROR-NOT: mls     z0.d, p0/m, z0.d, z0.d 
0xff,0x7f,0xdf,0x04
# CHECK: mls     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x7f,0xdf,0x04]
# CHECK-ERROR-NOT: mls     z31.d, p7/m, z31.d, z31.d 
