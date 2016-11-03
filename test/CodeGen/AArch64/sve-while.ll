; RUN: llc -O3 -mtriple=aarch64--linux-gnu -mattr=+sve -aarch64-sve-postvec < %s | FileCheck %s

define void @while_ult_b(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_b:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.b, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 16 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 16 x i64> %0, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %1 = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  br label %for.body

for.body:
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 16 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]

  %index.next = add nuw i64 %index, elementcount (<n x 16 x i8> undef)
  %index.wide = seriesvector i64 %index.next, 1 as <n x 16 x i64>
  %cmp = icmp ult <n x 16 x i64> %index.wide, %end.wide
  %pred.next = propff <n x 16 x i1> %predicate, %cmp
  %cond = test first true <n x 16 x i1> %pred.next
  br i1 %cond, label %for.body, label %for.end

for.end:
  ret void
}

define void @while_ult_h(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_h:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.h, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 8 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 8 x i64> %0, <n x 8 x i64> undef, <n x 8 x i32> zeroinitializer
  %1 = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 8 x i1> %1, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer
  br label %for.body

for.body:
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 8 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]

  %index.next = add nuw i64 %index, elementcount (<n x 8 x i16> undef)
  %index.wide = seriesvector i64 %index.next, 1 as <n x 8 x i64>
  %cmp = icmp ult <n x 8 x i64> %index.wide, %end.wide
  %pred.next = propff <n x 8 x i1> %predicate, %cmp
  %cond = test first true <n x 8 x i1> %pred.next
  br i1 %cond, label %for.body, label %for.end

for.end:
  ret void
}

define void @while_ult_s(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_s:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.s, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 4 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 4 x i64> %0, <n x 4 x i64> undef, <n x 4 x i32> zeroinitializer
  %1 = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 4 x i1> %1, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer
  br label %for.body

for.body:
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 4 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]

  %index.next = add nuw i64 %index, elementcount (<n x 4 x i32> undef)
  %index.wide = seriesvector i64 %index.next, 1 as <n x 4 x i64>
  %cmp = icmp ult <n x 4 x i64> %index.wide, %end.wide
  %pred.next = propff <n x 4 x i1> %predicate, %cmp
  %cond = test first true <n x 4 x i1> %pred.next
  br i1 %cond, label %for.body, label %for.end

for.end:
  ret void
}

define void @while_ult_d(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_d:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.d, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 2 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 2 x i64> %0, <n x 2 x i64> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  br label %for.body

for.body:
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 2 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]

  %index.next = add nuw i64 %index, elementcount (<n x 2 x i64> undef)
  %index.wide = seriesvector i64 %index.next, 1 as <n x 2 x i64>
  %cmp = icmp ult <n x 2 x i64> %index.wide, %end.wide
  %pred.next = propff <n x 2 x i1> %predicate, %cmp
  %cond = test first true <n x 2 x i1> %pred.next
  br i1 %cond, label %for.body, label %for.end

for.end:
  ret void
}

; As above but with 32bit scalars.
define void @while4_ult_d(i32 %start, i32 %end) {
; CHECK-LABEL: while4_ult_d:
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.d, w{{[0-9]+}}, w1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 2 x i32> undef, i32 %end, i32 0
  %end.wide = shufflevector <n x 2 x i32> %0, <n x 2 x i32> undef, <n x 2 x i32> zeroinitializer
  %1 = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 2 x i1> %1, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer
  br label %for.body

for.body:
  %index = phi i32 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 2 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]

  %index.next = add nuw i32 %index, elementcount (<n x 2 x i64> undef)
  %index.wide = seriesvector i32 %index.next, 1 as <n x 2 x i32>
  %cmp = icmp ult <n x 2 x i32> %index.wide, %end.wide
  %pred.next = propff <n x 2 x i1> %predicate, %cmp
  %cond = test first true <n x 2 x i1> %pred.next
  br i1 %cond, label %for.body, label %for.end

for.end:
  ret void
}


; As while_lt_b but check that we still use WHILE when the first operand of a
; propff contains more than just ptrue and itself.
define i1 @while_ult_b_complex(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_b_complex:
; CHECK: whilelo {{p[0-9]+}}.b, x{{[0-9]+}}, x1
; CHECK-NOT: cmp
; CHECK-NOT: brk
; CHECK: whilelo {{p[0-9]+}}.b, x{{[0-9]+}}, x1
; CHECK-NOT: brk
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 16 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 16 x i64> %0, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %1 = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer

  %start.wide = seriesvector i64 %start, 1 as <n x 16 x i64>
  %cmp.first = icmp ult <n x 16 x i64> %start.wide, %end.wide
  %pred.first = propff <n x 16 x i1> %ptrue, %cmp.first
  br label %for.body

for.body:
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 16 x i1> [ %pred.first, %entry ], [ %pred.next, %for.body ]

  ; NOTE: use of predicate to prevent elimination of first WHILE
  %res = extractelement <n x 16 x i1> %predicate, i32 0

  %index.next = add nuw i64 %index, elementcount (<n x 16 x i8> undef)
  %index.wide = seriesvector i64 %index.next, 1 as <n x 16 x i64>
  %cmp.next = icmp ult <n x 16 x i64> %index.wide, %end.wide
  %pred.next = propff <n x 16 x i1> %predicate, %cmp.next
  %cond = test first true <n x 16 x i1> %pred.next
  br i1 %cond, label %for.body, label %for.end

for.end:

  ret i1 %res
}

; As while_lt_b but ensures we still use WHILE when we cannot guarantee the
; calculation of %index.next doesn't wrap.
define void @while_ult_b_wrap(i64 %start, i64 %end) {
; CHECK-LABEL: while_ult_b_wrap:
; CHECK-NOT: not
; CHECK-NOT: brkb
; CHECK: whilelo [[COND:p[0-9]+]].b, x{{[0-9]+}}, x1
; CHECK-NOT: not
; CHECK-NOT: brkb
; CHECK: brkns {{p[0-9]+}}.b, {{p[0-9]+}}/z, {{p[0-9]+}}.b, [[COND]].b
; CHECK-NOT: ptest
; CHECK: ret
entry:
  %0 = insertelement <n x 16 x i64> undef, i64 %end, i32 0
  %end.wide = shufflevector <n x 16 x i64> %0, <n x 16 x i64> undef, <n x 16 x i32> zeroinitializer
  %1 = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %ptrue = shufflevector <n x 16 x i1> %1, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer
  br label %for.body

for.body:
  %index = phi i64 [ %start, %entry ], [ %index.next, %for.body ]
  %predicate = phi <n x 16 x i1> [ %ptrue, %entry ], [ %pred.next, %for.body ]

  %index.next = add i64 %index, elementcount (<n x 16 x i8> undef)
  %index.wide = seriesvector i64 %index.next, 1 as <n x 16 x i64>
  %cmp = icmp ult <n x 16 x i64> %index.wide, %end.wide
  %pred.next = propff <n x 16 x i1> %predicate, %cmp
  %cond = test first true <n x 16 x i1> %pred.next
  br i1 %cond, label %for.body, label %for.end

for.end:
  ret void
}
