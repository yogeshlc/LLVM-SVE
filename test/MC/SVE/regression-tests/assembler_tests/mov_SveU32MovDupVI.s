// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mov     z5.s, z17.s[14]  // 00000101-11110100-00100010-00100101
// CHECK: mov     z5.s, z17.s[14] // encoding: [0x25,0x22,0xf4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110100-00100010-00100101
MOV     Z5.S, Z17.S[14]  // 00000101-11110100-00100010-00100101
// CHECK: mov     z5.s, z17.s[14] // encoding: [0x25,0x22,0xf4,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110100-00100010-00100101
mov     z21.s, z10.s[6]  // 00000101-01110100-00100001-01010101
// CHECK: mov     z21.s, z10.s[6] // encoding: [0x55,0x21,0x74,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110100-00100001-01010101
MOV     Z21.S, Z10.S[6]  // 00000101-01110100-00100001-01010101
// CHECK: mov     z21.s, z10.s[6] // encoding: [0x55,0x21,0x74,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110100-00100001-01010101
mov     z31.s, z31.s[15]  // 00000101-11111100-00100011-11111111
// CHECK: mov     z31.s, z31.s[15] // encoding: [0xff,0x23,0xfc,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111100-00100011-11111111
MOV     Z31.S, Z31.S[15]  // 00000101-11111100-00100011-11111111
// CHECK: mov     z31.s, z31.s[15] // encoding: [0xff,0x23,0xfc,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111100-00100011-11111111
mov     z23.s, z13.s[5]  // 00000101-01101100-00100001-10110111
// CHECK: mov     z23.s, z13.s[5] // encoding: [0xb7,0x21,0x6c,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101100-00100001-10110111
MOV     Z23.S, Z13.S[5]  // 00000101-01101100-00100001-10110111
// CHECK: mov     z23.s, z13.s[5] // encoding: [0xb7,0x21,0x6c,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101100-00100001-10110111
