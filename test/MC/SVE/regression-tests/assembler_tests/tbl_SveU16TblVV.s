// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
tbl     z21.h, {z10.h}, z21.h  // 00000101-01110101-00110001-01010101
// CHECK: tbl     z21.h, {z10.h}, z21.h // encoding: [0x55,0x31,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-00110001-01010101
TBL     Z21.H, {Z10.H}, Z21.H  // 00000101-01110101-00110001-01010101
// CHECK: tbl     z21.h, {z10.h}, z21.h // encoding: [0x55,0x31,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-00110001-01010101
tbl     z0.h, {z0.h}, z0.h  // 00000101-01100000-00110000-00000000
// CHECK: tbl     z0.h, {z0.h}, z0.h // encoding: [0x00,0x30,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-00110000-00000000
TBL     Z0.H, {Z0.H}, Z0.H  // 00000101-01100000-00110000-00000000
// CHECK: tbl     z0.h, {z0.h}, z0.h // encoding: [0x00,0x30,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-00110000-00000000
tbl     z23.h, {z13.h}, z8.h  // 00000101-01101000-00110001-10110111
// CHECK: tbl     z23.h, {z13.h}, z8.h // encoding: [0xb7,0x31,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-00110001-10110111
TBL     Z23.H, {Z13.H}, Z8.H  // 00000101-01101000-00110001-10110111
// CHECK: tbl     z23.h, {z13.h}, z8.h // encoding: [0xb7,0x31,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-00110001-10110111
tbl     z31.h, {z31.h}, z31.h  // 00000101-01111111-00110011-11111111
// CHECK: tbl     z31.h, {z31.h}, z31.h // encoding: [0xff,0x33,0x7f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111111-00110011-11111111
TBL     Z31.H, {Z31.H}, Z31.H  // 00000101-01111111-00110011-11111111
// CHECK: tbl     z31.h, {z31.h}, z31.h // encoding: [0xff,0x33,0x7f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111111-00110011-11111111
