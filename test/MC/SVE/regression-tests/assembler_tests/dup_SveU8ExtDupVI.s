// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
dup     z0.b, z0.b[0]  // 00000101-00100001-00100000-00000000
// CHECK: mov     z0.b, b0 // encoding: [0x00,0x20,0x21,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100001-00100000-00000000
DUP     Z0.B, Z0.B[0]  // 00000101-00100001-00100000-00000000
// CHECK: mov     z0.b, b0 // encoding: [0x00,0x20,0x21,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100001-00100000-00000000
dup     z5.b, z17.b[56]  // 00000101-11110001-00100010-00100101
// CHECK: mov     z5.b, z17.b[56] // encoding: [0x25,0x22,0xf1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110001-00100010-00100101
DUP     Z5.B, Z17.B[56]  // 00000101-11110001-00100010-00100101
// CHECK: mov     z5.b, z17.b[56] // encoding: [0x25,0x22,0xf1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110001-00100010-00100101
dup     z23.b, z13.b[20]  // 00000101-01101001-00100001-10110111
// CHECK: mov     z23.b, z13.b[20] // encoding: [0xb7,0x21,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-00100001-10110111
DUP     Z23.B, Z13.B[20]  // 00000101-01101001-00100001-10110111
// CHECK: mov     z23.b, z13.b[20] // encoding: [0xb7,0x21,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-00100001-10110111
dup     z31.b, z31.b[63]  // 00000101-11111111-00100011-11111111
// CHECK: mov     z31.b, z31.b[63] // encoding: [0xff,0x23,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-00100011-11111111
DUP     Z31.B, Z31.B[63]  // 00000101-11111111-00100011-11111111
// CHECK: mov     z31.b, z31.b[63] // encoding: [0xff,0x23,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-00100011-11111111
dup     z21.b, z10.b[26]  // 00000101-01110101-00100001-01010101
// CHECK: mov     z21.b, z10.b[26] // encoding: [0x55,0x21,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-00100001-01010101
DUP     Z21.B, Z10.B[26]  // 00000101-01110101-00100001-01010101
// CHECK: mov     z21.b, z10.b[26] // encoding: [0x55,0x21,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-00100001-01010101
