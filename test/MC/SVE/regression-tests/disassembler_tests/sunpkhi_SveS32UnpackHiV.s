# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x39,0xb1,0x05
# CHECK: sunpkhi z21.s, z10.h // encoding: [0x55,0x39,0xb1,0x05]
# CHECK-ERROR-NOT: sunpkhi z21.s, z10.h 
0xb7,0x39,0xb1,0x05
# CHECK: sunpkhi z23.s, z13.h // encoding: [0xb7,0x39,0xb1,0x05]
# CHECK-ERROR-NOT: sunpkhi z23.s, z13.h 
0xff,0x3b,0xb1,0x05
# CHECK: sunpkhi z31.s, z31.h // encoding: [0xff,0x3b,0xb1,0x05]
# CHECK-ERROR-NOT: sunpkhi z31.s, z31.h 
0x00,0x38,0xb1,0x05
# CHECK: sunpkhi z0.s, z0.h // encoding: [0x00,0x38,0xb1,0x05]
# CHECK-ERROR-NOT: sunpkhi z0.s, z0.h 
