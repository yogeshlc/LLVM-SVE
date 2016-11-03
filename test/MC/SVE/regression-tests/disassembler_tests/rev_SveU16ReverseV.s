# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x39,0x78,0x05
# CHECK: rev     z21.h, z10.h // encoding: [0x55,0x39,0x78,0x05]
# CHECK-ERROR-NOT: rev     z21.h, z10.h 
0x00,0x38,0x78,0x05
# CHECK: rev     z0.h, z0.h // encoding: [0x00,0x38,0x78,0x05]
# CHECK-ERROR-NOT: rev     z0.h, z0.h 
0xff,0x3b,0x78,0x05
# CHECK: rev     z31.h, z31.h // encoding: [0xff,0x3b,0x78,0x05]
# CHECK-ERROR-NOT: rev     z31.h, z31.h 
0xb7,0x39,0x78,0x05
# CHECK: rev     z23.h, z13.h // encoding: [0xb7,0x39,0x78,0x05]
# CHECK-ERROR-NOT: rev     z23.h, z13.h 
