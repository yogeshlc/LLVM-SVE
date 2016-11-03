# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x38,0x71,0x05
# CHECK: sunpkhi z0.h, z0.b // encoding: [0x00,0x38,0x71,0x05]
# CHECK-ERROR-NOT: sunpkhi z0.h, z0.b 
0xff,0x3b,0x71,0x05
# CHECK: sunpkhi z31.h, z31.b // encoding: [0xff,0x3b,0x71,0x05]
# CHECK-ERROR-NOT: sunpkhi z31.h, z31.b 
0x55,0x39,0x71,0x05
# CHECK: sunpkhi z21.h, z10.b // encoding: [0x55,0x39,0x71,0x05]
# CHECK-ERROR-NOT: sunpkhi z21.h, z10.b 
0xb7,0x39,0x71,0x05
# CHECK: sunpkhi z23.h, z13.b // encoding: [0xb7,0x39,0x71,0x05]
# CHECK-ERROR-NOT: sunpkhi z23.h, z13.b 
