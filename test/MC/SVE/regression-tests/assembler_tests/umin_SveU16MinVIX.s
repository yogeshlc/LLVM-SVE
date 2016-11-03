// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
umin    z21.h, z21.h, #170  // 00100101-01101011-11010101-01010101
// CHECK: umin    z21.h, z21.h, #170 // encoding: [0x55,0xd5,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11010101-01010101
UMIN    Z21.H, Z21.H, #170  // 00100101-01101011-11010101-01010101
// CHECK: umin    z21.h, z21.h, #170 // encoding: [0x55,0xd5,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11010101-01010101
umin    z23.h, z23.h, #109  // 00100101-01101011-11001101-10110111
// CHECK: umin    z23.h, z23.h, #109 // encoding: [0xb7,0xcd,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11001101-10110111
UMIN    Z23.H, Z23.H, #109  // 00100101-01101011-11001101-10110111
// CHECK: umin    z23.h, z23.h, #109 // encoding: [0xb7,0xcd,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11001101-10110111
umin    z0.h, z0.h, #0  // 00100101-01101011-11000000-00000000
// CHECK: umin    z0.h, z0.h, #0 // encoding: [0x00,0xc0,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11000000-00000000
UMIN    Z0.H, Z0.H, #0  // 00100101-01101011-11000000-00000000
// CHECK: umin    z0.h, z0.h, #0 // encoding: [0x00,0xc0,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11000000-00000000
umin    z31.h, z31.h, #255  // 00100101-01101011-11011111-11111111
// CHECK: umin    z31.h, z31.h, #255 // encoding: [0xff,0xdf,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11011111-11111111
UMIN    Z31.H, Z31.H, #255  // 00100101-01101011-11011111-11111111
// CHECK: umin    z31.h, z31.h, #255 // encoding: [0xff,0xdf,0x6b,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01101011-11011111-11111111
