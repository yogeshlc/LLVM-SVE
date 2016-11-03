# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x39,0xb8,0x05
# CHECK: rev     z23.s, z13.s // encoding: [0xb7,0x39,0xb8,0x05]
# CHECK-ERROR-NOT: rev     z23.s, z13.s 
0x55,0x39,0xb8,0x05
# CHECK: rev     z21.s, z10.s // encoding: [0x55,0x39,0xb8,0x05]
# CHECK-ERROR-NOT: rev     z21.s, z10.s 
0x00,0x38,0xb8,0x05
# CHECK: rev     z0.s, z0.s // encoding: [0x00,0x38,0xb8,0x05]
# CHECK-ERROR-NOT: rev     z0.s, z0.s 
0xff,0x3b,0xb8,0x05
# CHECK: rev     z31.s, z31.s // encoding: [0xff,0x3b,0xb8,0x05]
# CHECK-ERROR-NOT: rev     z31.s, z31.s 
