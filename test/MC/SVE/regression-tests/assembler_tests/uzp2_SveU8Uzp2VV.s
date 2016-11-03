// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
uzp2    z31.b, z31.b, z31.b  // 00000101-00111111-01101111-11111111
// CHECK: uzp2    z31.b, z31.b, z31.b // encoding: [0xff,0x6f,0x3f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00111111-01101111-11111111
UZP2    Z31.B, Z31.B, Z31.B  // 00000101-00111111-01101111-11111111
// CHECK: uzp2    z31.b, z31.b, z31.b // encoding: [0xff,0x6f,0x3f,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00111111-01101111-11111111
uzp2    z0.b, z0.b, z0.b  // 00000101-00100000-01101100-00000000
// CHECK: uzp2    z0.b, z0.b, z0.b // encoding: [0x00,0x6c,0x20,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100000-01101100-00000000
UZP2    Z0.B, Z0.B, Z0.B  // 00000101-00100000-01101100-00000000
// CHECK: uzp2    z0.b, z0.b, z0.b // encoding: [0x00,0x6c,0x20,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00100000-01101100-00000000
uzp2    z23.b, z13.b, z8.b  // 00000101-00101000-01101101-10110111
// CHECK: uzp2    z23.b, z13.b, z8.b // encoding: [0xb7,0x6d,0x28,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101000-01101101-10110111
UZP2    Z23.B, Z13.B, Z8.B  // 00000101-00101000-01101101-10110111
// CHECK: uzp2    z23.b, z13.b, z8.b // encoding: [0xb7,0x6d,0x28,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00101000-01101101-10110111
uzp2    z21.b, z10.b, z21.b  // 00000101-00110101-01101101-01010101
// CHECK: uzp2    z21.b, z10.b, z21.b // encoding: [0x55,0x6d,0x35,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00110101-01101101-01010101
UZP2    Z21.B, Z10.B, Z21.B  // 00000101-00110101-01101101-01010101
// CHECK: uzp2    z21.b, z10.b, z21.b // encoding: [0x55,0x6d,0x35,0x05]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000101-00110101-01101101-01010101
