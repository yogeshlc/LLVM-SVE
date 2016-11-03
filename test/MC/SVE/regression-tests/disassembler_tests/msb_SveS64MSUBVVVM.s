# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xed,0xc8,0x04
# CHECK: msb     z23.d, p3/m, z8.d, z13.d // encoding: [0xb7,0xed,0xc8,0x04]
# CHECK-ERROR-NOT: msb     z23.d, p3/m, z8.d, z13.d 
0xff,0xff,0xdf,0x04
# CHECK: msb     z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0xff,0xdf,0x04]
# CHECK-ERROR-NOT: msb     z31.d, p7/m, z31.d, z31.d 
0x00,0xe0,0xc0,0x04
# CHECK: msb     z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0xe0,0xc0,0x04]
# CHECK-ERROR-NOT: msb     z0.d, p0/m, z0.d, z0.d 
0x55,0xf5,0xd5,0x04
# CHECK: msb     z21.d, p5/m, z21.d, z10.d // encoding: [0x55,0xf5,0xd5,0x04]
# CHECK-ERROR-NOT: msb     z21.d, p5/m, z21.d, z10.d 
