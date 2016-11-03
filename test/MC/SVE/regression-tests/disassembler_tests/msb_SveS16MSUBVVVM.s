# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xe0,0x40,0x04
# CHECK: msb     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xe0,0x40,0x04]
# CHECK-ERROR-NOT: msb     z0.h, p0/m, z0.h, z0.h 
0xb7,0xed,0x48,0x04
# CHECK: msb     z23.h, p3/m, z8.h, z13.h // encoding: [0xb7,0xed,0x48,0x04]
# CHECK-ERROR-NOT: msb     z23.h, p3/m, z8.h, z13.h 
0x55,0xf5,0x55,0x04
# CHECK: msb     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0xf5,0x55,0x04]
# CHECK-ERROR-NOT: msb     z21.h, p5/m, z21.h, z10.h 
0xff,0xff,0x5f,0x04
# CHECK: msb     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xff,0x5f,0x04]
# CHECK-ERROR-NOT: msb     z31.h, p7/m, z31.h, z31.h 
