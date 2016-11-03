// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fexpa   z23.d, z13.d  // 00000100-11100000-10111001-10110111
// CHECK: fexpa   z23.d, z13.d // encoding: [0xb7,0xb9,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-10110111
FEXPA   Z23.D, Z13.D  // 00000100-11100000-10111001-10110111
// CHECK: fexpa   z23.d, z13.d // encoding: [0xb7,0xb9,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-10110111
fexpa   z0.d, z0.d  // 00000100-11100000-10111000-00000000
// CHECK: fexpa   z0.d, z0.d // encoding: [0x00,0xb8,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111000-00000000
FEXPA   Z0.D, Z0.D  // 00000100-11100000-10111000-00000000
// CHECK: fexpa   z0.d, z0.d // encoding: [0x00,0xb8,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111000-00000000
fexpa   z21.d, z10.d  // 00000100-11100000-10111001-01010101
// CHECK: fexpa   z21.d, z10.d // encoding: [0x55,0xb9,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-01010101
FEXPA   Z21.D, Z10.D  // 00000100-11100000-10111001-01010101
// CHECK: fexpa   z21.d, z10.d // encoding: [0x55,0xb9,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111001-01010101
fexpa   z31.d, z31.d  // 00000100-11100000-10111011-11111111
// CHECK: fexpa   z31.d, z31.d // encoding: [0xff,0xbb,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111011-11111111
FEXPA   Z31.D, Z31.D  // 00000100-11100000-10111011-11111111
// CHECK: fexpa   z31.d, z31.d // encoding: [0xff,0xbb,0xe0,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-11100000-10111011-11111111
