// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
zip2    z0.s, z0.s, z0.s  // 00000101-10100000-01100100-00000000
// CHECK: zip2    z0.s, z0.s, z0.s // encoding: [0x00,0x64,0xa0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100000-01100100-00000000
ZIP2    Z0.S, Z0.S, Z0.S  // 00000101-10100000-01100100-00000000
// CHECK: zip2    z0.s, z0.s, z0.s // encoding: [0x00,0x64,0xa0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10100000-01100100-00000000
zip2    z21.s, z10.s, z21.s  // 00000101-10110101-01100101-01010101
// CHECK: zip2    z21.s, z10.s, z21.s // encoding: [0x55,0x65,0xb5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110101-01100101-01010101
ZIP2    Z21.S, Z10.S, Z21.S  // 00000101-10110101-01100101-01010101
// CHECK: zip2    z21.s, z10.s, z21.s // encoding: [0x55,0x65,0xb5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110101-01100101-01010101
zip2    z23.s, z13.s, z8.s  // 00000101-10101000-01100101-10110111
// CHECK: zip2    z23.s, z13.s, z8.s // encoding: [0xb7,0x65,0xa8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101000-01100101-10110111
ZIP2    Z23.S, Z13.S, Z8.S  // 00000101-10101000-01100101-10110111
// CHECK: zip2    z23.s, z13.s, z8.s // encoding: [0xb7,0x65,0xa8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10101000-01100101-10110111
zip2    z31.s, z31.s, z31.s  // 00000101-10111111-01100111-11111111
// CHECK: zip2    z31.s, z31.s, z31.s // encoding: [0xff,0x67,0xbf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10111111-01100111-11111111
ZIP2    Z31.S, Z31.S, Z31.S  // 00000101-10111111-01100111-11111111
// CHECK: zip2    z31.s, z31.s, z31.s // encoding: [0xff,0x67,0xbf,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10111111-01100111-11111111
