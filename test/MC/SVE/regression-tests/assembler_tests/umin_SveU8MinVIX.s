// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
umin    z23.b, z23.b, #109  // 00100101-00101011-11001101-10110111
// CHECK: umin    z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11001101-10110111
UMIN    Z23.B, Z23.B, #109  // 00100101-00101011-11001101-10110111
// CHECK: umin    z23.b, z23.b, #109 // encoding: [0xb7,0xcd,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11001101-10110111
umin    z21.b, z21.b, #170  // 00100101-00101011-11010101-01010101
// CHECK: umin    z21.b, z21.b, #170 // encoding: [0x55,0xd5,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11010101-01010101
UMIN    Z21.B, Z21.B, #170  // 00100101-00101011-11010101-01010101
// CHECK: umin    z21.b, z21.b, #170 // encoding: [0x55,0xd5,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11010101-01010101
umin    z31.b, z31.b, #255  // 00100101-00101011-11011111-11111111
// CHECK: umin    z31.b, z31.b, #255 // encoding: [0xff,0xdf,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11011111-11111111
UMIN    Z31.B, Z31.B, #255  // 00100101-00101011-11011111-11111111
// CHECK: umin    z31.b, z31.b, #255 // encoding: [0xff,0xdf,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11011111-11111111
umin    z0.b, z0.b, #0  // 00100101-00101011-11000000-00000000
// CHECK: umin    z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11000000-00000000
UMIN    Z0.B, Z0.B, #0  // 00100101-00101011-11000000-00000000
// CHECK: umin    z0.b, z0.b, #0 // encoding: [0x00,0xc0,0x2b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-00101011-11000000-00000000
