# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x04,0x60,0x04
# CHECK: sub     z0.h, z0.h, z0.h // encoding: [0x00,0x04,0x60,0x04]
# CHECK-ERROR-NOT: sub     z0.h, z0.h, z0.h 
0xff,0x07,0x7f,0x04
# CHECK: sub     z31.h, z31.h, z31.h // encoding: [0xff,0x07,0x7f,0x04]
# CHECK-ERROR-NOT: sub     z31.h, z31.h, z31.h 
0x55,0x05,0x75,0x04
# CHECK: sub     z21.h, z10.h, z21.h // encoding: [0x55,0x05,0x75,0x04]
# CHECK-ERROR-NOT: sub     z21.h, z10.h, z21.h 
0xb7,0x05,0x68,0x04
# CHECK: sub     z23.h, z13.h, z8.h // encoding: [0xb7,0x05,0x68,0x04]
# CHECK-ERROR-NOT: sub     z23.h, z13.h, z8.h 
