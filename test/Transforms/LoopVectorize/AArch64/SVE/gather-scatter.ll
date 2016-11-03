; RUN: opt -mtriple aarch64-linux-generic -mattr=+sve -O3 -loop-vectorize -force-scalable-vectorization -force-vector-predication -enable-non-consecutive-stride-ind-vars -force-vector-width=4 -disable-loop-unrolling -S < %s | FileCheck %s
; ModuleID = 'original-loop.c'
target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnueabi"

;CHECK-LABEL: @func(

;CHECK-LABEL: vector.body
;CHECK-DAG: %[[MUL0:[0-9]+]] = mul nuw i64 %index, 5
;CHECK-DAG: %[[SVC0:[0-9]+]] = seriesvector i64 %[[MUL0]], 5 as <n x 4 x i64>
;CHECK-DAG: %[[GEP0:[0-9]+]] = getelementptr i32, i32* %a, <n x 4 x i64> %[[SVC0]]
;CHECK: call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %[[GEP0]], i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1
;CHECK-DAG: %[[MUL1:[0-9]+]] = mul nuw i64 %index, 5
;CHECK-DAG: %[[SVC1:[0-9]+]] = seriesvector i64 %[[MUL1]], 5 as <n x 4 x i64>
;CHECK-DAG: %[[GEP1:[0-9]+]] = getelementptr i32, i32* %b, <n x 4 x i64> %[[SVC1]]
;CHECK: call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %[[GEP1]], i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1
;CHECK-DAG: %[[MUL2:[0-9]+]] = mul nuw i64 %index, 5
;CHECK-DAG: %[[SVC2:[0-9]+]] = seriesvector i64 %[[MUL2]], 5 as <n x 4 x i64>
;CHECK-DAG: %[[GEP2:[0-9]+]] = getelementptr i32, i32* %d, <n x 4 x i64> %[[SVC2]]
;CHECK-DAG: call void @llvm.masked.scatter.nxv4i32(<n x 4 x i32> %{{[0-9]+}}, <n x 4 x i32*> %[[GEP2]], i32 4, <n x 4 x i1> %predicate), !tbaa !1
;CHECK: br i1

; Function Attrs: nounwind
define void @func(i32* noalias nocapture %d, i32* noalias nocapture readonly %a, i32* noalias nocapture readonly %b, i32 %count) #0 {
entry:
  %cmp10 = icmp sgt i32 %count, 0
  br i1 %cmp10, label %for.body.lr.ph, label %for.end

for.body.lr.ph:                                   ; preds = %entry
  %0 = sext i32 %count to i64
  %1 = add nsw i64 %0, -1
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %i.011 = phi i64 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %mul = mul nsw i64 %i.011, 5
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %mul
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !1
  %arrayidx3 = getelementptr inbounds i32, i32* %b, i64 %mul
  %3 = load i32, i32* %arrayidx3, align 4, !tbaa !1
  %add = add nsw i32 %3, %2
  %arrayidx5 = getelementptr inbounds i32, i32* %d, i64 %mul
  store i32 %add, i32* %arrayidx5, align 4, !tbaa !1
  %inc = add nuw nsw i64 %i.011, 1
  %exitcond = icmp eq i64 %i.011, %1
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  ret void
}


;; Multi-offset GEP + gather load check

%struct.nested_i32 = type { %union.anon_i32, %union.anon_i32.0 }
%union.anon_i32 = type { i32 }
%union.anon_i32.0 = type { i32 }

@data_i32 = common global [1024 x %struct.nested_i32] zeroinitializer, align 4

; Function Attrs: nounwind readonly
define i32 @gep_array_of_struct_of_unions_of_int() #1 {
; CHECK-LABEL: gep_array_of_struct_of_unions_of_int
; CHECK-LABEL: vector.body
; CHECK: %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
; CHECK: %predicate = phi <n x 4 x i1> [ %predicate.entry, %entry ], [ %predicate.next, %vector.body ]
; CHECK: %vec.phi = phi <n x 4 x i32> [ zeroinitializer, %entry ], [ %[[ACC:[0-9]+]], %vector.body ]
; CHECK-DAG: %[[IDX:[0-9]+]] = trunc i64 %index to i32
; CHECK-DAG: %[[IDX1:[0-9]+]] = shl nuw nsw i32 %[[IDX]], 1
; CHECK-DAG: %[[IDX2:[0-9]+]] = seriesvector i32 %[[IDX1]], 2 as <n x 4 x i32>
; CHECK-DAG: %[[PTR:[0-9]+]] = getelementptr i32, i32* getelementptr inbounds ([1024 x %struct.nested_i32], [1024 x %struct.nested_i32]* @data_i32, i64 0, i64 0, i32 0, i32 0), <n x 4 x i32> %[[IDX2]]
; CHECK-DAG: %wide.masked.gather = call <n x 4 x i32> @llvm.masked.gather.nxv4i32(<n x 4 x i32*> %[[PTR]], i32 4, <n x 4 x i1> %predicate, <n x 4 x i32> undef), !tbaa !1
; CHECK-DAG: %[[SEL:[0-9]+]] = select <n x 4 x i1> %predicate, <n x 4 x i32> %wide.masked.gather, <n x 4 x i32> zeroinitializer
; CHECK-DAG: %[[ACC]] = add nsw <n x 4 x i32> %vec.phi, %5
; CHECK: %index.next = add nuw nsw i64 %index, elementcount (<n x 4 x i64> undef)
; CHECK: br i1 %{{[0-9]+}}, label %vector.body, label %middle.block
entry:
  br label %while.body

while.body:                                       ; preds = %while.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %while.body ]
  %result.04 = phi i32 [ 0, %entry ], [ %add, %while.body ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %a = getelementptr inbounds [1024 x %struct.nested_i32], [1024 x %struct.nested_i32]* @data_i32, i64 0, i64 %indvars.iv, i32 0, i32 0
  %0 = load i32, i32* %a, align 4, !tbaa !1
  %add = add nsw i32 %0, %result.04
  %exitcond = icmp eq i64 %indvars.iv.next, 128
  br i1 %exitcond, label %while.end, label %while.body

while.end:                                        ; preds = %while.body
  %add.lcssa = phi i32 [ %add, %while.body ]

  ret i32 %add.lcssa
}


attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.0"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
