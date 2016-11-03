; RUN: llc -mtriple=aarch64--linux-gnu < %s | FileCheck %s

define i32 @test_all_false_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_all_false_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test all false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_false_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_all_false_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test all false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_false_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_all_false_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test all false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_false_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_all_false_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test all false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_all_true_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test all true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_all_true_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test all true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_all_true_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test all true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_all_true_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test all true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_any_false_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test any false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_any_false_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test any false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_any_false_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test any false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_any_false_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test any false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_any_true_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test any true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_any_true_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test any true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_any_true_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test any true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_any_true_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test any true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_first_false_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test first false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_first_false_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test first false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_first_false_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test first false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_first_false_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test first false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_first_true_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test first true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_first_true_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test first true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_first_true_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test first true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_first_true_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test first true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_last_false_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test last false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_last_false_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test last false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_last_false_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test last false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_last_false_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], le
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test last false i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_b(i8 *%a, i8 *%b) {
; CHECK-LABEL: test_last_true_b:
; CHECK-DAG: ldrsb [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsb [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i8 , i8 *%a
  %in1 = load i8 , i8 *%b
  %cmp = icmp sgt i8 %in0, %in1
  %cond = test last true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_h(i16 *%a, i16 *%b) {
; CHECK-LABEL: test_last_true_h:
; CHECK-DAG: ldrsh [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldrsh [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i16 , i16 *%a
  %in1 = load i16 , i16 *%b
  %cmp = icmp sgt i16 %in0, %in1
  %cond = test last true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_s(i32 *%a, i32 *%b) {
; CHECK-LABEL: test_last_true_s:
; CHECK-DAG: ldr [[IN0:w[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:w[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i32 , i32 *%a
  %in1 = load i32 , i32 *%b
  %cmp = icmp sgt i32 %in0, %in1
  %cond = test last true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_d(i64 *%a, i64 *%b) {
; CHECK-LABEL: test_last_true_d:
; CHECK-DAG: ldr [[IN0:x[0-9]+]], [x0]
; CHECK-DAG: ldr [[IN1:x[0-9]+]], [x1]
; CHECK: cmp [[IN0]], [[IN1]]
; CHECK: cset [[RES:w[0-9]+]], gt
; CHECK: ret
  %in0 = load i64 , i64 *%a
  %in1 = load i64 , i64 *%b
  %cmp = icmp sgt i64 %in0, %in1
  %cond = test last true i1 %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}
