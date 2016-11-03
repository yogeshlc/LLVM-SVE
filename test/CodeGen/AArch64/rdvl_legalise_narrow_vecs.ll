; RUN: llc -verify-machineinstrs -mattr=+sve -mtriple=aarch64 < %s | FileCheck %s

; elementcount tests for vectors < 128 bits

define i64 @rdvl_nxv2i8_i8_test() {
; CHECK-LABEL: rdvl_nxv2i8_i8_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i8> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i8_i16_test() {
; CHECK-LABEL: rdvl_nxv2i8_i16_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i8> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i8_i32_test() {
; CHECK-LABEL: rdvl_nxv2i8_i32_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i8> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i8_i64_test() {
; CHECK-LABEL: rdvl_nxv2i8_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i8> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv4i8_i8_test() {
; CHECK-LABEL: rdvl_nxv4i8_i8_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i8> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i8_i16_test() {
; CHECK-LABEL: rdvl_nxv4i8_i16_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i8> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i8_i32_test() {
; CHECK-LABEL: rdvl_nxv4i8_i32_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i8> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i8_i64_test() {
; CHECK-LABEL: rdvl_nxv4i8_i64_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i8> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv8i8_i8_test() {
; CHECK-LABEL: rdvl_nxv8i8_i8_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i8> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i8_i16_test() {
; CHECK-LABEL: rdvl_nxv8i8_i16_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i8> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i8_i32_test() {
; CHECK-LABEL: rdvl_nxv8i8_i32_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i8> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv8i8_i64_test() {
; CHECK-LABEL: rdvl_nxv8i8_i64_test:
; CHECK: cnth x0
; CHECK-NEXT: ret
  %count = elementcount <n x 8 x i8> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv2i16_i8_test() {
; CHECK-LABEL: rdvl_nxv2i16_i8_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i16> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i16_i16_test() {
; CHECK-LABEL: rdvl_nxv2i16_i16_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i16> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i16_i32_test() {
; CHECK-LABEL: rdvl_nxv2i16_i32_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i16> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i16_i64_test() {
; CHECK-LABEL: rdvl_nxv2i16_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i16> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv4i16_i8_test() {
; CHECK-LABEL: rdvl_nxv4i16_i8_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i16> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i16_i16_test() {
; CHECK-LABEL: rdvl_nxv4i16_i16_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i16> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i16_i32_test() {
; CHECK-LABEL: rdvl_nxv4i16_i32_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i16> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv4i16_i64_test() {
; CHECK-LABEL: rdvl_nxv4i16_i64_test:
; CHECK: cntw x0
; CHECK-NEXT: ret
  %count = elementcount <n x 4 x i16> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv2i32_i8_test()  {
; CHECK-LABEL: rdvl_nxv2i32_i8_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i32> zeroinitializer as i8
  %zext_count = zext i8 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i32_i16_test() {
; CHECK-LABEL: rdvl_nxv2i32_i16_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i32> zeroinitializer as i16
  %zext_count = zext i16 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i32_i32_test() {
; CHECK-LABEL: rdvl_nxv2i32_i32_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i32> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2i32_i64_test() {
; CHECK-LABEL: rdvl_nxv2i32_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x i32> zeroinitializer as i64
  ret i64 %count
}

; TODO: suboptimal code generation
define i64 @rdvl_nxv1i64_i32_test() {
; CHECK-LABEL: rdvl_nxv1i64_i32_test:
; CHECK: cntd x[[CNT:[0-9]+]]
; CHECK-NEXT: asr w0, w[[CNT]], #1
; CHECK-NEXT: ret
  %count = elementcount <n x 1 x i64> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv1i64_i64_test() {
; CHECK-LABEL: rdvl_nxv1i64_i64_test:
; CHECK: rdvl x[[NUM_BYTES:[0-9]+]], #1
; CHECK-NEXT: lsr x0, x[[NUM_BYTES]], #4
; CHECK-NEXT: ret
  %count = elementcount <n x 1 x i64> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv2f32_i32_test() {
; CHECK-LABEL: rdvl_nxv2f32_i32_test:
; CHECK: cntd x0
; CHECK: ret
  %count = elementcount <n x 2 x float> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv2f32_i64_test() {
; CHECK-LABEL: rdvl_nxv2f32_i64_test:
; CHECK: cntd x0
; CHECK-NEXT: ret
  %count = elementcount <n x 2 x float> zeroinitializer as i64
  ret i64 %count
}

define i64 @rdvl_nxv1f64_i32_test() {
; CHECK-LABEL: rdvl_nxv1f64_i32_test:
; CHECK:      rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsr x0, x[[SIZE_B]], #4
; CHECK: ret
  %count = elementcount <n x 1 x double> zeroinitializer as i32
  %zext_count = zext i32 %count to i64
  ret i64 %zext_count
}

define i64 @rdvl_nxv1f64_i64_test() {
; CHECK-LABEL: rdvl_nxv1f64_i64_test:
; CHECK:      rdvl x[[SIZE_B:[0-9]+]], #1
; CHECK-NEXT: lsr x0, x[[SIZE_B]], #4
; CHECK-NEXT: ret
  %count = elementcount <n x 1 x double> zeroinitializer as i64
  ret i64 %count
}
