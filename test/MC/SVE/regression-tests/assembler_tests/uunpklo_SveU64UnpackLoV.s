// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uunpklo z21.d, z10.s  // 00000101-11110010-00111001-01010101
// CHECK: uunpklo z21.d, z10.s // encoding: [0x55,0x39,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111001-01010101
UUNPKLO Z21.D, Z10.S  // 00000101-11110010-00111001-01010101
// CHECK: uunpklo z21.d, z10.s // encoding: [0x55,0x39,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111001-01010101
uunpklo z0.d, z0.s  // 00000101-11110010-00111000-00000000
// CHECK: uunpklo z0.d, z0.s // encoding: [0x00,0x38,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111000-00000000
UUNPKLO Z0.D, Z0.S  // 00000101-11110010-00111000-00000000
// CHECK: uunpklo z0.d, z0.s // encoding: [0x00,0x38,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111000-00000000
uunpklo z31.d, z31.s  // 00000101-11110010-00111011-11111111
// CHECK: uunpklo z31.d, z31.s // encoding: [0xff,0x3b,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111011-11111111
UUNPKLO Z31.D, Z31.S  // 00000101-11110010-00111011-11111111
// CHECK: uunpklo z31.d, z31.s // encoding: [0xff,0x3b,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111011-11111111
uunpklo z23.d, z13.s  // 00000101-11110010-00111001-10110111
// CHECK: uunpklo z23.d, z13.s // encoding: [0xb7,0x39,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111001-10110111
UUNPKLO Z23.D, Z13.S  // 00000101-11110010-00111001-10110111
// CHECK: uunpklo z23.d, z13.s // encoding: [0xb7,0x39,0xf2,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110010-00111001-10110111
