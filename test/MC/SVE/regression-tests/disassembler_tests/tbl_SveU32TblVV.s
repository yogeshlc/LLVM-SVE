# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x31,0xa8,0x05
# CHECK: tbl     z23.s, {z13.s}, z8.s // encoding: [0xb7,0x31,0xa8,0x05]
# CHECK-ERROR-NOT: tbl     z23.s, {z13.s}, z8.s 
0x55,0x31,0xb5,0x05
# CHECK: tbl     z21.s, {z10.s}, z21.s // encoding: [0x55,0x31,0xb5,0x05]
# CHECK-ERROR-NOT: tbl     z21.s, {z10.s}, z21.s 
0x00,0x30,0xa0,0x05
# CHECK: tbl     z0.s, {z0.s}, z0.s // encoding: [0x00,0x30,0xa0,0x05]
# CHECK-ERROR-NOT: tbl     z0.s, {z0.s}, z0.s 
0xff,0x33,0xbf,0x05
# CHECK: tbl     z31.s, {z31.s}, z31.s // encoding: [0xff,0x33,0xbf,0x05]
# CHECK-ERROR-NOT: tbl     z31.s, {z31.s}, z31.s 
