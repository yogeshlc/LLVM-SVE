# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x30,0x20,0x05
# CHECK: tbl     z0.b, {z0.b}, z0.b // encoding: [0x00,0x30,0x20,0x05]
# CHECK-ERROR-NOT: tbl     z0.b, {z0.b}, z0.b 
0xff,0x33,0x3f,0x05
# CHECK: tbl     z31.b, {z31.b}, z31.b // encoding: [0xff,0x33,0x3f,0x05]
# CHECK-ERROR-NOT: tbl     z31.b, {z31.b}, z31.b 
0x55,0x31,0x35,0x05
# CHECK: tbl     z21.b, {z10.b}, z21.b // encoding: [0x55,0x31,0x35,0x05]
# CHECK-ERROR-NOT: tbl     z21.b, {z10.b}, z21.b 
0xb7,0x31,0x28,0x05
# CHECK: tbl     z23.b, {z13.b}, z8.b // encoding: [0xb7,0x31,0x28,0x05]
# CHECK-ERROR-NOT: tbl     z23.b, {z13.b}, z8.b 
