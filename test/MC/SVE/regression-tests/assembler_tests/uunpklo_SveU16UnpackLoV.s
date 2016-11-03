// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uunpklo z0.h, z0.b  // 00000101-01110010-00111000-00000000
// CHECK: uunpklo z0.h, z0.b // encoding: [0x00,0x38,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111000-00000000
UUNPKLO Z0.H, Z0.B  // 00000101-01110010-00111000-00000000
// CHECK: uunpklo z0.h, z0.b // encoding: [0x00,0x38,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111000-00000000
uunpklo z23.h, z13.b  // 00000101-01110010-00111001-10110111
// CHECK: uunpklo z23.h, z13.b // encoding: [0xb7,0x39,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111001-10110111
UUNPKLO Z23.H, Z13.B  // 00000101-01110010-00111001-10110111
// CHECK: uunpklo z23.h, z13.b // encoding: [0xb7,0x39,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111001-10110111
uunpklo z21.h, z10.b  // 00000101-01110010-00111001-01010101
// CHECK: uunpklo z21.h, z10.b // encoding: [0x55,0x39,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111001-01010101
UUNPKLO Z21.H, Z10.B  // 00000101-01110010-00111001-01010101
// CHECK: uunpklo z21.h, z10.b // encoding: [0x55,0x39,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111001-01010101
uunpklo z31.h, z31.b  // 00000101-01110010-00111011-11111111
// CHECK: uunpklo z31.h, z31.b // encoding: [0xff,0x3b,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111011-11111111
UUNPKLO Z31.H, Z31.B  // 00000101-01110010-00111011-11111111
// CHECK: uunpklo z31.h, z31.b // encoding: [0xff,0x3b,0x72,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110010-00111011-11111111
