# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x3b,0xf8,0x05
# CHECK: rev     z31.d, z31.d // encoding: [0xff,0x3b,0xf8,0x05]
# CHECK-ERROR-NOT: rev     z31.d, z31.d 
0x00,0x38,0xf8,0x05
# CHECK: rev     z0.d, z0.d // encoding: [0x00,0x38,0xf8,0x05]
# CHECK-ERROR-NOT: rev     z0.d, z0.d 
0xb7,0x39,0xf8,0x05
# CHECK: rev     z23.d, z13.d // encoding: [0xb7,0x39,0xf8,0x05]
# CHECK-ERROR-NOT: rev     z23.d, z13.d 
0x55,0x39,0xf8,0x05
# CHECK: rev     z21.d, z10.d // encoding: [0x55,0x39,0xf8,0x05]
# CHECK-ERROR-NOT: rev     z21.d, z10.d 
