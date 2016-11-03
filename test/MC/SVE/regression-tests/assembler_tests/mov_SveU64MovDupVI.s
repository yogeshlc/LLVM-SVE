// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mov     z31.d, z31.d[7]  // 00000101-11111000-00100011-11111111
// CHECK: mov     z31.d, z31.d[7] // encoding: [0xff,0x23,0xf8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111000-00100011-11111111
MOV     Z31.D, Z31.D[7]  // 00000101-11111000-00100011-11111111
// CHECK: mov     z31.d, z31.d[7] // encoding: [0xff,0x23,0xf8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111000-00100011-11111111
mov     z5.d, z17.d[7]  // 00000101-11111000-00100010-00100101
// CHECK: mov     z5.d, z17.d[7] // encoding: [0x25,0x22,0xf8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111000-00100010-00100101
MOV     Z5.D, Z17.D[7]  // 00000101-11111000-00100010-00100101
// CHECK: mov     z5.d, z17.d[7] // encoding: [0x25,0x22,0xf8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111000-00100010-00100101
mov     z21.d, z10.d[3]  // 00000101-01111000-00100001-01010101
// CHECK: mov     z21.d, z10.d[3] // encoding: [0x55,0x21,0x78,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111000-00100001-01010101
MOV     Z21.D, Z10.D[3]  // 00000101-01111000-00100001-01010101
// CHECK: mov     z21.d, z10.d[3] // encoding: [0x55,0x21,0x78,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111000-00100001-01010101
mov     z23.d, z13.d[2]  // 00000101-01101000-00100001-10110111
// CHECK: mov     z23.d, z13.d[2] // encoding: [0xb7,0x21,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-00100001-10110111
MOV     Z23.D, Z13.D[2]  // 00000101-01101000-00100001-10110111
// CHECK: mov     z23.d, z13.d[2] // encoding: [0xb7,0x21,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-00100001-10110111
