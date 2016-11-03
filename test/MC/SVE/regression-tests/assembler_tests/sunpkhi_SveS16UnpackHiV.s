// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
sunpkhi z0.h, z0.b  // 00000101-01110001-00111000-00000000
// CHECK: sunpkhi z0.h, z0.b // encoding: [0x00,0x38,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111000-00000000
SUNPKHI Z0.H, Z0.B  // 00000101-01110001-00111000-00000000
// CHECK: sunpkhi z0.h, z0.b // encoding: [0x00,0x38,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111000-00000000
sunpkhi z31.h, z31.b  // 00000101-01110001-00111011-11111111
// CHECK: sunpkhi z31.h, z31.b // encoding: [0xff,0x3b,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111011-11111111
SUNPKHI Z31.H, Z31.B  // 00000101-01110001-00111011-11111111
// CHECK: sunpkhi z31.h, z31.b // encoding: [0xff,0x3b,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111011-11111111
sunpkhi z21.h, z10.b  // 00000101-01110001-00111001-01010101
// CHECK: sunpkhi z21.h, z10.b // encoding: [0x55,0x39,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-01010101
SUNPKHI Z21.H, Z10.B  // 00000101-01110001-00111001-01010101
// CHECK: sunpkhi z21.h, z10.b // encoding: [0x55,0x39,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-01010101
sunpkhi z23.h, z13.b  // 00000101-01110001-00111001-10110111
// CHECK: sunpkhi z23.h, z13.b // encoding: [0xb7,0x39,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-10110111
SUNPKHI Z23.H, Z13.B  // 00000101-01110001-00111001-10110111
// CHECK: sunpkhi z23.h, z13.b // encoding: [0xb7,0x39,0x71,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110001-00111001-10110111
