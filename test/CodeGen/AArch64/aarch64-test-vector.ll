; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

define i32 @test_all_false_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_all_false_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test all false <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_false_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_all_false_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test all false <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_false_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_all_false_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test all false <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_false_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_all_false_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test all false <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_all_true_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test all true <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_all_true_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test all true <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_all_true_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test all true <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_all_true_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_all_true_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], eq
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test all true <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_any_false_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test any false <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_any_false_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test any false <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_any_false_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test any false <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_false_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_any_false_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: nor [[INV:p[0-9]+]].b, [[PG]]/z, [[PCMP:p[0-9]+]].b, [[PCMP]].b
; CHECK: ptest [[PG]], [[INV:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test any false <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_any_true_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test any true <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_any_true_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test any true <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_any_true_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test any true <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_any_true_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_any_true_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], ne
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test any true <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_first_false_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], pl
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test first false <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_first_false_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], pl
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test first false <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_first_false_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], pl
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test first false <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_false_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_first_false_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], pl
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test first false <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_first_true_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], mi
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test first true <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_first_true_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], mi
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test first true <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_first_true_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], mi
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test first true <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_first_true_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_first_true_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], mi
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test first true <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_last_false_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], hs
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test last false <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_last_false_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], hs
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test last false <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_last_false_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], hs
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test last false <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_false_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_last_false_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], hs
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test last false <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_b(<n x 16 x i8> *%a, <n x 16 x i8> *%b) {
; CHECK-LABEL: test_last_true_b:
; CHECK: ptrue [[PG:p[0-9]+]].b
; CHECK-DAG: ld1b {[[IN0:z[0-9]+]].b}, [[PG]]/z, [x0
; CHECK-DAG: ld1b {[[IN1:z[0-9]+]].b}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].b, [[PG]]/z, [[IN0]].b, [[IN1]].b
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], lo
; CHECK: ret
  %in0 = load <n x 16 x i8> , <n x 16 x i8> *%a
  %in1 = load <n x 16 x i8> , <n x 16 x i8> *%b
  %cmp = icmp sgt <n x 16 x i8> %in0, %in1
  %cond = test last true <n x 16 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_h(<n x 8 x i16> *%a, <n x 8 x i16> *%b) {
; CHECK-LABEL: test_last_true_h:
; CHECK: ptrue [[PG:p[0-9]+]].h
; CHECK-DAG: ld1h {[[IN0:z[0-9]+]].h}, [[PG]]/z, [x0
; CHECK-DAG: ld1h {[[IN1:z[0-9]+]].h}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].h, [[PG]]/z, [[IN0]].h, [[IN1]].h
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], lo
; CHECK: ret
  %in0 = load <n x 8 x i16> , <n x 8 x i16> *%a
  %in1 = load <n x 8 x i16> , <n x 8 x i16> *%b
  %cmp = icmp sgt <n x 8 x i16> %in0, %in1
  %cond = test last true <n x 8 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_s(<n x 4 x i32> *%a, <n x 4 x i32> *%b) {
; CHECK-LABEL: test_last_true_s:
; CHECK: ptrue [[PG:p[0-9]+]].s
; CHECK-DAG: ld1w {[[IN0:z[0-9]+]].s}, [[PG]]/z, [x0
; CHECK-DAG: ld1w {[[IN1:z[0-9]+]].s}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].s, [[PG]]/z, [[IN0]].s, [[IN1]].s
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], lo
; CHECK: ret
  %in0 = load <n x 4 x i32> , <n x 4 x i32> *%a
  %in1 = load <n x 4 x i32> , <n x 4 x i32> *%b
  %cmp = icmp sgt <n x 4 x i32> %in0, %in1
  %cond = test last true <n x 4 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}

define i32 @test_last_true_d(<n x 2 x i64> *%a, <n x 2 x i64> *%b) {
; CHECK-LABEL: test_last_true_d:
; CHECK: ptrue [[PG:p[0-9]+]].d
; CHECK-DAG: ld1d {[[IN0:z[0-9]+]].d}, [[PG]]/z, [x0
; CHECK-DAG: ld1d {[[IN1:z[0-9]+]].d}, [[PG]]/z, [x1
; CHECK: cmpgt [[PCMP:p[0-9]+]].d, [[PG]]/z, [[IN0]].d, [[IN1]].d
; CHECK: ptest [[PG]], [[PCMP:p[0-9]+]].b
; CHECK: cset [[RES:w[0-9]+]], lo
; CHECK: ret
  %in0 = load <n x 2 x i64> , <n x 2 x i64> *%a
  %in1 = load <n x 2 x i64> , <n x 2 x i64> *%b
  %cmp = icmp sgt <n x 2 x i64> %in0, %in1
  %cond = test last true <n x 2 x i1> %cmp
  %res = zext i1 %cond to i32
  ret i32 %res
}
