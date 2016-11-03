# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x39,0x38,0x05
# CHECK: rev     z21.b, z10.b // encoding: [0x55,0x39,0x38,0x05]
# CHECK-ERROR-NOT: rev     z21.b, z10.b 
0x00,0x38,0x38,0x05
# CHECK: rev     z0.b, z0.b // encoding: [0x00,0x38,0x38,0x05]
# CHECK-ERROR-NOT: rev     z0.b, z0.b 
0xb7,0x39,0x38,0x05
# CHECK: rev     z23.b, z13.b // encoding: [0xb7,0x39,0x38,0x05]
# CHECK-ERROR-NOT: rev     z23.b, z13.b 
0xff,0x3b,0x38,0x05
# CHECK: rev     z31.b, z31.b // encoding: [0xff,0x3b,0x38,0x05]
# CHECK-ERROR-NOT: rev     z31.b, z31.b 
