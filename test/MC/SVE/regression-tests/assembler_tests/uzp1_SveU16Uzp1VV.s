// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp1    z21.h, z10.h, z21.h  // 00000101-01110101-01101001-01010101
// CHECK: uzp1    z21.h, z10.h, z21.h // encoding: [0x55,0x69,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-01101001-01010101
UZP1    Z21.H, Z10.H, Z21.H  // 00000101-01110101-01101001-01010101
// CHECK: uzp1    z21.h, z10.h, z21.h // encoding: [0x55,0x69,0x75,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01110101-01101001-01010101
uzp1    z23.h, z13.h, z8.h  // 00000101-01101000-01101001-10110111
// CHECK: uzp1    z23.h, z13.h, z8.h // encoding: [0xb7,0x69,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-01101001-10110111
UZP1    Z23.H, Z13.H, Z8.H  // 00000101-01101000-01101001-10110111
// CHECK: uzp1    z23.h, z13.h, z8.h // encoding: [0xb7,0x69,0x68,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01101000-01101001-10110111
uzp1    z0.h, z0.h, z0.h  // 00000101-01100000-01101000-00000000
// CHECK: uzp1    z0.h, z0.h, z0.h // encoding: [0x00,0x68,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-01101000-00000000
UZP1    Z0.H, Z0.H, Z0.H  // 00000101-01100000-01101000-00000000
// CHECK: uzp1    z0.h, z0.h, z0.h // encoding: [0x00,0x68,0x60,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01100000-01101000-00000000
uzp1    z31.h, z31.h, z31.h  // 00000101-01111111-01101011-11111111
// CHECK: uzp1    z31.h, z31.h, z31.h // encoding: [0xff,0x6b,0x7f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111111-01101011-11111111
UZP1    Z31.H, Z31.H, Z31.H  // 00000101-01111111-01101011-11111111
// CHECK: uzp1    z31.h, z31.h, z31.h // encoding: [0xff,0x6b,0x7f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-01111111-01101011-11111111
