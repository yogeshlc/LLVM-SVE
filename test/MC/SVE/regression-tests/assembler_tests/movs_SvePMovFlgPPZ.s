// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
movs    p0.b, p0/z, p0.b  // 00100101-01000000-01000000-00000000
// CHECK: movs    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x40,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01000000-01000000-00000000
MOVS    P0.B, P0/Z, P0.B  // 00100101-01000000-01000000-00000000
// CHECK: movs    p0.b, p0/z, p0.b // encoding: [0x00,0x40,0x40,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01000000-01000000-00000000
movs    p15.b, p15/z, p15.b  // 00100101-01001111-01111101-11101111
// CHECK: movs    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x4f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01001111-01111101-11101111
MOVS    P15.B, P15/Z, P15.B  // 00100101-01001111-01111101-11101111
// CHECK: movs    p15.b, p15/z, p15.b // encoding: [0xef,0x7d,0x4f,0x25]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100101-01001111-01111101-11101111
