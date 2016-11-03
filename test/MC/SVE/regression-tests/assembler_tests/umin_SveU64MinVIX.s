// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
umin    z0.d, z0.d, #0  // 00100101-11101011-11000000-00000000
// CHECK: umin    z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11000000-00000000
UMIN    Z0.D, Z0.D, #0  // 00100101-11101011-11000000-00000000
// CHECK: umin    z0.d, z0.d, #0 // encoding: [0x00,0xc0,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11000000-00000000
umin    z31.d, z31.d, #255  // 00100101-11101011-11011111-11111111
// CHECK: umin    z31.d, z31.d, #255 // encoding: [0xff,0xdf,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11011111-11111111
UMIN    Z31.D, Z31.D, #255  // 00100101-11101011-11011111-11111111
// CHECK: umin    z31.d, z31.d, #255 // encoding: [0xff,0xdf,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11011111-11111111
umin    z23.d, z23.d, #109  // 00100101-11101011-11001101-10110111
// CHECK: umin    z23.d, z23.d, #109 // encoding: [0xb7,0xcd,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11001101-10110111
UMIN    Z23.D, Z23.D, #109  // 00100101-11101011-11001101-10110111
// CHECK: umin    z23.d, z23.d, #109 // encoding: [0xb7,0xcd,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11001101-10110111
umin    z21.d, z21.d, #170  // 00100101-11101011-11010101-01010101
// CHECK: umin    z21.d, z21.d, #170 // encoding: [0x55,0xd5,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11010101-01010101
UMIN    Z21.D, Z21.D, #170  // 00100101-11101011-11010101-01010101
// CHECK: umin    z21.d, z21.d, #170 // encoding: [0x55,0xd5,0xeb,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-11101011-11010101-01010101
