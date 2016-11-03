# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x38,0xb3,0x05
# CHECK: uunpkhi z0.s, z0.h // encoding: [0x00,0x38,0xb3,0x05]
# CHECK-ERROR-NOT: uunpkhi z0.s, z0.h 
0xb7,0x39,0xb3,0x05
# CHECK: uunpkhi z23.s, z13.h // encoding: [0xb7,0x39,0xb3,0x05]
# CHECK-ERROR-NOT: uunpkhi z23.s, z13.h 
0x55,0x39,0xb3,0x05
# CHECK: uunpkhi z21.s, z10.h // encoding: [0x55,0x39,0xb3,0x05]
# CHECK-ERROR-NOT: uunpkhi z21.s, z10.h 
0xff,0x3b,0xb3,0x05
# CHECK: uunpkhi z31.s, z31.h // encoding: [0xff,0x3b,0xb3,0x05]
# CHECK-ERROR-NOT: uunpkhi z31.s, z31.h 
