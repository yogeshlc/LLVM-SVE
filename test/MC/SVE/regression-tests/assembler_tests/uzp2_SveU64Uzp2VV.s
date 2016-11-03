// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp2    z31.d, z31.d, z31.d  // 00000101-11111111-01101111-11111111
// CHECK: uzp2    z31.d, z31.d, z31.d // encoding: [0xff,0x6f,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-01101111-11111111
UZP2    Z31.D, Z31.D, Z31.D  // 00000101-11111111-01101111-11111111
// CHECK: uzp2    z31.d, z31.d, z31.d // encoding: [0xff,0x6f,0xff,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11111111-01101111-11111111
uzp2    z21.d, z10.d, z21.d  // 00000101-11110101-01101101-01010101
// CHECK: uzp2    z21.d, z10.d, z21.d // encoding: [0x55,0x6d,0xf5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110101-01101101-01010101
UZP2    Z21.D, Z10.D, Z21.D  // 00000101-11110101-01101101-01010101
// CHECK: uzp2    z21.d, z10.d, z21.d // encoding: [0x55,0x6d,0xf5,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11110101-01101101-01010101
uzp2    z23.d, z13.d, z8.d  // 00000101-11101000-01101101-10110111
// CHECK: uzp2    z23.d, z13.d, z8.d // encoding: [0xb7,0x6d,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01101101-10110111
UZP2    Z23.D, Z13.D, Z8.D  // 00000101-11101000-01101101-10110111
// CHECK: uzp2    z23.d, z13.d, z8.d // encoding: [0xb7,0x6d,0xe8,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11101000-01101101-10110111
uzp2    z0.d, z0.d, z0.d  // 00000101-11100000-01101100-00000000
// CHECK: uzp2    z0.d, z0.d, z0.d // encoding: [0x00,0x6c,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01101100-00000000
UZP2    Z0.D, Z0.D, Z0.D  // 00000101-11100000-01101100-00000000
// CHECK: uzp2    z0.d, z0.d, z0.d // encoding: [0x00,0x6c,0xe0,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-11100000-01101100-00000000
