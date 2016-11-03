// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mov     z5.b, z17.b[56]  // 00000101-11110001-00100010-00100101
// CHECK: mov     z5.b, z17.b[56] // encoding: [0x25,0x22,0xf1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110001-00100010-00100101
MOV     Z5.B, Z17.B[56]  // 00000101-11110001-00100010-00100101
// CHECK: mov     z5.b, z17.b[56] // encoding: [0x25,0x22,0xf1,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110001-00100010-00100101
mov     z23.b, z13.b[20]  // 00000101-01101001-00100001-10110111
// CHECK: mov     z23.b, z13.b[20] // encoding: [0xb7,0x21,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-00100001-10110111
MOV     Z23.B, Z13.B[20]  // 00000101-01101001-00100001-10110111
// CHECK: mov     z23.b, z13.b[20] // encoding: [0xb7,0x21,0x69,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101001-00100001-10110111
mov     z31.b, z31.b[63]  // 00000101-11111111-00100011-11111111
// CHECK: mov     z31.b, z31.b[63] // encoding: [0xff,0x23,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-00100011-11111111
MOV     Z31.B, Z31.B[63]  // 00000101-11111111-00100011-11111111
// CHECK: mov     z31.b, z31.b[63] // encoding: [0xff,0x23,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-00100011-11111111
mov     z21.b, z10.b[26]  // 00000101-01110101-00100001-01010101
// CHECK: mov     z21.b, z10.b[26] // encoding: [0x55,0x21,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-00100001-01010101
MOV     Z21.B, Z10.B[26]  // 00000101-01110101-00100001-01010101
// CHECK: mov     z21.b, z10.b[26] // encoding: [0x55,0x21,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-00100001-01010101
