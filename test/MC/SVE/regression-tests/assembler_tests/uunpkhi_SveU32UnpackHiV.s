// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uunpkhi z0.s, z0.h  // 00000101-10110011-00111000-00000000
// CHECK: uunpkhi z0.s, z0.h // encoding: [0x00,0x38,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111000-00000000
UUNPKHI Z0.S, Z0.H  // 00000101-10110011-00111000-00000000
// CHECK: uunpkhi z0.s, z0.h // encoding: [0x00,0x38,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111000-00000000
uunpkhi z23.s, z13.h  // 00000101-10110011-00111001-10110111
// CHECK: uunpkhi z23.s, z13.h // encoding: [0xb7,0x39,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111001-10110111
UUNPKHI Z23.S, Z13.H  // 00000101-10110011-00111001-10110111
// CHECK: uunpkhi z23.s, z13.h // encoding: [0xb7,0x39,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111001-10110111
uunpkhi z21.s, z10.h  // 00000101-10110011-00111001-01010101
// CHECK: uunpkhi z21.s, z10.h // encoding: [0x55,0x39,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111001-01010101
UUNPKHI Z21.S, Z10.H  // 00000101-10110011-00111001-01010101
// CHECK: uunpkhi z21.s, z10.h // encoding: [0x55,0x39,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111001-01010101
uunpkhi z31.s, z31.h  // 00000101-10110011-00111011-11111111
// CHECK: uunpkhi z31.s, z31.h // encoding: [0xff,0x3b,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111011-11111111
UUNPKHI Z31.S, Z31.H  // 00000101-10110011-00111011-11111111
// CHECK: uunpkhi z31.s, z31.h // encoding: [0xff,0x3b,0xb3,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-10110011-00111011-11111111
