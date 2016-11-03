// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
index   z23.b, #13, #8  // 00000100-00101000-01000001-10110111
// CHECK: index   z23.b, #13, #8 // encoding: [0xb7,0x41,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-01000001-10110111
INDEX   Z23.B, #13, #8  // 00000100-00101000-01000001-10110111
// CHECK: index   z23.b, #13, #8 // encoding: [0xb7,0x41,0x28,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00101000-01000001-10110111
index   z0.b, #0, #0  // 00000100-00100000-01000000-00000000
// CHECK: index   z0.b, #0, #0 // encoding: [0x00,0x40,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-01000000-00000000
INDEX   Z0.B, #0, #0  // 00000100-00100000-01000000-00000000
// CHECK: index   z0.b, #0, #0 // encoding: [0x00,0x40,0x20,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00100000-01000000-00000000
index   z31.b, #-1, #-1  // 00000100-00111111-01000011-11111111
// CHECK: index   z31.b, #-1, #-1 // encoding: [0xff,0x43,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-01000011-11111111
INDEX   Z31.B, #-1, #-1  // 00000100-00111111-01000011-11111111
// CHECK: index   z31.b, #-1, #-1 // encoding: [0xff,0x43,0x3f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00111111-01000011-11111111
index   z21.b, #10, #-11  // 00000100-00110101-01000001-01010101
// CHECK: index   z21.b, #10, #-11 // encoding: [0x55,0x41,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-01000001-01010101
INDEX   Z21.B, #10, #-11  // 00000100-00110101-01000001-01010101
// CHECK: index   z21.b, #10, #-11 // encoding: [0x55,0x41,0x35,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-00110101-01000001-01010101
