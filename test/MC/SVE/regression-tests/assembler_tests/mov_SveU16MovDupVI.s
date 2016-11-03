// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mov     z23.h, z13.h[10]  // 00000101-01101010-00100001-10110111
// CHECK: mov     z23.h, z13.h[10] // encoding: [0xb7,0x21,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-00100001-10110111
MOV     Z23.H, Z13.H[10]  // 00000101-01101010-00100001-10110111
// CHECK: mov     z23.h, z13.h[10] // encoding: [0xb7,0x21,0x6a,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101010-00100001-10110111
mov     z5.h, z17.h[28]  // 00000101-11110010-00100010-00100101
// CHECK: mov     z5.h, z17.h[28] // encoding: [0x25,0x22,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00100010-00100101
MOV     Z5.H, Z17.H[28]  // 00000101-11110010-00100010-00100101
// CHECK: mov     z5.h, z17.h[28] // encoding: [0x25,0x22,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00100010-00100101
mov     z31.h, z31.h[31]  // 00000101-11111110-00100011-11111111
// CHECK: mov     z31.h, z31.h[31] // encoding: [0xff,0x23,0xfe,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111110-00100011-11111111
MOV     Z31.H, Z31.H[31]  // 00000101-11111110-00100011-11111111
// CHECK: mov     z31.h, z31.h[31] // encoding: [0xff,0x23,0xfe,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111110-00100011-11111111
mov     z21.h, z10.h[13]  // 00000101-01110110-00100001-01010101
// CHECK: mov     z21.h, z10.h[13] // encoding: [0x55,0x21,0x76,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110110-00100001-01010101
MOV     Z21.H, Z10.H[13]  // 00000101-01110110-00100001-01010101
// CHECK: mov     z21.h, z10.h[13] // encoding: [0x55,0x21,0x76,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110110-00100001-01010101
