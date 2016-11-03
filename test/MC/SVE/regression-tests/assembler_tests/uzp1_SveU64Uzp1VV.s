// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp1    z23.d, z13.d, z8.d  // 00000101-11101000-01101001-10110111
// CHECK: uzp1    z23.d, z13.d, z8.d // encoding: [0xb7,0x69,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01101001-10110111
UZP1    Z23.D, Z13.D, Z8.D  // 00000101-11101000-01101001-10110111
// CHECK: uzp1    z23.d, z13.d, z8.d // encoding: [0xb7,0x69,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01101001-10110111
uzp1    z0.d, z0.d, z0.d  // 00000101-11100000-01101000-00000000
// CHECK: uzp1    z0.d, z0.d, z0.d // encoding: [0x00,0x68,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01101000-00000000
UZP1    Z0.D, Z0.D, Z0.D  // 00000101-11100000-01101000-00000000
// CHECK: uzp1    z0.d, z0.d, z0.d // encoding: [0x00,0x68,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01101000-00000000
uzp1    z31.d, z31.d, z31.d  // 00000101-11111111-01101011-11111111
// CHECK: uzp1    z31.d, z31.d, z31.d // encoding: [0xff,0x6b,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-01101011-11111111
UZP1    Z31.D, Z31.D, Z31.D  // 00000101-11111111-01101011-11111111
// CHECK: uzp1    z31.d, z31.d, z31.d // encoding: [0xff,0x6b,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-01101011-11111111
uzp1    z21.d, z10.d, z21.d  // 00000101-11110101-01101001-01010101
// CHECK: uzp1    z21.d, z10.d, z21.d // encoding: [0x55,0x69,0xf5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110101-01101001-01010101
UZP1    Z21.D, Z10.D, Z21.D  // 00000101-11110101-01101001-01010101
// CHECK: uzp1    z21.d, z10.d, z21.d // encoding: [0x55,0x69,0xf5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110101-01101001-01010101
