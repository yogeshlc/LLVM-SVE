// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
fnmla   z31.d, p7/m, z31.d, z31.d  // 01100101-11111111-01011111-11111111
// CHECK: fnmla   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x5f,0xff,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11111111-01011111-11111111
FNMLA   Z31.D, P7/M, Z31.D, Z31.D  // 01100101-11111111-01011111-11111111
// CHECK: fnmla   z31.d, p7/m, z31.d, z31.d // encoding: [0xff,0x5f,0xff,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11111111-01011111-11111111
fnmla   z23.d, p3/m, z13.d, z8.d  // 01100101-11101000-01001101-10110111
// CHECK: fnmla   z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x4d,0xe8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11101000-01001101-10110111
FNMLA   Z23.D, P3/M, Z13.D, Z8.D  // 01100101-11101000-01001101-10110111
// CHECK: fnmla   z23.d, p3/m, z13.d, z8.d // encoding: [0xb7,0x4d,0xe8,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11101000-01001101-10110111
fnmla   z21.d, p5/m, z10.d, z21.d  // 01100101-11110101-01010101-01010101
// CHECK: fnmla   z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x55,0xf5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11110101-01010101-01010101
FNMLA   Z21.D, P5/M, Z10.D, Z21.D  // 01100101-11110101-01010101-01010101
// CHECK: fnmla   z21.d, p5/m, z10.d, z21.d // encoding: [0x55,0x55,0xf5,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11110101-01010101-01010101
fnmla   z0.d, p0/m, z0.d, z0.d  // 01100101-11100000-01000000-00000000
// CHECK: fnmla   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x40,0xe0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11100000-01000000-00000000
FNMLA   Z0.D, P0/M, Z0.D, Z0.D  // 01100101-11100000-01000000-00000000
// CHECK: fnmla   z0.d, p0/m, z0.d, z0.d // encoding: [0x00,0x40,0xe0,0x65]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 01100101-11100000-01000000-00000000
