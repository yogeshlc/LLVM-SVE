# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x39,0xf2,0x05
# CHECK: uunpklo z21.d, z10.s // encoding: [0x55,0x39,0xf2,0x05]
# CHECK-ERROR-NOT: uunpklo z21.d, z10.s 
0x00,0x38,0xf2,0x05
# CHECK: uunpklo z0.d, z0.s // encoding: [0x00,0x38,0xf2,0x05]
# CHECK-ERROR-NOT: uunpklo z0.d, z0.s 
0xff,0x3b,0xf2,0x05
# CHECK: uunpklo z31.d, z31.s // encoding: [0xff,0x3b,0xf2,0x05]
# CHECK-ERROR-NOT: uunpklo z31.d, z31.s 
0xb7,0x39,0xf2,0x05
# CHECK: uunpklo z23.d, z13.s // encoding: [0xb7,0x39,0xf2,0x05]
# CHECK-ERROR-NOT: uunpklo z23.d, z13.s 
