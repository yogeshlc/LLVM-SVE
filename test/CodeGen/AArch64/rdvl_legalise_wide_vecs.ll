; RUN: llc -verify-machineinstrs -mattr=+sve -mtriple=aarch64 < %s | FileCheck %s

; elementcount tests for vectors > 128 bits

define i64 @rdvl_nxv32i8_i8_test() {
; CHECK-LABEL: rdvl_nxv32i8_i8_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl [[RES:w[0-9]+]], w[[SIZE_B]], #1
; CHECK-NEXT: and x0, [[RES:x[0-9]+]], #0xfe
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i8> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i8_i16_test() {
; CHECK-LABEL: rdvl_nxv32i8_i16_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl w0, w[[SIZE_B]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i8> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i8_i32_test() {
; CHECK-LABEL: rdvl_nxv32i8_i32_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl w0, w[[SIZE_B]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i8> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i8_i64_test() {
; CHECK-LABEL: rdvl_nxv32i8_i64_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl x0, x[[SIZE_B]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i8> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv16i16_i8_test() {
; CHECK-LABEL: rdvl_nxv16i16_i8_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: and x0, [[RES:x[0-9]+]], #0xfe
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i16> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i16_i16_test() {
; CHECK-LABEL: rdvl_nxv16i16_i16_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i16> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i16_i32_test() {
; CHECK-LABEL: rdvl_nxv16i16_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i16> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i16_i64_test() {
; CHECK-LABEL: rdvl_nxv16i16_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i16> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv32i16_i8_test() {
; CHECK-LABEL: rdvl_nxv32i16_i8_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl w[[SIZE:[0-9]+]], w[[SIZE_B]], #1
; CHECK-NEXT: and	x0, x[[SIZE]], #0xfc
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i16> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i16_i16_test() {
; CHECK-LABEL: rdvl_nxv32i16_i16_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl w0, w[[SIZE_B]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i16> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i16_i32_test() {
; CHECK-LABEL: rdvl_nxv32i16_i32_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl w0, w[[SIZE_B]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i16> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv32i16_i64_test() {
; CHECK-LABEL: rdvl_nxv32i16_i64_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsl x0, x[[SIZE_B]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 32 x i16> zeroinitializer as i64
  ret i64 %count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv8i32_i8_test() {
; CHECK-LABEL: rdvl_nxv8i32_i8_test:
; CHECK: cntw x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i32> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv8i32_i16_test() {
; CHECK-LABEL: rdvl_nxv8i32_i16_test:
; CHECK: cntw x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i32> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv8i32_i32_test() {
; CHECK-LABEL: rdvl_nxv8i32_i32_test:
; CHECK: cntw x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[SIZE]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i32> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i32_i64_test() {
; CHECK-LABEL: rdvl_nxv8i32_i64_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i32> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv16i32_i8_test() {
; CHECK-LABEL: rdvl_nxv16i32_i8_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: and x0, x[[SIZE_B]], #0xfc
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i32> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i32_i16_test() {
; CHECK-LABEL: rdvl_nxv16i32_i16_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i32> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i32_i32_test() {
; CHECK-LABEL: rdvl_nxv16i32_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i32> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i32_i64_test() {
; CHECK-LABEL: rdvl_nxv16i32_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i32> zeroinitializer as i64
  ret i64 %count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv4i64_i8_test() {
; CHECK-LABEL: rdvl_nxv4i64_i8_test:
; CHECK: cntd x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i64> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv4i64_i16_test() {
; CHECK-LABEL: rdvl_nxv4i64_i16_test:
; CHECK: cntd x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i64> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv4i64_i32_test() {
; CHECK-LABEL: rdvl_nxv4i64_i32_test:
; CHECK: cntd x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i64> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i64_i64_test() {
; CHECK-LABEL: rdvl_nxv4i64_i64_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i64> zeroinitializer as i64
  ret i64 %count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv8i64_i8_test() {
; CHECK-LABEL: rdvl_nxv8i64_i8_test:
; CHECK: cntd x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #2
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i64> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv8i64_i16_test() {
; CHECK-LABEL: rdvl_nxv8i64_i16_test:
; CHECK: cntd x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #2
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i64> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv8i64_i32_test() {
; CHECK-LABEL: rdvl_nxv8i64_i32_test:
; CHECK: cntd x[[RES:[0-9]+]]
; CHECK-NEXT: lsl w0, w[[RES]], #2
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i64> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i64_i64_test() {
; CHECK-LABEL: rdvl_nxv8i64_i64_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i64> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv16i64_i8_test() {
; CHECK-LABEL: rdvl_nxv16i64_i8_test:
; CHECK: rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: and x0, x[[SIZE_B]], #0xf8
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i64> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i64_i16_test() {
; CHECK-LABEL: rdvl_nxv16i64_i16_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i64> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i64_i32_test() {
; CHECK-LABEL: rdvl_nxv16i64_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i64> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16i64_i64_test() {
; CHECK-LABEL: rdvl_nxv16i64_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x i64> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv16f32_i32_test() {
; CHECK-LABEL: rdvl_nxv16f32_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x float> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16f32_i64_test() {
; CHECK-LABEL: rdvl_nxv16f32_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x float> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv16f64_i32_test() {
; CHECK-LABEL: rdvl_nxv16f64_i32_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x double> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv16f64_i64_test() {
; CHECK-LABEL: rdvl_nxv16f64_i64_test:
; CHECK: rdvl x0, #1
; CHECK-NEXT: ret
  %count = elementcount <n x 16 x double> zeroinitializer as i64
  ret i64 %count
}
