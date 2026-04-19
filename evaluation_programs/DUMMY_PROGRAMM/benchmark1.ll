; ModuleID = './benchmark1.cpp'
source_filename = "./benchmark1.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

module asm ".globl _ZSt21ios_base_library_initv"

%"class.std::basic_ostream" = type { ptr, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
%"class.std::ios_base" = type { ptr, i64, i64, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"class.std::locale" }
%"struct.std::ios_base::_Words" = type { ptr, i64 }
%"class.std::locale" = type { ptr }

@g_seed = dso_local global i32 13, align 4, !dbg !0
@g_sink = dso_local global i32 0, align 4, !dbg !5
@_ZSt4cout = external global %"class.std::basic_ostream", align 8

; Function Attrs: mustprogress noinline uwtable
define dso_local noundef i32 @_Z18benchmark_functioni(i32 noundef %input) #0 !dbg !872 {
entry:
  %input.addr = alloca i32, align 4
  %acc = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %input, ptr %input.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %input.addr, metadata !874, metadata !DIExpression()), !dbg !875
  call void @llvm.dbg.declare(metadata ptr %acc, metadata !876, metadata !DIExpression()), !dbg !877
  %0 = load i32, ptr %input.addr, align 4, !dbg !878
  store i32 %0, ptr %acc, align 4, !dbg !877
  %1 = load i32, ptr %acc, align 4, !dbg !879
  %call = call noundef i32 @_ZL6opaqueii(i32 noundef %1, i32 noundef 1), !dbg !881
  %and = and i32 %call, 1, !dbg !882
  %cmp = icmp eq i32 %and, 0, !dbg !883
  br i1 %cmp, label %if.then, label %if.else, !dbg !884

if.then:                                          ; preds = %entry
  %2 = load i32, ptr %acc, align 4, !dbg !885
  %add = add nsw i32 %2, 11, !dbg !885
  store i32 %add, ptr %acc, align 4, !dbg !885
  br label %if.end, !dbg !887

if.else:                                          ; preds = %entry
  %3 = load i32, ptr %acc, align 4, !dbg !888
  %add1 = add nsw i32 %3, 3, !dbg !888
  store i32 %add1, ptr %acc, align 4, !dbg !888
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %4 = load i32, ptr %acc, align 4, !dbg !890
  %call2 = call noundef i32 @_ZL6opaqueii(i32 noundef %4, i32 noundef 2), !dbg !892
  %and3 = and i32 %call2, 2, !dbg !893
  %cmp4 = icmp eq i32 %and3, 0, !dbg !894
  br i1 %cmp4, label %if.then5, label %if.else7, !dbg !895

if.then5:                                         ; preds = %if.end
  %5 = load i32, ptr %acc, align 4, !dbg !896
  %add6 = add nsw i32 %5, 17, !dbg !896
  store i32 %add6, ptr %acc, align 4, !dbg !896
  br label %if.end10, !dbg !898

if.else7:                                         ; preds = %if.end
  %6 = load i32, ptr %acc, align 4, !dbg !899
  %call8 = call noundef i32 @_ZL8doubleIti(i32 noundef %6), !dbg !901
  %7 = load i32, ptr %acc, align 4, !dbg !902
  %add9 = add nsw i32 %7, %call8, !dbg !902
  store i32 %add9, ptr %acc, align 4, !dbg !902
  br label %if.end10

if.end10:                                         ; preds = %if.else7, %if.then5
  %8 = load i32, ptr %acc, align 4, !dbg !903
  %call11 = call noundef i32 @_ZL6opaqueii(i32 noundef %8, i32 noundef 3), !dbg !905
  %rem = srem i32 %call11, 3, !dbg !906
  %cmp12 = icmp eq i32 %rem, 0, !dbg !907
  br i1 %cmp12, label %if.then13, label %if.else15, !dbg !908

if.then13:                                        ; preds = %if.end10
  %9 = load i32, ptr %acc, align 4, !dbg !909
  %add14 = add nsw i32 %9, 13, !dbg !909
  store i32 %add14, ptr %acc, align 4, !dbg !909
  br label %if.end18, !dbg !911

if.else15:                                        ; preds = %if.end10
  %10 = load i32, ptr %acc, align 4, !dbg !912
  %call16 = call noundef i32 @_ZL8doubleIti(i32 noundef %10), !dbg !914
  %11 = load i32, ptr %acc, align 4, !dbg !915
  %add17 = add nsw i32 %11, %call16, !dbg !915
  store i32 %add17, ptr %acc, align 4, !dbg !915
  br label %if.end18

if.end18:                                         ; preds = %if.else15, %if.then13
  %12 = load i32, ptr %acc, align 4, !dbg !916
  %call19 = call noundef i32 @_ZL6opaqueii(i32 noundef %12, i32 noundef 4), !dbg !918
  %rem20 = srem i32 %call19, 5, !dbg !919
  %cmp21 = icmp slt i32 %rem20, 2, !dbg !920
  br i1 %cmp21, label %if.then22, label %if.else24, !dbg !921

if.then22:                                        ; preds = %if.end18
  %13 = load i32, ptr %acc, align 4, !dbg !922
  %add23 = add nsw i32 %13, 19, !dbg !922
  store i32 %add23, ptr %acc, align 4, !dbg !922
  br label %if.end27, !dbg !924

if.else24:                                        ; preds = %if.end18
  %14 = load i32, ptr %acc, align 4, !dbg !925
  %call25 = call noundef i32 @_ZL8doubleIti(i32 noundef %14), !dbg !927
  %15 = load i32, ptr %acc, align 4, !dbg !928
  %add26 = add nsw i32 %15, %call25, !dbg !928
  store i32 %add26, ptr %acc, align 4, !dbg !928
  br label %if.end27

if.end27:                                         ; preds = %if.else24, %if.then22
  %16 = load i32, ptr %acc, align 4, !dbg !929
  %call28 = call noundef i32 @_ZL6opaqueii(i32 noundef %16, i32 noundef 5), !dbg !931
  %and29 = and i32 %call28, 4, !dbg !932
  %cmp30 = icmp ne i32 %and29, 0, !dbg !933
  br i1 %cmp30, label %if.then31, label %if.else33, !dbg !934

if.then31:                                        ; preds = %if.end27
  %17 = load i32, ptr %acc, align 4, !dbg !935
  %add32 = add nsw i32 %17, 23, !dbg !935
  store i32 %add32, ptr %acc, align 4, !dbg !935
  br label %if.end36, !dbg !937

if.else33:                                        ; preds = %if.end27
  %18 = load i32, ptr %acc, align 4, !dbg !938
  %call34 = call noundef i32 @_ZL8doubleIti(i32 noundef %18), !dbg !940
  %19 = load i32, ptr %acc, align 4, !dbg !941
  %add35 = add nsw i32 %19, %call34, !dbg !941
  store i32 %add35, ptr %acc, align 4, !dbg !941
  br label %if.end36

if.end36:                                         ; preds = %if.else33, %if.then31
  %20 = load i32, ptr %acc, align 4, !dbg !942
  %call37 = call noundef i32 @_ZL6opaqueii(i32 noundef %20, i32 noundef 6), !dbg !944
  %rem38 = srem i32 %call37, 7, !dbg !945
  %cmp39 = icmp eq i32 %rem38, 0, !dbg !946
  br i1 %cmp39, label %if.then40, label %if.else42, !dbg !947

if.then40:                                        ; preds = %if.end36
  %21 = load i32, ptr %acc, align 4, !dbg !948
  %add41 = add nsw i32 %21, 29, !dbg !948
  store i32 %add41, ptr %acc, align 4, !dbg !948
  br label %if.end45, !dbg !950

if.else42:                                        ; preds = %if.end36
  %22 = load i32, ptr %acc, align 4, !dbg !951
  %call43 = call noundef i32 @_ZL8doubleIti(i32 noundef %22), !dbg !953
  %23 = load i32, ptr %acc, align 4, !dbg !954
  %add44 = add nsw i32 %23, %call43, !dbg !954
  store i32 %add44, ptr %acc, align 4, !dbg !954
  br label %if.end45

if.end45:                                         ; preds = %if.else42, %if.then40
  %24 = load i32, ptr %acc, align 4, !dbg !955
  %call46 = call noundef i32 @_ZL6opaqueii(i32 noundef %24, i32 noundef 7), !dbg !957
  %and47 = and i32 %call46, 8, !dbg !958
  %cmp48 = icmp ne i32 %and47, 0, !dbg !959
  br i1 %cmp48, label %if.then49, label %if.else51, !dbg !960

if.then49:                                        ; preds = %if.end45
  %25 = load i32, ptr %acc, align 4, !dbg !961
  %add50 = add nsw i32 %25, 31, !dbg !961
  store i32 %add50, ptr %acc, align 4, !dbg !961
  br label %if.end54, !dbg !963

if.else51:                                        ; preds = %if.end45
  %26 = load i32, ptr %acc, align 4, !dbg !964
  %call52 = call noundef i32 @_ZL8doubleIti(i32 noundef %26), !dbg !966
  %27 = load i32, ptr %acc, align 4, !dbg !967
  %add53 = add nsw i32 %27, %call52, !dbg !967
  store i32 %add53, ptr %acc, align 4, !dbg !967
  br label %if.end54

if.end54:                                         ; preds = %if.else51, %if.then49
  %28 = load i32, ptr %acc, align 4, !dbg !968
  %call55 = call noundef i32 @_ZL6opaqueii(i32 noundef %28, i32 noundef 8), !dbg !970
  %rem56 = srem i32 %call55, 4, !dbg !971
  %cmp57 = icmp eq i32 %rem56, 1, !dbg !972
  br i1 %cmp57, label %if.then58, label %if.else60, !dbg !973

if.then58:                                        ; preds = %if.end54
  %29 = load i32, ptr %acc, align 4, !dbg !974
  %add59 = add nsw i32 %29, 37, !dbg !974
  store i32 %add59, ptr %acc, align 4, !dbg !974
  br label %if.end63, !dbg !976

if.else60:                                        ; preds = %if.end54
  %30 = load i32, ptr %acc, align 4, !dbg !977
  %call61 = call noundef i32 @_ZL8doubleIti(i32 noundef %30), !dbg !979
  %31 = load i32, ptr %acc, align 4, !dbg !980
  %add62 = add nsw i32 %31, %call61, !dbg !980
  store i32 %add62, ptr %acc, align 4, !dbg !980
  br label %if.end63

if.end63:                                         ; preds = %if.else60, %if.then58
  %32 = load i32, ptr %acc, align 4, !dbg !981
  %call64 = call noundef i32 @_ZL6opaqueii(i32 noundef %32, i32 noundef 9), !dbg !983
  %rem65 = srem i32 %call64, 6, !dbg !984
  %cmp66 = icmp slt i32 %rem65, 3, !dbg !985
  br i1 %cmp66, label %if.then67, label %if.else69, !dbg !986

if.then67:                                        ; preds = %if.end63
  %33 = load i32, ptr %acc, align 4, !dbg !987
  %add68 = add nsw i32 %33, 41, !dbg !987
  store i32 %add68, ptr %acc, align 4, !dbg !987
  br label %if.end72, !dbg !989

if.else69:                                        ; preds = %if.end63
  %34 = load i32, ptr %acc, align 4, !dbg !990
  %call70 = call noundef i32 @_ZL8doubleIti(i32 noundef %34), !dbg !992
  %35 = load i32, ptr %acc, align 4, !dbg !993
  %add71 = add nsw i32 %35, %call70, !dbg !993
  store i32 %add71, ptr %acc, align 4, !dbg !993
  br label %if.end72

if.end72:                                         ; preds = %if.else69, %if.then67
  %36 = load i32, ptr %acc, align 4, !dbg !994
  %call73 = call noundef i32 @_ZL6opaqueii(i32 noundef %36, i32 noundef 10), !dbg !996
  %and74 = and i32 %call73, 16, !dbg !997
  %cmp75 = icmp ne i32 %and74, 0, !dbg !998
  br i1 %cmp75, label %if.then76, label %if.else78, !dbg !999

if.then76:                                        ; preds = %if.end72
  %37 = load i32, ptr %acc, align 4, !dbg !1000
  %add77 = add nsw i32 %37, 43, !dbg !1000
  store i32 %add77, ptr %acc, align 4, !dbg !1000
  br label %if.end81, !dbg !1002

if.else78:                                        ; preds = %if.end72
  %38 = load i32, ptr %acc, align 4, !dbg !1003
  %call79 = call noundef i32 @_ZL8doubleIti(i32 noundef %38), !dbg !1005
  %39 = load i32, ptr %acc, align 4, !dbg !1006
  %add80 = add nsw i32 %39, %call79, !dbg !1006
  store i32 %add80, ptr %acc, align 4, !dbg !1006
  br label %if.end81

if.end81:                                         ; preds = %if.else78, %if.then76
  call void @llvm.dbg.declare(metadata ptr %i, metadata !1007, metadata !DIExpression()), !dbg !1009
  store i32 0, ptr %i, align 4, !dbg !1009
  br label %for.cond, !dbg !1010

for.cond:                                         ; preds = %for.inc, %if.end81
  %40 = load i32, ptr %i, align 4, !dbg !1011
  %cmp82 = icmp slt i32 %40, 40, !dbg !1013
  br i1 %cmp82, label %for.body, label %for.end, !dbg !1014

for.body:                                         ; preds = %for.cond
  %41 = load i32, ptr %acc, align 4, !dbg !1015
  %42 = load i32, ptr %i, align 4, !dbg !1018
  %add83 = add nsw i32 %41, %42, !dbg !1019
  %call84 = call noundef i32 @_ZL6opaqueii(i32 noundef %add83, i32 noundef 20), !dbg !1020
  %and85 = and i32 %call84, 1, !dbg !1021
  %cmp86 = icmp eq i32 %and85, 0, !dbg !1022
  br i1 %cmp86, label %if.then87, label %if.else89, !dbg !1023

if.then87:                                        ; preds = %for.body
  %43 = load i32, ptr %acc, align 4, !dbg !1024
  %add88 = add nsw i32 %43, 12, !dbg !1024
  store i32 %add88, ptr %acc, align 4, !dbg !1024
  br label %if.end92, !dbg !1026

if.else89:                                        ; preds = %for.body
  %44 = load i32, ptr %acc, align 4, !dbg !1027
  %call90 = call noundef i32 @_ZL8doubleIti(i32 noundef %44), !dbg !1029
  %45 = load i32, ptr %acc, align 4, !dbg !1030
  %add91 = add nsw i32 %45, %call90, !dbg !1030
  store i32 %add91, ptr %acc, align 4, !dbg !1030
  br label %if.end92

if.end92:                                         ; preds = %if.else89, %if.then87
  %46 = load i32, ptr %acc, align 4, !dbg !1031
  %47 = load i32, ptr %i, align 4, !dbg !1033
  %add93 = add nsw i32 %46, %47, !dbg !1034
  %call94 = call noundef i32 @_ZL6opaqueii(i32 noundef %add93, i32 noundef 21), !dbg !1035
  %rem95 = srem i32 %call94, 3, !dbg !1036
  %cmp96 = icmp eq i32 %rem95, 0, !dbg !1037
  br i1 %cmp96, label %if.then97, label %if.else99, !dbg !1038

if.then97:                                        ; preds = %if.end92
  %48 = load i32, ptr %acc, align 4, !dbg !1039
  %add98 = add nsw i32 %48, 15, !dbg !1039
  store i32 %add98, ptr %acc, align 4, !dbg !1039
  br label %if.end102, !dbg !1041

if.else99:                                        ; preds = %if.end92
  %49 = load i32, ptr %acc, align 4, !dbg !1042
  %call100 = call noundef i32 @_ZL8doubleIti(i32 noundef %49), !dbg !1044
  %50 = load i32, ptr %acc, align 4, !dbg !1045
  %add101 = add nsw i32 %50, %call100, !dbg !1045
  store i32 %add101, ptr %acc, align 4, !dbg !1045
  br label %if.end102

if.end102:                                        ; preds = %if.else99, %if.then97
  %51 = load i32, ptr %acc, align 4, !dbg !1046
  %52 = load i32, ptr %i, align 4, !dbg !1048
  %add103 = add nsw i32 %51, %52, !dbg !1049
  %call104 = call noundef i32 @_ZL6opaqueii(i32 noundef %add103, i32 noundef 22), !dbg !1050
  %rem105 = srem i32 %call104, 5, !dbg !1051
  %cmp106 = icmp slt i32 %rem105, 2, !dbg !1052
  br i1 %cmp106, label %if.then107, label %if.else109, !dbg !1053

if.then107:                                       ; preds = %if.end102
  %53 = load i32, ptr %acc, align 4, !dbg !1054
  %add108 = add nsw i32 %53, 18, !dbg !1054
  store i32 %add108, ptr %acc, align 4, !dbg !1054
  br label %if.end112, !dbg !1056

if.else109:                                       ; preds = %if.end102
  %54 = load i32, ptr %acc, align 4, !dbg !1057
  %call110 = call noundef i32 @_ZL8doubleIti(i32 noundef %54), !dbg !1059
  %55 = load i32, ptr %acc, align 4, !dbg !1060
  %add111 = add nsw i32 %55, %call110, !dbg !1060
  store i32 %add111, ptr %acc, align 4, !dbg !1060
  br label %if.end112

if.end112:                                        ; preds = %if.else109, %if.then107
  br label %for.inc, !dbg !1061

for.inc:                                          ; preds = %if.end112
  %56 = load i32, ptr %i, align 4, !dbg !1062
  %inc = add nsw i32 %56, 1, !dbg !1062
  store i32 %inc, ptr %i, align 4, !dbg !1062
  br label %for.cond, !dbg !1063, !llvm.loop !1064

for.end:                                          ; preds = %for.cond
  %57 = load i32, ptr %acc, align 4, !dbg !1067
  %call113 = call noundef i32 @_ZL6opaqueii(i32 noundef %57, i32 noundef 30), !dbg !1069
  %and114 = and i32 %call113, 1, !dbg !1070
  %cmp115 = icmp eq i32 %and114, 0, !dbg !1071
  br i1 %cmp115, label %if.then116, label %if.else118, !dbg !1072

if.then116:                                       ; preds = %for.end
  %58 = load i32, ptr %acc, align 4, !dbg !1073
  %add117 = add nsw i32 %58, 14, !dbg !1073
  store i32 %add117, ptr %acc, align 4, !dbg !1073
  br label %if.end121, !dbg !1075

if.else118:                                       ; preds = %for.end
  %59 = load i32, ptr %acc, align 4, !dbg !1076
  %call119 = call noundef i32 @_ZL8doubleIti(i32 noundef %59), !dbg !1078
  %60 = load i32, ptr %acc, align 4, !dbg !1079
  %add120 = add nsw i32 %60, %call119, !dbg !1079
  store i32 %add120, ptr %acc, align 4, !dbg !1079
  br label %if.end121

if.end121:                                        ; preds = %if.else118, %if.then116
  %61 = load i32, ptr %acc, align 4, !dbg !1080
  %call122 = call noundef i32 @_ZL6opaqueii(i32 noundef %61, i32 noundef 31), !dbg !1082
  %and123 = and i32 %call122, 2, !dbg !1083
  %cmp124 = icmp eq i32 %and123, 0, !dbg !1084
  br i1 %cmp124, label %if.then125, label %if.else127, !dbg !1085

if.then125:                                       ; preds = %if.end121
  %62 = load i32, ptr %acc, align 4, !dbg !1086
  %add126 = add nsw i32 %62, 16, !dbg !1086
  store i32 %add126, ptr %acc, align 4, !dbg !1086
  br label %if.end130, !dbg !1088

if.else127:                                       ; preds = %if.end121
  %63 = load i32, ptr %acc, align 4, !dbg !1089
  %call128 = call noundef i32 @_ZL8doubleIti(i32 noundef %63), !dbg !1091
  %64 = load i32, ptr %acc, align 4, !dbg !1092
  %add129 = add nsw i32 %64, %call128, !dbg !1092
  store i32 %add129, ptr %acc, align 4, !dbg !1092
  br label %if.end130

if.end130:                                        ; preds = %if.else127, %if.then125
  %65 = load i32, ptr %acc, align 4, !dbg !1093
  %call131 = call noundef i32 @_ZL6opaqueii(i32 noundef %65, i32 noundef 32), !dbg !1095
  %rem132 = srem i32 %call131, 3, !dbg !1096
  %cmp133 = icmp eq i32 %rem132, 1, !dbg !1097
  br i1 %cmp133, label %if.then134, label %if.else136, !dbg !1098

if.then134:                                       ; preds = %if.end130
  %66 = load i32, ptr %acc, align 4, !dbg !1099
  %add135 = add nsw i32 %66, 21, !dbg !1099
  store i32 %add135, ptr %acc, align 4, !dbg !1099
  br label %if.end139, !dbg !1101

if.else136:                                       ; preds = %if.end130
  %67 = load i32, ptr %acc, align 4, !dbg !1102
  %call137 = call noundef i32 @_ZL8doubleIti(i32 noundef %67), !dbg !1104
  %68 = load i32, ptr %acc, align 4, !dbg !1105
  %add138 = add nsw i32 %68, %call137, !dbg !1105
  store i32 %add138, ptr %acc, align 4, !dbg !1105
  br label %if.end139

if.end139:                                        ; preds = %if.else136, %if.then134
  %69 = load i32, ptr %acc, align 4, !dbg !1106
  %call140 = call noundef i32 @_ZL6opaqueii(i32 noundef %69, i32 noundef 33), !dbg !1108
  %rem141 = srem i32 %call140, 5, !dbg !1109
  %cmp142 = icmp eq i32 %rem141, 2, !dbg !1110
  br i1 %cmp142, label %if.then143, label %if.else145, !dbg !1111

if.then143:                                       ; preds = %if.end139
  %70 = load i32, ptr %acc, align 4, !dbg !1112
  %add144 = add nsw i32 %70, 24, !dbg !1112
  store i32 %add144, ptr %acc, align 4, !dbg !1112
  br label %if.end148, !dbg !1114

if.else145:                                       ; preds = %if.end139
  %71 = load i32, ptr %acc, align 4, !dbg !1115
  %call146 = call noundef i32 @_ZL8doubleIti(i32 noundef %71), !dbg !1117
  %72 = load i32, ptr %acc, align 4, !dbg !1118
  %add147 = add nsw i32 %72, %call146, !dbg !1118
  store i32 %add147, ptr %acc, align 4, !dbg !1118
  br label %if.end148

if.end148:                                        ; preds = %if.else145, %if.then143
  %73 = load i32, ptr %acc, align 4, !dbg !1119
  %call149 = call noundef i32 @_ZL6opaqueii(i32 noundef %73, i32 noundef 34), !dbg !1121
  %and150 = and i32 %call149, 4, !dbg !1122
  %cmp151 = icmp ne i32 %and150, 0, !dbg !1123
  br i1 %cmp151, label %if.then152, label %if.else154, !dbg !1124

if.then152:                                       ; preds = %if.end148
  %74 = load i32, ptr %acc, align 4, !dbg !1125
  %add153 = add nsw i32 %74, 27, !dbg !1125
  store i32 %add153, ptr %acc, align 4, !dbg !1125
  br label %if.end157, !dbg !1127

if.else154:                                       ; preds = %if.end148
  %75 = load i32, ptr %acc, align 4, !dbg !1128
  %call155 = call noundef i32 @_ZL8doubleIti(i32 noundef %75), !dbg !1130
  %76 = load i32, ptr %acc, align 4, !dbg !1131
  %add156 = add nsw i32 %76, %call155, !dbg !1131
  store i32 %add156, ptr %acc, align 4, !dbg !1131
  br label %if.end157

if.end157:                                        ; preds = %if.else154, %if.then152
  %77 = load i32, ptr %acc, align 4, !dbg !1132
  %call158 = call noundef i32 @_ZL6opaqueii(i32 noundef %77, i32 noundef 35), !dbg !1134
  %rem159 = srem i32 %call158, 7, !dbg !1135
  %cmp160 = icmp slt i32 %rem159, 3, !dbg !1136
  br i1 %cmp160, label %if.then161, label %if.else163, !dbg !1137

if.then161:                                       ; preds = %if.end157
  %78 = load i32, ptr %acc, align 4, !dbg !1138
  %add162 = add nsw i32 %78, 30, !dbg !1138
  store i32 %add162, ptr %acc, align 4, !dbg !1138
  br label %if.end166, !dbg !1140

if.else163:                                       ; preds = %if.end157
  %79 = load i32, ptr %acc, align 4, !dbg !1141
  %call164 = call noundef i32 @_ZL8doubleIti(i32 noundef %79), !dbg !1143
  %80 = load i32, ptr %acc, align 4, !dbg !1144
  %add165 = add nsw i32 %80, %call164, !dbg !1144
  store i32 %add165, ptr %acc, align 4, !dbg !1144
  br label %if.end166

if.end166:                                        ; preds = %if.else163, %if.then161
  %81 = load i32, ptr %acc, align 4, !dbg !1145
  %call167 = call noundef i32 @_ZL6opaqueii(i32 noundef %81, i32 noundef 36), !dbg !1147
  %and168 = and i32 %call167, 8, !dbg !1148
  %cmp169 = icmp ne i32 %and168, 0, !dbg !1149
  br i1 %cmp169, label %if.then170, label %if.else172, !dbg !1150

if.then170:                                       ; preds = %if.end166
  %82 = load i32, ptr %acc, align 4, !dbg !1151
  %add171 = add nsw i32 %82, 33, !dbg !1151
  store i32 %add171, ptr %acc, align 4, !dbg !1151
  br label %if.end175, !dbg !1153

if.else172:                                       ; preds = %if.end166
  %83 = load i32, ptr %acc, align 4, !dbg !1154
  %call173 = call noundef i32 @_ZL8doubleIti(i32 noundef %83), !dbg !1156
  %84 = load i32, ptr %acc, align 4, !dbg !1157
  %add174 = add nsw i32 %84, %call173, !dbg !1157
  store i32 %add174, ptr %acc, align 4, !dbg !1157
  br label %if.end175

if.end175:                                        ; preds = %if.else172, %if.then170
  %85 = load i32, ptr %acc, align 4, !dbg !1158
  %call176 = call noundef i32 @_ZL6opaqueii(i32 noundef %85, i32 noundef 37), !dbg !1160
  %rem177 = srem i32 %call176, 4, !dbg !1161
  %cmp178 = icmp eq i32 %rem177, 0, !dbg !1162
  br i1 %cmp178, label %if.then179, label %if.else181, !dbg !1163

if.then179:                                       ; preds = %if.end175
  %86 = load i32, ptr %acc, align 4, !dbg !1164
  %add180 = add nsw i32 %86, 36, !dbg !1164
  store i32 %add180, ptr %acc, align 4, !dbg !1164
  br label %if.end184, !dbg !1166

if.else181:                                       ; preds = %if.end175
  %87 = load i32, ptr %acc, align 4, !dbg !1167
  %call182 = call noundef i32 @_ZL8doubleIti(i32 noundef %87), !dbg !1169
  %88 = load i32, ptr %acc, align 4, !dbg !1170
  %add183 = add nsw i32 %88, %call182, !dbg !1170
  store i32 %add183, ptr %acc, align 4, !dbg !1170
  br label %if.end184

if.end184:                                        ; preds = %if.else181, %if.then179
  %89 = load i32, ptr %acc, align 4, !dbg !1171
  %call185 = call noundef i32 @_ZL6opaqueii(i32 noundef %89, i32 noundef 38), !dbg !1173
  %rem186 = srem i32 %call185, 6, !dbg !1174
  %cmp187 = icmp eq i32 %rem186, 5, !dbg !1175
  br i1 %cmp187, label %if.then188, label %if.else190, !dbg !1176

if.then188:                                       ; preds = %if.end184
  %90 = load i32, ptr %acc, align 4, !dbg !1177
  %add189 = add nsw i32 %90, 39, !dbg !1177
  store i32 %add189, ptr %acc, align 4, !dbg !1177
  br label %if.end193, !dbg !1179

if.else190:                                       ; preds = %if.end184
  %91 = load i32, ptr %acc, align 4, !dbg !1180
  %call191 = call noundef i32 @_ZL8doubleIti(i32 noundef %91), !dbg !1182
  %92 = load i32, ptr %acc, align 4, !dbg !1183
  %add192 = add nsw i32 %92, %call191, !dbg !1183
  store i32 %add192, ptr %acc, align 4, !dbg !1183
  br label %if.end193

if.end193:                                        ; preds = %if.else190, %if.then188
  %93 = load i32, ptr %acc, align 4, !dbg !1184
  %call194 = call noundef i32 @_ZL6opaqueii(i32 noundef %93, i32 noundef 39), !dbg !1186
  %and195 = and i32 %call194, 16, !dbg !1187
  %cmp196 = icmp ne i32 %and195, 0, !dbg !1188
  br i1 %cmp196, label %if.then197, label %if.else199, !dbg !1189

if.then197:                                       ; preds = %if.end193
  %94 = load i32, ptr %acc, align 4, !dbg !1190
  %add198 = add nsw i32 %94, 42, !dbg !1190
  store i32 %add198, ptr %acc, align 4, !dbg !1190
  br label %if.end202, !dbg !1192

if.else199:                                       ; preds = %if.end193
  %95 = load i32, ptr %acc, align 4, !dbg !1193
  %call200 = call noundef i32 @_ZL8doubleIti(i32 noundef %95), !dbg !1195
  %96 = load i32, ptr %acc, align 4, !dbg !1196
  %add201 = add nsw i32 %96, %call200, !dbg !1196
  store i32 %add201, ptr %acc, align 4, !dbg !1196
  br label %if.end202

if.end202:                                        ; preds = %if.else199, %if.then197
  %97 = load i32, ptr %acc, align 4, !dbg !1197
  %call203 = call noundef i32 @_ZL6opaqueii(i32 noundef %97, i32 noundef 40), !dbg !1199
  %rem204 = srem i32 %call203, 9, !dbg !1200
  %cmp205 = icmp slt i32 %rem204, 4, !dbg !1201
  br i1 %cmp205, label %if.then206, label %if.else208, !dbg !1202

if.then206:                                       ; preds = %if.end202
  %98 = load i32, ptr %acc, align 4, !dbg !1203
  %add207 = add nsw i32 %98, 45, !dbg !1203
  store i32 %add207, ptr %acc, align 4, !dbg !1203
  br label %if.end211, !dbg !1205

if.else208:                                       ; preds = %if.end202
  %99 = load i32, ptr %acc, align 4, !dbg !1206
  %call209 = call noundef i32 @_ZL8doubleIti(i32 noundef %99), !dbg !1208
  %100 = load i32, ptr %acc, align 4, !dbg !1209
  %add210 = add nsw i32 %100, %call209, !dbg !1209
  store i32 %add210, ptr %acc, align 4, !dbg !1209
  br label %if.end211

if.end211:                                        ; preds = %if.else208, %if.then206
  %101 = load i32, ptr %acc, align 4, !dbg !1210
  %call212 = call noundef i32 @_ZL6opaqueii(i32 noundef %101, i32 noundef 41), !dbg !1212
  %and213 = and i32 %call212, 32, !dbg !1213
  %cmp214 = icmp ne i32 %and213, 0, !dbg !1214
  br i1 %cmp214, label %if.then215, label %if.else217, !dbg !1215

if.then215:                                       ; preds = %if.end211
  %102 = load i32, ptr %acc, align 4, !dbg !1216
  %add216 = add nsw i32 %102, 48, !dbg !1216
  store i32 %add216, ptr %acc, align 4, !dbg !1216
  br label %if.end220, !dbg !1218

if.else217:                                       ; preds = %if.end211
  %103 = load i32, ptr %acc, align 4, !dbg !1219
  %call218 = call noundef i32 @_ZL8doubleIti(i32 noundef %103), !dbg !1221
  %104 = load i32, ptr %acc, align 4, !dbg !1222
  %add219 = add nsw i32 %104, %call218, !dbg !1222
  store i32 %add219, ptr %acc, align 4, !dbg !1222
  br label %if.end220

if.end220:                                        ; preds = %if.else217, %if.then215
  call void @llvm.dbg.declare(metadata ptr %j, metadata !1223, metadata !DIExpression()), !dbg !1225
  store i32 0, ptr %j, align 4, !dbg !1225
  br label %for.cond221, !dbg !1226

for.cond221:                                      ; preds = %for.inc244, %if.end220
  %105 = load i32, ptr %j, align 4, !dbg !1227
  %cmp222 = icmp slt i32 %105, 35, !dbg !1229
  br i1 %cmp222, label %for.body223, label %for.end246, !dbg !1230

for.body223:                                      ; preds = %for.cond221
  %106 = load i32, ptr %acc, align 4, !dbg !1231
  %107 = load i32, ptr %j, align 4, !dbg !1234
  %add224 = add nsw i32 %106, %107, !dbg !1235
  %call225 = call noundef i32 @_ZL6opaqueii(i32 noundef %add224, i32 noundef 50), !dbg !1236
  %rem226 = srem i32 %call225, 4, !dbg !1237
  %cmp227 = icmp eq i32 %rem226, 0, !dbg !1238
  br i1 %cmp227, label %if.then228, label %if.else230, !dbg !1239

if.then228:                                       ; preds = %for.body223
  %108 = load i32, ptr %acc, align 4, !dbg !1240
  %add229 = add nsw i32 %108, 20, !dbg !1240
  store i32 %add229, ptr %acc, align 4, !dbg !1240
  br label %if.end233, !dbg !1242

if.else230:                                       ; preds = %for.body223
  %109 = load i32, ptr %acc, align 4, !dbg !1243
  %call231 = call noundef i32 @_ZL8doubleIti(i32 noundef %109), !dbg !1245
  %110 = load i32, ptr %acc, align 4, !dbg !1246
  %add232 = add nsw i32 %110, %call231, !dbg !1246
  store i32 %add232, ptr %acc, align 4, !dbg !1246
  br label %if.end233

if.end233:                                        ; preds = %if.else230, %if.then228
  %111 = load i32, ptr %acc, align 4, !dbg !1247
  %112 = load i32, ptr %j, align 4, !dbg !1249
  %add234 = add nsw i32 %111, %112, !dbg !1250
  %call235 = call noundef i32 @_ZL6opaqueii(i32 noundef %add234, i32 noundef 51), !dbg !1251
  %and236 = and i32 %call235, 2, !dbg !1252
  %cmp237 = icmp ne i32 %and236, 0, !dbg !1253
  br i1 %cmp237, label %if.then238, label %if.else240, !dbg !1254

if.then238:                                       ; preds = %if.end233
  %113 = load i32, ptr %acc, align 4, !dbg !1255
  %add239 = add nsw i32 %113, 22, !dbg !1255
  store i32 %add239, ptr %acc, align 4, !dbg !1255
  br label %if.end243, !dbg !1257

if.else240:                                       ; preds = %if.end233
  %114 = load i32, ptr %acc, align 4, !dbg !1258
  %call241 = call noundef i32 @_ZL8doubleIti(i32 noundef %114), !dbg !1260
  %115 = load i32, ptr %acc, align 4, !dbg !1261
  %add242 = add nsw i32 %115, %call241, !dbg !1261
  store i32 %add242, ptr %acc, align 4, !dbg !1261
  br label %if.end243

if.end243:                                        ; preds = %if.else240, %if.then238
  br label %for.inc244, !dbg !1262

for.inc244:                                       ; preds = %if.end243
  %116 = load i32, ptr %j, align 4, !dbg !1263
  %inc245 = add nsw i32 %116, 1, !dbg !1263
  store i32 %inc245, ptr %j, align 4, !dbg !1263
  br label %for.cond221, !dbg !1264, !llvm.loop !1265

for.end246:                                       ; preds = %for.cond221
  %117 = load i32, ptr %acc, align 4, !dbg !1267
  %call247 = call noundef i32 @_ZL6opaqueii(i32 noundef %117, i32 noundef 60), !dbg !1269
  %and248 = and i32 %call247, 1, !dbg !1270
  %cmp249 = icmp eq i32 %and248, 0, !dbg !1271
  br i1 %cmp249, label %if.then250, label %if.else252, !dbg !1272

if.then250:                                       ; preds = %for.end246
  %118 = load i32, ptr %acc, align 4, !dbg !1273
  %add251 = add nsw i32 %118, 17, !dbg !1273
  store i32 %add251, ptr %acc, align 4, !dbg !1273
  br label %if.end255, !dbg !1275

if.else252:                                       ; preds = %for.end246
  %119 = load i32, ptr %acc, align 4, !dbg !1276
  %call253 = call noundef i32 @_ZL8doubleIti(i32 noundef %119), !dbg !1278
  %120 = load i32, ptr %acc, align 4, !dbg !1279
  %add254 = add nsw i32 %120, %call253, !dbg !1279
  store i32 %add254, ptr %acc, align 4, !dbg !1279
  br label %if.end255

if.end255:                                        ; preds = %if.else252, %if.then250
  %121 = load i32, ptr %acc, align 4, !dbg !1280
  %call256 = call noundef i32 @_ZL6opaqueii(i32 noundef %121, i32 noundef 61), !dbg !1282
  %rem257 = srem i32 %call256, 3, !dbg !1283
  %cmp258 = icmp eq i32 %rem257, 0, !dbg !1284
  br i1 %cmp258, label %if.then259, label %if.else261, !dbg !1285

if.then259:                                       ; preds = %if.end255
  %122 = load i32, ptr %acc, align 4, !dbg !1286
  %add260 = add nsw i32 %122, 19, !dbg !1286
  store i32 %add260, ptr %acc, align 4, !dbg !1286
  br label %if.end264, !dbg !1288

if.else261:                                       ; preds = %if.end255
  %123 = load i32, ptr %acc, align 4, !dbg !1289
  %call262 = call noundef i32 @_ZL8doubleIti(i32 noundef %123), !dbg !1291
  %124 = load i32, ptr %acc, align 4, !dbg !1292
  %add263 = add nsw i32 %124, %call262, !dbg !1292
  store i32 %add263, ptr %acc, align 4, !dbg !1292
  br label %if.end264

if.end264:                                        ; preds = %if.else261, %if.then259
  %125 = load i32, ptr %acc, align 4, !dbg !1293
  %call265 = call noundef i32 @_ZL6opaqueii(i32 noundef %125, i32 noundef 62), !dbg !1295
  %rem266 = srem i32 %call265, 5, !dbg !1296
  %cmp267 = icmp slt i32 %rem266, 2, !dbg !1297
  br i1 %cmp267, label %if.then268, label %if.else270, !dbg !1298

if.then268:                                       ; preds = %if.end264
  %126 = load i32, ptr %acc, align 4, !dbg !1299
  %add269 = add nsw i32 %126, 23, !dbg !1299
  store i32 %add269, ptr %acc, align 4, !dbg !1299
  br label %if.end273, !dbg !1301

if.else270:                                       ; preds = %if.end264
  %127 = load i32, ptr %acc, align 4, !dbg !1302
  %call271 = call noundef i32 @_ZL8doubleIti(i32 noundef %127), !dbg !1304
  %128 = load i32, ptr %acc, align 4, !dbg !1305
  %add272 = add nsw i32 %128, %call271, !dbg !1305
  store i32 %add272, ptr %acc, align 4, !dbg !1305
  br label %if.end273

if.end273:                                        ; preds = %if.else270, %if.then268
  %129 = load i32, ptr %acc, align 4, !dbg !1306
  %call274 = call noundef i32 @_ZL6opaqueii(i32 noundef %129, i32 noundef 63), !dbg !1308
  %and275 = and i32 %call274, 4, !dbg !1309
  %cmp276 = icmp ne i32 %and275, 0, !dbg !1310
  br i1 %cmp276, label %if.then277, label %if.else279, !dbg !1311

if.then277:                                       ; preds = %if.end273
  %130 = load i32, ptr %acc, align 4, !dbg !1312
  %add278 = add nsw i32 %130, 29, !dbg !1312
  store i32 %add278, ptr %acc, align 4, !dbg !1312
  br label %if.end282, !dbg !1314

if.else279:                                       ; preds = %if.end273
  %131 = load i32, ptr %acc, align 4, !dbg !1315
  %call280 = call noundef i32 @_ZL8doubleIti(i32 noundef %131), !dbg !1317
  %132 = load i32, ptr %acc, align 4, !dbg !1318
  %add281 = add nsw i32 %132, %call280, !dbg !1318
  store i32 %add281, ptr %acc, align 4, !dbg !1318
  br label %if.end282

if.end282:                                        ; preds = %if.else279, %if.then277
  %133 = load i32, ptr %acc, align 4, !dbg !1319
  %call283 = call noundef i32 @_ZL6opaqueii(i32 noundef %133, i32 noundef 64), !dbg !1321
  %rem284 = srem i32 %call283, 7, !dbg !1322
  %cmp285 = icmp eq i32 %rem284, 0, !dbg !1323
  br i1 %cmp285, label %if.then286, label %if.else288, !dbg !1324

if.then286:                                       ; preds = %if.end282
  %134 = load i32, ptr %acc, align 4, !dbg !1325
  %add287 = add nsw i32 %134, 31, !dbg !1325
  store i32 %add287, ptr %acc, align 4, !dbg !1325
  br label %if.end291, !dbg !1327

if.else288:                                       ; preds = %if.end282
  %135 = load i32, ptr %acc, align 4, !dbg !1328
  %call289 = call noundef i32 @_ZL8doubleIti(i32 noundef %135), !dbg !1330
  %136 = load i32, ptr %acc, align 4, !dbg !1331
  %add290 = add nsw i32 %136, %call289, !dbg !1331
  store i32 %add290, ptr %acc, align 4, !dbg !1331
  br label %if.end291

if.end291:                                        ; preds = %if.else288, %if.then286
  %137 = load i32, ptr %acc, align 4, !dbg !1332
  %call292 = call noundef i32 @_ZL6opaqueii(i32 noundef %137, i32 noundef 65), !dbg !1334
  %and293 = and i32 %call292, 8, !dbg !1335
  %cmp294 = icmp ne i32 %and293, 0, !dbg !1336
  br i1 %cmp294, label %if.then295, label %if.else297, !dbg !1337

if.then295:                                       ; preds = %if.end291
  %138 = load i32, ptr %acc, align 4, !dbg !1338
  %add296 = add nsw i32 %138, 37, !dbg !1338
  store i32 %add296, ptr %acc, align 4, !dbg !1338
  br label %if.end300, !dbg !1340

if.else297:                                       ; preds = %if.end291
  %139 = load i32, ptr %acc, align 4, !dbg !1341
  %call298 = call noundef i32 @_ZL8doubleIti(i32 noundef %139), !dbg !1343
  %140 = load i32, ptr %acc, align 4, !dbg !1344
  %add299 = add nsw i32 %140, %call298, !dbg !1344
  store i32 %add299, ptr %acc, align 4, !dbg !1344
  br label %if.end300

if.end300:                                        ; preds = %if.else297, %if.then295
  %141 = load i32, ptr %acc, align 4, !dbg !1345
  %call301 = call noundef i32 @_ZL6opaqueii(i32 noundef %141, i32 noundef 66), !dbg !1347
  %rem302 = srem i32 %call301, 4, !dbg !1348
  %cmp303 = icmp eq i32 %rem302, 1, !dbg !1349
  br i1 %cmp303, label %if.then304, label %if.else306, !dbg !1350

if.then304:                                       ; preds = %if.end300
  %142 = load i32, ptr %acc, align 4, !dbg !1351
  %add305 = add nsw i32 %142, 41, !dbg !1351
  store i32 %add305, ptr %acc, align 4, !dbg !1351
  br label %if.end309, !dbg !1353

if.else306:                                       ; preds = %if.end300
  %143 = load i32, ptr %acc, align 4, !dbg !1354
  %call307 = call noundef i32 @_ZL8doubleIti(i32 noundef %143), !dbg !1356
  %144 = load i32, ptr %acc, align 4, !dbg !1357
  %add308 = add nsw i32 %144, %call307, !dbg !1357
  store i32 %add308, ptr %acc, align 4, !dbg !1357
  br label %if.end309

if.end309:                                        ; preds = %if.else306, %if.then304
  %145 = load i32, ptr %acc, align 4, !dbg !1358
  %call310 = call noundef i32 @_ZL6opaqueii(i32 noundef %145, i32 noundef 67), !dbg !1360
  %rem311 = srem i32 %call310, 6, !dbg !1361
  %cmp312 = icmp slt i32 %rem311, 3, !dbg !1362
  br i1 %cmp312, label %if.then313, label %if.else315, !dbg !1363

if.then313:                                       ; preds = %if.end309
  %146 = load i32, ptr %acc, align 4, !dbg !1364
  %add314 = add nsw i32 %146, 43, !dbg !1364
  store i32 %add314, ptr %acc, align 4, !dbg !1364
  br label %if.end318, !dbg !1366

if.else315:                                       ; preds = %if.end309
  %147 = load i32, ptr %acc, align 4, !dbg !1367
  %call316 = call noundef i32 @_ZL8doubleIti(i32 noundef %147), !dbg !1369
  %148 = load i32, ptr %acc, align 4, !dbg !1370
  %add317 = add nsw i32 %148, %call316, !dbg !1370
  store i32 %add317, ptr %acc, align 4, !dbg !1370
  br label %if.end318

if.end318:                                        ; preds = %if.else315, %if.then313
  %149 = load i32, ptr %acc, align 4, !dbg !1371
  %call319 = call noundef i32 @_ZL6opaqueii(i32 noundef %149, i32 noundef 68), !dbg !1373
  %and320 = and i32 %call319, 16, !dbg !1374
  %cmp321 = icmp ne i32 %and320, 0, !dbg !1375
  br i1 %cmp321, label %if.then322, label %if.else324, !dbg !1376

if.then322:                                       ; preds = %if.end318
  %150 = load i32, ptr %acc, align 4, !dbg !1377
  %add323 = add nsw i32 %150, 47, !dbg !1377
  store i32 %add323, ptr %acc, align 4, !dbg !1377
  br label %if.end327, !dbg !1379

if.else324:                                       ; preds = %if.end318
  %151 = load i32, ptr %acc, align 4, !dbg !1380
  %call325 = call noundef i32 @_ZL8doubleIti(i32 noundef %151), !dbg !1382
  %152 = load i32, ptr %acc, align 4, !dbg !1383
  %add326 = add nsw i32 %152, %call325, !dbg !1383
  store i32 %add326, ptr %acc, align 4, !dbg !1383
  br label %if.end327

if.end327:                                        ; preds = %if.else324, %if.then322
  %153 = load i32, ptr %acc, align 4, !dbg !1384
  %call328 = call noundef i32 @_ZL6opaqueii(i32 noundef %153, i32 noundef 69), !dbg !1386
  %rem329 = srem i32 %call328, 8, !dbg !1387
  %cmp330 = icmp eq i32 %rem329, 2, !dbg !1388
  br i1 %cmp330, label %if.then331, label %if.else333, !dbg !1389

if.then331:                                       ; preds = %if.end327
  %154 = load i32, ptr %acc, align 4, !dbg !1390
  %add332 = add nsw i32 %154, 53, !dbg !1390
  store i32 %add332, ptr %acc, align 4, !dbg !1390
  br label %if.end336, !dbg !1392

if.else333:                                       ; preds = %if.end327
  %155 = load i32, ptr %acc, align 4, !dbg !1393
  %call334 = call noundef i32 @_ZL8doubleIti(i32 noundef %155), !dbg !1395
  %156 = load i32, ptr %acc, align 4, !dbg !1396
  %add335 = add nsw i32 %156, %call334, !dbg !1396
  store i32 %add335, ptr %acc, align 4, !dbg !1396
  br label %if.end336

if.end336:                                        ; preds = %if.else333, %if.then331
  call void @llvm.dbg.declare(metadata ptr %k, metadata !1397, metadata !DIExpression()), !dbg !1399
  store i32 0, ptr %k, align 4, !dbg !1399
  br label %for.cond337, !dbg !1400

for.cond337:                                      ; preds = %for.inc380, %if.end336
  %157 = load i32, ptr %k, align 4, !dbg !1401
  %cmp338 = icmp slt i32 %157, 30, !dbg !1403
  br i1 %cmp338, label %for.body339, label %for.end382, !dbg !1404

for.body339:                                      ; preds = %for.cond337
  %158 = load i32, ptr %acc, align 4, !dbg !1405
  %159 = load i32, ptr %k, align 4, !dbg !1408
  %add340 = add nsw i32 %158, %159, !dbg !1409
  %call341 = call noundef i32 @_ZL6opaqueii(i32 noundef %add340, i32 noundef 70), !dbg !1410
  %and342 = and i32 %call341, 1, !dbg !1411
  %cmp343 = icmp eq i32 %and342, 0, !dbg !1412
  br i1 %cmp343, label %if.then344, label %if.else346, !dbg !1413

if.then344:                                       ; preds = %for.body339
  %160 = load i32, ptr %acc, align 4, !dbg !1414
  %add345 = add nsw i32 %160, 9, !dbg !1414
  store i32 %add345, ptr %acc, align 4, !dbg !1414
  br label %if.end349, !dbg !1416

if.else346:                                       ; preds = %for.body339
  %161 = load i32, ptr %acc, align 4, !dbg !1417
  %call347 = call noundef i32 @_ZL8doubleIti(i32 noundef %161), !dbg !1419
  %162 = load i32, ptr %acc, align 4, !dbg !1420
  %add348 = add nsw i32 %162, %call347, !dbg !1420
  store i32 %add348, ptr %acc, align 4, !dbg !1420
  br label %if.end349

if.end349:                                        ; preds = %if.else346, %if.then344
  %163 = load i32, ptr %acc, align 4, !dbg !1421
  %164 = load i32, ptr %k, align 4, !dbg !1423
  %add350 = add nsw i32 %163, %164, !dbg !1424
  %call351 = call noundef i32 @_ZL6opaqueii(i32 noundef %add350, i32 noundef 71), !dbg !1425
  %rem352 = srem i32 %call351, 3, !dbg !1426
  %cmp353 = icmp eq i32 %rem352, 1, !dbg !1427
  br i1 %cmp353, label %if.then354, label %if.else356, !dbg !1428

if.then354:                                       ; preds = %if.end349
  %165 = load i32, ptr %acc, align 4, !dbg !1429
  %add355 = add nsw i32 %165, 14, !dbg !1429
  store i32 %add355, ptr %acc, align 4, !dbg !1429
  br label %if.end359, !dbg !1431

if.else356:                                       ; preds = %if.end349
  %166 = load i32, ptr %acc, align 4, !dbg !1432
  %call357 = call noundef i32 @_ZL8doubleIti(i32 noundef %166), !dbg !1434
  %167 = load i32, ptr %acc, align 4, !dbg !1435
  %add358 = add nsw i32 %167, %call357, !dbg !1435
  store i32 %add358, ptr %acc, align 4, !dbg !1435
  br label %if.end359

if.end359:                                        ; preds = %if.else356, %if.then354
  %168 = load i32, ptr %acc, align 4, !dbg !1436
  %169 = load i32, ptr %k, align 4, !dbg !1438
  %add360 = add nsw i32 %168, %169, !dbg !1439
  %call361 = call noundef i32 @_ZL6opaqueii(i32 noundef %add360, i32 noundef 72), !dbg !1440
  %rem362 = srem i32 %call361, 5, !dbg !1441
  %cmp363 = icmp eq i32 %rem362, 2, !dbg !1442
  br i1 %cmp363, label %if.then364, label %if.else366, !dbg !1443

if.then364:                                       ; preds = %if.end359
  %170 = load i32, ptr %acc, align 4, !dbg !1444
  %add365 = add nsw i32 %170, 25, !dbg !1444
  store i32 %add365, ptr %acc, align 4, !dbg !1444
  br label %if.end369, !dbg !1446

if.else366:                                       ; preds = %if.end359
  %171 = load i32, ptr %acc, align 4, !dbg !1447
  %call367 = call noundef i32 @_ZL8doubleIti(i32 noundef %171), !dbg !1449
  %172 = load i32, ptr %acc, align 4, !dbg !1450
  %add368 = add nsw i32 %172, %call367, !dbg !1450
  store i32 %add368, ptr %acc, align 4, !dbg !1450
  br label %if.end369

if.end369:                                        ; preds = %if.else366, %if.then364
  %173 = load i32, ptr %acc, align 4, !dbg !1451
  %174 = load i32, ptr %k, align 4, !dbg !1453
  %add370 = add nsw i32 %173, %174, !dbg !1454
  %call371 = call noundef i32 @_ZL6opaqueii(i32 noundef %add370, i32 noundef 73), !dbg !1455
  %and372 = and i32 %call371, 2, !dbg !1456
  %cmp373 = icmp ne i32 %and372, 0, !dbg !1457
  br i1 %cmp373, label %if.then374, label %if.else376, !dbg !1458

if.then374:                                       ; preds = %if.end369
  %175 = load i32, ptr %acc, align 4, !dbg !1459
  %add375 = add nsw i32 %175, 11, !dbg !1459
  store i32 %add375, ptr %acc, align 4, !dbg !1459
  br label %if.end379, !dbg !1461

if.else376:                                       ; preds = %if.end369
  %176 = load i32, ptr %acc, align 4, !dbg !1462
  %call377 = call noundef i32 @_ZL8doubleIti(i32 noundef %176), !dbg !1464
  %177 = load i32, ptr %acc, align 4, !dbg !1465
  %add378 = add nsw i32 %177, %call377, !dbg !1465
  store i32 %add378, ptr %acc, align 4, !dbg !1465
  br label %if.end379

if.end379:                                        ; preds = %if.else376, %if.then374
  br label %for.inc380, !dbg !1466

for.inc380:                                       ; preds = %if.end379
  %178 = load i32, ptr %k, align 4, !dbg !1467
  %inc381 = add nsw i32 %178, 1, !dbg !1467
  store i32 %inc381, ptr %k, align 4, !dbg !1467
  br label %for.cond337, !dbg !1468, !llvm.loop !1469

for.end382:                                       ; preds = %for.cond337
  %179 = load i32, ptr %acc, align 4, !dbg !1471
  %call383 = call noundef i32 @_ZL6opaqueii(i32 noundef %179, i32 noundef 80), !dbg !1473
  %and384 = and i32 %call383, 1, !dbg !1474
  %cmp385 = icmp eq i32 %and384, 0, !dbg !1475
  br i1 %cmp385, label %if.then386, label %if.else388, !dbg !1476

if.then386:                                       ; preds = %for.end382
  %180 = load i32, ptr %acc, align 4, !dbg !1477
  %add387 = add nsw i32 %180, 12, !dbg !1477
  store i32 %add387, ptr %acc, align 4, !dbg !1477
  br label %if.end391, !dbg !1479

if.else388:                                       ; preds = %for.end382
  %181 = load i32, ptr %acc, align 4, !dbg !1480
  %call389 = call noundef i32 @_ZL8doubleIti(i32 noundef %181), !dbg !1482
  %182 = load i32, ptr %acc, align 4, !dbg !1483
  %add390 = add nsw i32 %182, %call389, !dbg !1483
  store i32 %add390, ptr %acc, align 4, !dbg !1483
  br label %if.end391

if.end391:                                        ; preds = %if.else388, %if.then386
  %183 = load i32, ptr %acc, align 4, !dbg !1484
  %call392 = call noundef i32 @_ZL6opaqueii(i32 noundef %183, i32 noundef 81), !dbg !1486
  %and393 = and i32 %call392, 2, !dbg !1487
  %cmp394 = icmp eq i32 %and393, 0, !dbg !1488
  br i1 %cmp394, label %if.then395, label %if.else397, !dbg !1489

if.then395:                                       ; preds = %if.end391
  %184 = load i32, ptr %acc, align 4, !dbg !1490
  %add396 = add nsw i32 %184, 18, !dbg !1490
  store i32 %add396, ptr %acc, align 4, !dbg !1490
  br label %if.end400, !dbg !1492

if.else397:                                       ; preds = %if.end391
  %185 = load i32, ptr %acc, align 4, !dbg !1493
  %call398 = call noundef i32 @_ZL8doubleIti(i32 noundef %185), !dbg !1495
  %186 = load i32, ptr %acc, align 4, !dbg !1496
  %add399 = add nsw i32 %186, %call398, !dbg !1496
  store i32 %add399, ptr %acc, align 4, !dbg !1496
  br label %if.end400

if.end400:                                        ; preds = %if.else397, %if.then395
  %187 = load i32, ptr %acc, align 4, !dbg !1497
  %call401 = call noundef i32 @_ZL6opaqueii(i32 noundef %187, i32 noundef 82), !dbg !1499
  %rem402 = srem i32 %call401, 3, !dbg !1500
  %cmp403 = icmp eq i32 %rem402, 2, !dbg !1501
  br i1 %cmp403, label %if.then404, label %if.else406, !dbg !1502

if.then404:                                       ; preds = %if.end400
  %188 = load i32, ptr %acc, align 4, !dbg !1503
  %add405 = add nsw i32 %188, 24, !dbg !1503
  store i32 %add405, ptr %acc, align 4, !dbg !1503
  br label %if.end409, !dbg !1505

if.else406:                                       ; preds = %if.end400
  %189 = load i32, ptr %acc, align 4, !dbg !1506
  %call407 = call noundef i32 @_ZL8doubleIti(i32 noundef %189), !dbg !1508
  %190 = load i32, ptr %acc, align 4, !dbg !1509
  %add408 = add nsw i32 %190, %call407, !dbg !1509
  store i32 %add408, ptr %acc, align 4, !dbg !1509
  br label %if.end409

if.end409:                                        ; preds = %if.else406, %if.then404
  %191 = load i32, ptr %acc, align 4, !dbg !1510
  %call410 = call noundef i32 @_ZL6opaqueii(i32 noundef %191, i32 noundef 83), !dbg !1512
  %rem411 = srem i32 %call410, 5, !dbg !1513
  %cmp412 = icmp eq i32 %rem411, 1, !dbg !1514
  br i1 %cmp412, label %if.then413, label %if.else415, !dbg !1515

if.then413:                                       ; preds = %if.end409
  %192 = load i32, ptr %acc, align 4, !dbg !1516
  %add414 = add nsw i32 %192, 28, !dbg !1516
  store i32 %add414, ptr %acc, align 4, !dbg !1516
  br label %if.end418, !dbg !1518

if.else415:                                       ; preds = %if.end409
  %193 = load i32, ptr %acc, align 4, !dbg !1519
  %call416 = call noundef i32 @_ZL8doubleIti(i32 noundef %193), !dbg !1521
  %194 = load i32, ptr %acc, align 4, !dbg !1522
  %add417 = add nsw i32 %194, %call416, !dbg !1522
  store i32 %add417, ptr %acc, align 4, !dbg !1522
  br label %if.end418

if.end418:                                        ; preds = %if.else415, %if.then413
  %195 = load i32, ptr %acc, align 4, !dbg !1523
  %call419 = call noundef i32 @_ZL6opaqueii(i32 noundef %195, i32 noundef 84), !dbg !1525
  %and420 = and i32 %call419, 4, !dbg !1526
  %cmp421 = icmp ne i32 %and420, 0, !dbg !1527
  br i1 %cmp421, label %if.then422, label %if.else424, !dbg !1528

if.then422:                                       ; preds = %if.end418
  %196 = load i32, ptr %acc, align 4, !dbg !1529
  %add423 = add nsw i32 %196, 32, !dbg !1529
  store i32 %add423, ptr %acc, align 4, !dbg !1529
  br label %if.end427, !dbg !1531

if.else424:                                       ; preds = %if.end418
  %197 = load i32, ptr %acc, align 4, !dbg !1532
  %call425 = call noundef i32 @_ZL8doubleIti(i32 noundef %197), !dbg !1534
  %198 = load i32, ptr %acc, align 4, !dbg !1535
  %add426 = add nsw i32 %198, %call425, !dbg !1535
  store i32 %add426, ptr %acc, align 4, !dbg !1535
  br label %if.end427

if.end427:                                        ; preds = %if.else424, %if.then422
  %199 = load i32, ptr %acc, align 4, !dbg !1536
  %call428 = call noundef i32 @_ZL6opaqueii(i32 noundef %199, i32 noundef 85), !dbg !1538
  %rem429 = srem i32 %call428, 7, !dbg !1539
  %cmp430 = icmp slt i32 %rem429, 3, !dbg !1540
  br i1 %cmp430, label %if.then431, label %if.else433, !dbg !1541

if.then431:                                       ; preds = %if.end427
  %200 = load i32, ptr %acc, align 4, !dbg !1542
  %add432 = add nsw i32 %200, 36, !dbg !1542
  store i32 %add432, ptr %acc, align 4, !dbg !1542
  br label %if.end436, !dbg !1544

if.else433:                                       ; preds = %if.end427
  %201 = load i32, ptr %acc, align 4, !dbg !1545
  %call434 = call noundef i32 @_ZL8doubleIti(i32 noundef %201), !dbg !1547
  %202 = load i32, ptr %acc, align 4, !dbg !1548
  %add435 = add nsw i32 %202, %call434, !dbg !1548
  store i32 %add435, ptr %acc, align 4, !dbg !1548
  br label %if.end436

if.end436:                                        ; preds = %if.else433, %if.then431
  %203 = load i32, ptr %acc, align 4, !dbg !1549
  %call437 = call noundef i32 @_ZL6opaqueii(i32 noundef %203, i32 noundef 86), !dbg !1551
  %and438 = and i32 %call437, 8, !dbg !1552
  %cmp439 = icmp ne i32 %and438, 0, !dbg !1553
  br i1 %cmp439, label %if.then440, label %if.else442, !dbg !1554

if.then440:                                       ; preds = %if.end436
  %204 = load i32, ptr %acc, align 4, !dbg !1555
  %add441 = add nsw i32 %204, 40, !dbg !1555
  store i32 %add441, ptr %acc, align 4, !dbg !1555
  br label %if.end445, !dbg !1557

if.else442:                                       ; preds = %if.end436
  %205 = load i32, ptr %acc, align 4, !dbg !1558
  %call443 = call noundef i32 @_ZL8doubleIti(i32 noundef %205), !dbg !1560
  %206 = load i32, ptr %acc, align 4, !dbg !1561
  %add444 = add nsw i32 %206, %call443, !dbg !1561
  store i32 %add444, ptr %acc, align 4, !dbg !1561
  br label %if.end445

if.end445:                                        ; preds = %if.else442, %if.then440
  %207 = load i32, ptr %acc, align 4, !dbg !1562
  %call446 = call noundef i32 @_ZL6opaqueii(i32 noundef %207, i32 noundef 87), !dbg !1564
  %rem447 = srem i32 %call446, 4, !dbg !1565
  %cmp448 = icmp eq i32 %rem447, 0, !dbg !1566
  br i1 %cmp448, label %if.then449, label %if.else451, !dbg !1567

if.then449:                                       ; preds = %if.end445
  %208 = load i32, ptr %acc, align 4, !dbg !1568
  %add450 = add nsw i32 %208, 44, !dbg !1568
  store i32 %add450, ptr %acc, align 4, !dbg !1568
  br label %if.end454, !dbg !1570

if.else451:                                       ; preds = %if.end445
  %209 = load i32, ptr %acc, align 4, !dbg !1571
  %call452 = call noundef i32 @_ZL8doubleIti(i32 noundef %209), !dbg !1573
  %210 = load i32, ptr %acc, align 4, !dbg !1574
  %add453 = add nsw i32 %210, %call452, !dbg !1574
  store i32 %add453, ptr %acc, align 4, !dbg !1574
  br label %if.end454

if.end454:                                        ; preds = %if.else451, %if.then449
  %211 = load i32, ptr %acc, align 4, !dbg !1575
  %call455 = call noundef i32 @_ZL6opaqueii(i32 noundef %211, i32 noundef 88), !dbg !1577
  %rem456 = srem i32 %call455, 6, !dbg !1578
  %cmp457 = icmp eq i32 %rem456, 5, !dbg !1579
  br i1 %cmp457, label %if.then458, label %if.else460, !dbg !1580

if.then458:                                       ; preds = %if.end454
  %212 = load i32, ptr %acc, align 4, !dbg !1581
  %add459 = add nsw i32 %212, 48, !dbg !1581
  store i32 %add459, ptr %acc, align 4, !dbg !1581
  br label %if.end463, !dbg !1583

if.else460:                                       ; preds = %if.end454
  %213 = load i32, ptr %acc, align 4, !dbg !1584
  %call461 = call noundef i32 @_ZL8doubleIti(i32 noundef %213), !dbg !1586
  %214 = load i32, ptr %acc, align 4, !dbg !1587
  %add462 = add nsw i32 %214, %call461, !dbg !1587
  store i32 %add462, ptr %acc, align 4, !dbg !1587
  br label %if.end463

if.end463:                                        ; preds = %if.else460, %if.then458
  %215 = load i32, ptr %acc, align 4, !dbg !1588
  %call464 = call noundef i32 @_ZL6opaqueii(i32 noundef %215, i32 noundef 89), !dbg !1590
  %and465 = and i32 %call464, 16, !dbg !1591
  %cmp466 = icmp ne i32 %and465, 0, !dbg !1592
  br i1 %cmp466, label %if.then467, label %if.else469, !dbg !1593

if.then467:                                       ; preds = %if.end463
  %216 = load i32, ptr %acc, align 4, !dbg !1594
  %add468 = add nsw i32 %216, 52, !dbg !1594
  store i32 %add468, ptr %acc, align 4, !dbg !1594
  br label %if.end472, !dbg !1596

if.else469:                                       ; preds = %if.end463
  %217 = load i32, ptr %acc, align 4, !dbg !1597
  %call470 = call noundef i32 @_ZL8doubleIti(i32 noundef %217), !dbg !1599
  %218 = load i32, ptr %acc, align 4, !dbg !1600
  %add471 = add nsw i32 %218, %call470, !dbg !1600
  store i32 %add471, ptr %acc, align 4, !dbg !1600
  br label %if.end472

if.end472:                                        ; preds = %if.else469, %if.then467
  %219 = load i32, ptr %acc, align 4, !dbg !1601
  ret i32 %219, !dbg !1602
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind uwtable
define internal noundef i32 @_ZL6opaqueii(i32 noundef %x, i32 noundef %salt) #2 !dbg !1603 {
entry:
  %x.addr = alloca i32, align 4
  %salt.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !1606, metadata !DIExpression()), !dbg !1607
  store i32 %salt, ptr %salt.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %salt.addr, metadata !1608, metadata !DIExpression()), !dbg !1609
  %0 = load i32, ptr %x.addr, align 4, !dbg !1610
  %mul = mul nsw i32 %0, 1664525, !dbg !1611
  %add = add nsw i32 %mul, 1013904223, !dbg !1612
  %1 = load i32, ptr %salt.addr, align 4, !dbg !1613
  %add1 = add nsw i32 %add, %1, !dbg !1614
  store i32 %add1, ptr %x.addr, align 4, !dbg !1615
  %2 = load i32, ptr %x.addr, align 4, !dbg !1616
  %shr = ashr i32 %2, 13, !dbg !1617
  %3 = load i32, ptr %x.addr, align 4, !dbg !1618
  %xor = xor i32 %3, %shr, !dbg !1618
  store i32 %xor, ptr %x.addr, align 4, !dbg !1618
  %4 = load i32, ptr %x.addr, align 4, !dbg !1619
  %shl = shl i32 %4, 7, !dbg !1620
  %5 = load i32, ptr %x.addr, align 4, !dbg !1621
  %xor2 = xor i32 %5, %shl, !dbg !1621
  store i32 %xor2, ptr %x.addr, align 4, !dbg !1621
  %6 = load i32, ptr %x.addr, align 4, !dbg !1622
  %shr3 = ashr i32 %6, 17, !dbg !1623
  %7 = load i32, ptr %x.addr, align 4, !dbg !1624
  %xor4 = xor i32 %7, %shr3, !dbg !1624
  store i32 %xor4, ptr %x.addr, align 4, !dbg !1624
  %8 = load i32, ptr %x.addr, align 4, !dbg !1625
  %and = and i32 %8, 2147483647, !dbg !1626
  ret i32 %and, !dbg !1627
}

; Function Attrs: mustprogress noinline nounwind uwtable
define internal noundef i32 @_ZL8doubleIti(i32 noundef %x) #2 !dbg !1628 {
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !1629, metadata !DIExpression()), !dbg !1630
  %0 = load i32, ptr %x.addr, align 4, !dbg !1631
  %mul = mul nsw i32 %0, 2, !dbg !1632
  ret i32 %mul, !dbg !1633
}

; Function Attrs: mustprogress noinline norecurse uwtable
define dso_local noundef i32 @main() #3 !dbg !1634 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  call void @llvm.dbg.declare(metadata ptr %x, metadata !1635, metadata !DIExpression()), !dbg !1636
  %0 = load volatile i32, ptr @g_seed, align 4, !dbg !1637
  store i32 %0, ptr %x, align 4, !dbg !1636
  %1 = load i32, ptr %x, align 4, !dbg !1638
  %call = call noundef i32 @_Z18benchmark_functioni(i32 noundef %1), !dbg !1639
  store i32 %call, ptr %x, align 4, !dbg !1640
  %2 = load i32, ptr %x, align 4, !dbg !1641
  store volatile i32 %2, ptr @g_sink, align 4, !dbg !1642
  %3 = load volatile i32, ptr @g_sink, align 4, !dbg !1643
  %call1 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 noundef %3), !dbg !1644
  %call2 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c(ptr noundef nonnull align 8 dereferenceable(8) %call1, i8 noundef signext 10), !dbg !1645
  ret i32 0, !dbg !1646
}

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c(ptr noundef nonnull align 8 dereferenceable(8), i8 noundef signext) #4

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8), i32 noundef) #4

attributes #0 = { mustprogress noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress noinline norecurse uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!864, !865, !866, !867, !868, !869, !870}
!llvm.ident = !{!871}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "g_seed", scope: !2, file: !7, line: 10, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, producer: "Ubuntu clang version 17.0.6 (9ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, imports: !10, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "benchmark1.cpp", directory: "/home/max/Documents/repos/spear/programs/ILP", checksumkind: CSK_MD5, checksum: "1334da74f77ec86cc8f443e592126b14")
!4 = !{!0, !5}
!5 = !DIGlobalVariableExpression(var: !6, expr: !DIExpression())
!6 = distinct !DIGlobalVariable(name: "g_sink", scope: !2, file: !7, line: 11, type: !8, isLocal: false, isDefinition: true)
!7 = !DIFile(filename: "./benchmark1.cpp", directory: "/home/max/Documents/repos/spear/programs/ILP", checksumkind: CSK_MD5, checksum: "1334da74f77ec86cc8f443e592126b14")
!8 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !9)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !{!11, !31, !34, !39, !47, !55, !59, !66, !70, !74, !76, !78, !82, !94, !98, !104, !110, !112, !116, !120, !124, !128, !140, !142, !146, !150, !154, !156, !162, !166, !170, !172, !174, !178, !186, !190, !194, !198, !200, !206, !208, !215, !220, !224, !229, !233, !237, !241, !243, !245, !249, !253, !257, !259, !263, !267, !269, !271, !275, !281, !286, !291, !292, !293, !294, !295, !296, !297, !298, !299, !300, !301, !305, !309, !314, !318, !322, !327, !333, !335, !337, !339, !341, !343, !345, !347, !349, !351, !353, !355, !357, !359, !363, !367, !371, !377, !381, !385, !390, !392, !396, !400, !404, !414, !416, !420, !424, !428, !432, !436, !440, !444, !448, !452, !456, !460, !462, !466, !470, !474, !480, !484, !488, !490, !494, !498, !504, !506, !510, !514, !518, !522, !526, !530, !534, !535, !536, !537, !539, !540, !541, !542, !543, !544, !545, !549, !555, !560, !564, !566, !568, !570, !572, !579, !583, !587, !591, !595, !599, !604, !608, !610, !614, !620, !624, !629, !631, !633, !637, !641, !643, !645, !647, !649, !653, !655, !657, !661, !665, !669, !673, !677, !681, !683, !687, !691, !695, !699, !701, !703, !707, !711, !712, !713, !714, !715, !716, !724, !732, !735, !736, !738, !740, !742, !744, !748, !750, !752, !754, !756, !758, !760, !762, !764, !768, !772, !774, !778, !782, !788, !792, !794, !797, !800, !802, !804, !806, !810, !813, !816, !819, !822, !824, !829, !833, !836, !839, !841, !843, !845, !847, !850, !853, !856, !859, !862}
!11 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !13, file: !30, line: 64)
!12 = !DINamespace(name: "std", scope: null)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "mbstate_t", file: !14, line: 6, baseType: !15)
!14 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/mbstate_t.h", directory: "", checksumkind: CSK_MD5, checksum: "ba8742313715e20e434cf6ccb2db98e3")
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mbstate_t", file: !16, line: 21, baseType: !17)
!16 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h", directory: "", checksumkind: CSK_MD5, checksum: "82911a3e689448e3691ded3e0b471a55")
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !16, line: 13, size: 64, flags: DIFlagTypePassByValue, elements: !18, identifier: "_ZTS11__mbstate_t")
!18 = !{!19, !20}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !17, file: !16, line: 15, baseType: !9, size: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "__value", scope: !17, file: !16, line: 20, baseType: !21, size: 32, offset: 32)
!21 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !17, file: !16, line: 16, size: 32, flags: DIFlagTypePassByValue, elements: !22, identifier: "_ZTSN11__mbstate_tUt_E")
!22 = !{!23, !25}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "__wch", scope: !21, file: !16, line: 18, baseType: !24, size: 32)
!24 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "__wchb", scope: !21, file: !16, line: 19, baseType: !26, size: 32)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !27, size: 32, elements: !28)
!27 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!28 = !{!29}
!29 = !DISubrange(count: 4)
!30 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/cwchar", directory: "")
!31 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !32, file: !30, line: 141)
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "wint_t", file: !33, line: 20, baseType: !24)
!33 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/wint_t.h", directory: "", checksumkind: CSK_MD5, checksum: "aa31b53ef28dc23152ceb41e2763ded3")
!34 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !35, file: !30, line: 143)
!35 = !DISubprogram(name: "btowc", scope: !36, file: !36, line: 309, type: !37, flags: DIFlagPrototyped, spFlags: 0)
!36 = !DIFile(filename: "/usr/include/wchar.h", directory: "", checksumkind: CSK_MD5, checksum: "889114206ea781a9a9a0b33e52589e47")
!37 = !DISubroutineType(types: !38)
!38 = !{!32, !9}
!39 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !40, file: !30, line: 144)
!40 = !DISubprogram(name: "fgetwc", scope: !36, file: !36, line: 935, type: !41, flags: DIFlagPrototyped, spFlags: 0)
!41 = !DISubroutineType(types: !42)
!42 = !{!32, !43}
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = !DIDerivedType(tag: DW_TAG_typedef, name: "__FILE", file: !45, line: 5, baseType: !46)
!45 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__FILE.h", directory: "", checksumkind: CSK_MD5, checksum: "72a8fe90981f484acae7c6f3dfc5c2b7")
!46 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !45, line: 4, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS8_IO_FILE")
!47 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !48, file: !30, line: 145)
!48 = !DISubprogram(name: "fgetws", scope: !36, file: !36, line: 964, type: !49, flags: DIFlagPrototyped, spFlags: 0)
!49 = !DISubroutineType(types: !50)
!50 = !{!51, !53, !9, !54}
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!53 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !51)
!54 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !43)
!55 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !56, file: !30, line: 146)
!56 = !DISubprogram(name: "fputwc", scope: !36, file: !36, line: 949, type: !57, flags: DIFlagPrototyped, spFlags: 0)
!57 = !DISubroutineType(types: !58)
!58 = !{!32, !52, !43}
!59 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !60, file: !30, line: 147)
!60 = !DISubprogram(name: "fputws", scope: !36, file: !36, line: 971, type: !61, flags: DIFlagPrototyped, spFlags: 0)
!61 = !DISubroutineType(types: !62)
!62 = !{!9, !63, !54}
!63 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !64)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !52)
!66 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !67, file: !30, line: 148)
!67 = !DISubprogram(name: "fwide", scope: !36, file: !36, line: 725, type: !68, flags: DIFlagPrototyped, spFlags: 0)
!68 = !DISubroutineType(types: !69)
!69 = !{!9, !43, !9}
!70 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !71, file: !30, line: 149)
!71 = !DISubprogram(name: "fwprintf", scope: !36, file: !36, line: 732, type: !72, flags: DIFlagPrototyped, spFlags: 0)
!72 = !DISubroutineType(types: !73)
!73 = !{!9, !54, !63, null}
!74 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !75, file: !30, line: 150)
!75 = !DISubprogram(name: "fwscanf", linkageName: "__isoc23_fwscanf", scope: !36, file: !36, line: 795, type: !72, flags: DIFlagPrototyped, spFlags: 0)
!76 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !77, file: !30, line: 151)
!77 = !DISubprogram(name: "getwc", scope: !36, file: !36, line: 936, type: !41, flags: DIFlagPrototyped, spFlags: 0)
!78 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !79, file: !30, line: 152)
!79 = !DISubprogram(name: "getwchar", scope: !36, file: !36, line: 942, type: !80, flags: DIFlagPrototyped, spFlags: 0)
!80 = !DISubroutineType(types: !81)
!81 = !{!32}
!82 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !83, file: !30, line: 153)
!83 = !DISubprogram(name: "mbrlen", scope: !36, file: !36, line: 332, type: !84, flags: DIFlagPrototyped, spFlags: 0)
!84 = !DISubroutineType(types: !85)
!85 = !{!86, !89, !86, !92}
!86 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !87, line: 46, baseType: !88)
!87 = !DIFile(filename: "/usr/lib/llvm-17/lib/clang/17/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "d1776268f398bd1ca997c840ad581432")
!88 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!89 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !90)
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!91 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !27)
!92 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !93)
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!94 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !95, file: !30, line: 154)
!95 = !DISubprogram(name: "mbrtowc", scope: !36, file: !36, line: 321, type: !96, flags: DIFlagPrototyped, spFlags: 0)
!96 = !DISubroutineType(types: !97)
!97 = !{!86, !53, !89, !86, !92}
!98 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !99, file: !30, line: 155)
!99 = !DISubprogram(name: "mbsinit", scope: !36, file: !36, line: 317, type: !100, flags: DIFlagPrototyped, spFlags: 0)
!100 = !DISubroutineType(types: !101)
!101 = !{!9, !102}
!102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !103, size: 64)
!103 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!104 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !105, file: !30, line: 156)
!105 = !DISubprogram(name: "mbsrtowcs", scope: !36, file: !36, line: 362, type: !106, flags: DIFlagPrototyped, spFlags: 0)
!106 = !DISubroutineType(types: !107)
!107 = !{!86, !53, !108, !86, !92}
!108 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !109)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!110 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !111, file: !30, line: 157)
!111 = !DISubprogram(name: "putwc", scope: !36, file: !36, line: 950, type: !57, flags: DIFlagPrototyped, spFlags: 0)
!112 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !113, file: !30, line: 158)
!113 = !DISubprogram(name: "putwchar", scope: !36, file: !36, line: 956, type: !114, flags: DIFlagPrototyped, spFlags: 0)
!114 = !DISubroutineType(types: !115)
!115 = !{!32, !52}
!116 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !117, file: !30, line: 160)
!117 = !DISubprogram(name: "swprintf", scope: !36, file: !36, line: 742, type: !118, flags: DIFlagPrototyped, spFlags: 0)
!118 = !DISubroutineType(types: !119)
!119 = !{!9, !53, !86, !63, null}
!120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !121, file: !30, line: 162)
!121 = !DISubprogram(name: "swscanf", linkageName: "__isoc23_swscanf", scope: !36, file: !36, line: 802, type: !122, flags: DIFlagPrototyped, spFlags: 0)
!122 = !DISubroutineType(types: !123)
!123 = !{!9, !63, !63, null}
!124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !125, file: !30, line: 163)
!125 = !DISubprogram(name: "ungetwc", scope: !36, file: !36, line: 979, type: !126, flags: DIFlagPrototyped, spFlags: 0)
!126 = !DISubroutineType(types: !127)
!127 = !{!32, !32, !43}
!128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !129, file: !30, line: 164)
!129 = !DISubprogram(name: "vfwprintf", scope: !36, file: !36, line: 750, type: !130, flags: DIFlagPrototyped, spFlags: 0)
!130 = !DISubroutineType(types: !131)
!131 = !{!9, !54, !63, !132}
!132 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !133, size: 64)
!133 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", size: 192, flags: DIFlagTypePassByValue, elements: !134, identifier: "_ZTS13__va_list_tag")
!134 = !{!135, !136, !137, !139}
!135 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !133, file: !3, baseType: !24, size: 32)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !133, file: !3, baseType: !24, size: 32, offset: 32)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !133, file: !3, baseType: !138, size: 64, offset: 64)
!138 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !133, file: !3, baseType: !138, size: 64, offset: 128)
!140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !141, file: !30, line: 166)
!141 = !DISubprogram(name: "vfwscanf", linkageName: "__isoc23_vfwscanf", scope: !36, file: !36, line: 875, type: !130, flags: DIFlagPrototyped, spFlags: 0)
!142 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !143, file: !30, line: 169)
!143 = !DISubprogram(name: "vswprintf", scope: !36, file: !36, line: 763, type: !144, flags: DIFlagPrototyped, spFlags: 0)
!144 = !DISubroutineType(types: !145)
!145 = !{!9, !53, !86, !63, !132}
!146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !147, file: !30, line: 172)
!147 = !DISubprogram(name: "vswscanf", linkageName: "__isoc23_vswscanf", scope: !36, file: !36, line: 882, type: !148, flags: DIFlagPrototyped, spFlags: 0)
!148 = !DISubroutineType(types: !149)
!149 = !{!9, !63, !63, !132}
!150 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !151, file: !30, line: 174)
!151 = !DISubprogram(name: "vwprintf", scope: !36, file: !36, line: 758, type: !152, flags: DIFlagPrototyped, spFlags: 0)
!152 = !DISubroutineType(types: !153)
!153 = !{!9, !63, !132}
!154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !155, file: !30, line: 176)
!155 = !DISubprogram(name: "vwscanf", linkageName: "__isoc23_vwscanf", scope: !36, file: !36, line: 879, type: !152, flags: DIFlagPrototyped, spFlags: 0)
!156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !157, file: !30, line: 178)
!157 = !DISubprogram(name: "wcrtomb", scope: !36, file: !36, line: 326, type: !158, flags: DIFlagPrototyped, spFlags: 0)
!158 = !DISubroutineType(types: !159)
!159 = !{!86, !160, !52, !92}
!160 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !161)
!161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!162 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !163, file: !30, line: 179)
!163 = !DISubprogram(name: "wcscat", scope: !36, file: !36, line: 121, type: !164, flags: DIFlagPrototyped, spFlags: 0)
!164 = !DISubroutineType(types: !165)
!165 = !{!51, !53, !63}
!166 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !167, file: !30, line: 180)
!167 = !DISubprogram(name: "wcscmp", scope: !36, file: !36, line: 130, type: !168, flags: DIFlagPrototyped, spFlags: 0)
!168 = !DISubroutineType(types: !169)
!169 = !{!9, !64, !64}
!170 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !171, file: !30, line: 181)
!171 = !DISubprogram(name: "wcscoll", scope: !36, file: !36, line: 155, type: !168, flags: DIFlagPrototyped, spFlags: 0)
!172 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !173, file: !30, line: 182)
!173 = !DISubprogram(name: "wcscpy", scope: !36, file: !36, line: 98, type: !164, flags: DIFlagPrototyped, spFlags: 0)
!174 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !175, file: !30, line: 183)
!175 = !DISubprogram(name: "wcscspn", scope: !36, file: !36, line: 212, type: !176, flags: DIFlagPrototyped, spFlags: 0)
!176 = !DISubroutineType(types: !177)
!177 = !{!86, !64, !64}
!178 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !179, file: !30, line: 184)
!179 = !DISubprogram(name: "wcsftime", scope: !36, file: !36, line: 1043, type: !180, flags: DIFlagPrototyped, spFlags: 0)
!180 = !DISubroutineType(types: !181)
!181 = !{!86, !53, !86, !63, !182}
!182 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !183)
!183 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !184, size: 64)
!184 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !185)
!185 = !DICompositeType(tag: DW_TAG_structure_type, name: "tm", file: !36, line: 94, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTS2tm")
!186 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !187, file: !30, line: 185)
!187 = !DISubprogram(name: "wcslen", scope: !36, file: !36, line: 247, type: !188, flags: DIFlagPrototyped, spFlags: 0)
!188 = !DISubroutineType(types: !189)
!189 = !{!86, !64}
!190 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !191, file: !30, line: 186)
!191 = !DISubprogram(name: "wcsncat", scope: !36, file: !36, line: 125, type: !192, flags: DIFlagPrototyped, spFlags: 0)
!192 = !DISubroutineType(types: !193)
!193 = !{!51, !53, !63, !86}
!194 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !195, file: !30, line: 187)
!195 = !DISubprogram(name: "wcsncmp", scope: !36, file: !36, line: 133, type: !196, flags: DIFlagPrototyped, spFlags: 0)
!196 = !DISubroutineType(types: !197)
!197 = !{!9, !64, !64, !86}
!198 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !199, file: !30, line: 188)
!199 = !DISubprogram(name: "wcsncpy", scope: !36, file: !36, line: 103, type: !192, flags: DIFlagPrototyped, spFlags: 0)
!200 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !201, file: !30, line: 189)
!201 = !DISubprogram(name: "wcsrtombs", scope: !36, file: !36, line: 368, type: !202, flags: DIFlagPrototyped, spFlags: 0)
!202 = !DISubroutineType(types: !203)
!203 = !{!86, !160, !204, !86, !92}
!204 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !205)
!205 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!206 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !207, file: !30, line: 190)
!207 = !DISubprogram(name: "wcsspn", scope: !36, file: !36, line: 216, type: !176, flags: DIFlagPrototyped, spFlags: 0)
!208 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !209, file: !30, line: 191)
!209 = !DISubprogram(name: "wcstod", scope: !36, file: !36, line: 402, type: !210, flags: DIFlagPrototyped, spFlags: 0)
!210 = !DISubroutineType(types: !211)
!211 = !{!212, !63, !213}
!212 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!213 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !214)
!214 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 64)
!215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !216, file: !30, line: 193)
!216 = !DISubprogram(name: "wcstof", scope: !36, file: !36, line: 407, type: !217, flags: DIFlagPrototyped, spFlags: 0)
!217 = !DISubroutineType(types: !218)
!218 = !{!219, !63, !213}
!219 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !221, file: !30, line: 195)
!221 = !DISubprogram(name: "wcstok", scope: !36, file: !36, line: 242, type: !222, flags: DIFlagPrototyped, spFlags: 0)
!222 = !DISubroutineType(types: !223)
!223 = !{!51, !53, !63, !213}
!224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !225, file: !30, line: 196)
!225 = !DISubprogram(name: "wcstol", linkageName: "__isoc23_wcstol", scope: !36, file: !36, line: 500, type: !226, flags: DIFlagPrototyped, spFlags: 0)
!226 = !DISubroutineType(types: !227)
!227 = !{!228, !63, !213, !9}
!228 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!229 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !230, file: !30, line: 197)
!230 = !DISubprogram(name: "wcstoul", linkageName: "__isoc23_wcstoul", scope: !36, file: !36, line: 503, type: !231, flags: DIFlagPrototyped, spFlags: 0)
!231 = !DISubroutineType(types: !232)
!232 = !{!88, !63, !213, !9}
!233 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !234, file: !30, line: 198)
!234 = !DISubprogram(name: "wcsxfrm", scope: !36, file: !36, line: 159, type: !235, flags: DIFlagPrototyped, spFlags: 0)
!235 = !DISubroutineType(types: !236)
!236 = !{!86, !53, !63, !86}
!237 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !238, file: !30, line: 199)
!238 = !DISubprogram(name: "wctob", scope: !36, file: !36, line: 313, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!239 = !DISubroutineType(types: !240)
!240 = !{!9, !32}
!241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !242, file: !30, line: 200)
!242 = !DISubprogram(name: "wmemcmp", scope: !36, file: !36, line: 283, type: !196, flags: DIFlagPrototyped, spFlags: 0)
!243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !244, file: !30, line: 201)
!244 = !DISubprogram(name: "wmemcpy", scope: !36, file: !36, line: 287, type: !192, flags: DIFlagPrototyped, spFlags: 0)
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !246, file: !30, line: 202)
!246 = !DISubprogram(name: "wmemmove", scope: !36, file: !36, line: 292, type: !247, flags: DIFlagPrototyped, spFlags: 0)
!247 = !DISubroutineType(types: !248)
!248 = !{!51, !51, !64, !86}
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !250, file: !30, line: 203)
!250 = !DISubprogram(name: "wmemset", scope: !36, file: !36, line: 296, type: !251, flags: DIFlagPrototyped, spFlags: 0)
!251 = !DISubroutineType(types: !252)
!252 = !{!51, !51, !52, !86}
!253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !254, file: !30, line: 204)
!254 = !DISubprogram(name: "wprintf", scope: !36, file: !36, line: 739, type: !255, flags: DIFlagPrototyped, spFlags: 0)
!255 = !DISubroutineType(types: !256)
!256 = !{!9, !63, null}
!257 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !258, file: !30, line: 205)
!258 = !DISubprogram(name: "wscanf", linkageName: "__isoc23_wscanf", scope: !36, file: !36, line: 799, type: !255, flags: DIFlagPrototyped, spFlags: 0)
!259 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !260, file: !30, line: 206)
!260 = !DISubprogram(name: "wcschr", scope: !36, file: !36, line: 189, type: !261, flags: DIFlagPrototyped, spFlags: 0)
!261 = !DISubroutineType(types: !262)
!262 = !{!51, !64, !52}
!263 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !264, file: !30, line: 207)
!264 = !DISubprogram(name: "wcspbrk", scope: !36, file: !36, line: 226, type: !265, flags: DIFlagPrototyped, spFlags: 0)
!265 = !DISubroutineType(types: !266)
!266 = !{!51, !64, !64}
!267 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !268, file: !30, line: 208)
!268 = !DISubprogram(name: "wcsrchr", scope: !36, file: !36, line: 199, type: !261, flags: DIFlagPrototyped, spFlags: 0)
!269 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !270, file: !30, line: 209)
!270 = !DISubprogram(name: "wcsstr", scope: !36, file: !36, line: 237, type: !265, flags: DIFlagPrototyped, spFlags: 0)
!271 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !272, file: !30, line: 210)
!272 = !DISubprogram(name: "wmemchr", scope: !36, file: !36, line: 278, type: !273, flags: DIFlagPrototyped, spFlags: 0)
!273 = !DISubroutineType(types: !274)
!274 = !{!51, !64, !52, !86}
!275 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !277, file: !30, line: 251)
!276 = !DINamespace(name: "__gnu_cxx", scope: null)
!277 = !DISubprogram(name: "wcstold", scope: !36, file: !36, line: 409, type: !278, flags: DIFlagPrototyped, spFlags: 0)
!278 = !DISubroutineType(types: !279)
!279 = !{!280, !63, !213}
!280 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!281 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !282, file: !30, line: 260)
!282 = !DISubprogram(name: "wcstoll", linkageName: "__isoc23_wcstoll", scope: !36, file: !36, line: 508, type: !283, flags: DIFlagPrototyped, spFlags: 0)
!283 = !DISubroutineType(types: !284)
!284 = !{!285, !63, !213, !9}
!285 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!286 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !287, file: !30, line: 261)
!287 = !DISubprogram(name: "wcstoull", linkageName: "__isoc23_wcstoull", scope: !36, file: !36, line: 513, type: !288, flags: DIFlagPrototyped, spFlags: 0)
!288 = !DISubroutineType(types: !289)
!289 = !{!290, !63, !213, !9}
!290 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!291 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !277, file: !30, line: 267)
!292 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !282, file: !30, line: 268)
!293 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !287, file: !30, line: 269)
!294 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !216, file: !30, line: 283)
!295 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !141, file: !30, line: 286)
!296 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !147, file: !30, line: 289)
!297 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !155, file: !30, line: 292)
!298 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !277, file: !30, line: 296)
!299 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !282, file: !30, line: 297)
!300 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !287, file: !30, line: 298)
!301 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !302, file: !303, line: 66)
!302 = !DICompositeType(tag: DW_TAG_class_type, name: "exception_ptr", scope: !304, file: !303, line: 97, size: 64, flags: DIFlagFwdDecl | DIFlagNonTrivial, identifier: "_ZTSNSt15__exception_ptr13exception_ptrE")
!303 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/exception_ptr.h", directory: "", checksumkind: CSK_MD5, checksum: "314ad14748ccb9ff85c65d17ebb0828b")
!304 = !DINamespace(name: "__exception_ptr", scope: !12)
!305 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !304, entity: !306, file: !303, line: 85)
!306 = !DISubprogram(name: "rethrow_exception", linkageName: "_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE", scope: !12, file: !303, line: 81, type: !307, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!307 = !DISubroutineType(types: !308)
!308 = !{null, !302}
!309 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !310, file: !303, line: 243)
!310 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__exception_ptr4swapERNS_13exception_ptrES1_", scope: !304, file: !303, line: 230, type: !311, flags: DIFlagPrototyped, spFlags: 0)
!311 = !DISubroutineType(types: !312)
!312 = !{null, !313, !313}
!313 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !302, size: 64)
!314 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !315, file: !317, line: 53)
!315 = !DICompositeType(tag: DW_TAG_structure_type, name: "lconv", file: !316, line: 51, size: 768, flags: DIFlagFwdDecl, identifier: "_ZTS5lconv")
!316 = !DIFile(filename: "/usr/include/locale.h", directory: "", checksumkind: CSK_MD5, checksum: "23ebf40dea0ab9a74daf64a0eaa99518")
!317 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/clocale", directory: "")
!318 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !319, file: !317, line: 54)
!319 = !DISubprogram(name: "setlocale", scope: !316, file: !316, line: 122, type: !320, flags: DIFlagPrototyped, spFlags: 0)
!320 = !DISubroutineType(types: !321)
!321 = !{!161, !9, !90}
!322 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !323, file: !317, line: 55)
!323 = !DISubprogram(name: "localeconv", scope: !316, file: !316, line: 125, type: !324, flags: DIFlagPrototyped, spFlags: 0)
!324 = !DISubroutineType(types: !325)
!325 = !{!326}
!326 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !315, size: 64)
!327 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !328, file: !332, line: 64)
!328 = !DISubprogram(name: "isalnum", scope: !329, file: !329, line: 108, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!329 = !DIFile(filename: "/usr/include/ctype.h", directory: "", checksumkind: CSK_MD5, checksum: "43fd45dcf96e8fb7d8f14700096497c7")
!330 = !DISubroutineType(types: !331)
!331 = !{!9, !9}
!332 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/cctype", directory: "")
!333 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !334, file: !332, line: 65)
!334 = !DISubprogram(name: "isalpha", scope: !329, file: !329, line: 109, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!335 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !336, file: !332, line: 66)
!336 = !DISubprogram(name: "iscntrl", scope: !329, file: !329, line: 110, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!337 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !338, file: !332, line: 67)
!338 = !DISubprogram(name: "isdigit", scope: !329, file: !329, line: 111, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!339 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !340, file: !332, line: 68)
!340 = !DISubprogram(name: "isgraph", scope: !329, file: !329, line: 113, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!341 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !342, file: !332, line: 69)
!342 = !DISubprogram(name: "islower", scope: !329, file: !329, line: 112, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !344, file: !332, line: 70)
!344 = !DISubprogram(name: "isprint", scope: !329, file: !329, line: 114, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!345 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !346, file: !332, line: 71)
!346 = !DISubprogram(name: "ispunct", scope: !329, file: !329, line: 115, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!347 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !348, file: !332, line: 72)
!348 = !DISubprogram(name: "isspace", scope: !329, file: !329, line: 116, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!349 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !350, file: !332, line: 73)
!350 = !DISubprogram(name: "isupper", scope: !329, file: !329, line: 117, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!351 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !352, file: !332, line: 74)
!352 = !DISubprogram(name: "isxdigit", scope: !329, file: !329, line: 118, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!353 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !354, file: !332, line: 75)
!354 = !DISubprogram(name: "tolower", scope: !329, file: !329, line: 122, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!355 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !356, file: !332, line: 76)
!356 = !DISubprogram(name: "toupper", scope: !329, file: !329, line: 125, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!357 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !358, file: !332, line: 87)
!358 = !DISubprogram(name: "isblank", scope: !329, file: !329, line: 130, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!359 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !360, entity: !361, file: !362, line: 58)
!360 = !DINamespace(name: "__gnu_debug", scope: null)
!361 = !DINamespace(name: "__debug", scope: !12)
!362 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/debug/debug.h", directory: "", checksumkind: CSK_MD5, checksum: "752210a319f5f5d356cc29cd1ce3cdc7")
!363 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !364, file: !366, line: 52)
!364 = !DISubprogram(name: "abs", scope: !365, file: !365, line: 980, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!365 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "7fa2ecb2348a66f8b44ab9a15abd0b72")
!366 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/bits/std_abs.h", directory: "")
!367 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !368, file: !370, line: 131)
!368 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !365, line: 63, baseType: !369)
!369 = !DICompositeType(tag: DW_TAG_structure_type, file: !365, line: 59, size: 64, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!370 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/cstdlib", directory: "")
!371 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !372, file: !370, line: 132)
!372 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !365, line: 71, baseType: !373)
!373 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !365, line: 67, size: 128, flags: DIFlagTypePassByValue, elements: !374, identifier: "_ZTS6ldiv_t")
!374 = !{!375, !376}
!375 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !373, file: !365, line: 69, baseType: !228, size: 64)
!376 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !373, file: !365, line: 70, baseType: !228, size: 64, offset: 64)
!377 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !378, file: !370, line: 134)
!378 = !DISubprogram(name: "abort", scope: !365, file: !365, line: 730, type: !379, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!379 = !DISubroutineType(types: !380)
!380 = !{null}
!381 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !382, file: !370, line: 136)
!382 = !DISubprogram(name: "aligned_alloc", scope: !365, file: !365, line: 724, type: !383, flags: DIFlagPrototyped, spFlags: 0)
!383 = !DISubroutineType(types: !384)
!384 = !{!138, !86, !86}
!385 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !386, file: !370, line: 138)
!386 = !DISubprogram(name: "atexit", scope: !365, file: !365, line: 734, type: !387, flags: DIFlagPrototyped, spFlags: 0)
!387 = !DISubroutineType(types: !388)
!388 = !{!9, !389}
!389 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !379, size: 64)
!390 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !391, file: !370, line: 141)
!391 = !DISubprogram(name: "at_quick_exit", scope: !365, file: !365, line: 739, type: !387, flags: DIFlagPrototyped, spFlags: 0)
!392 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !393, file: !370, line: 144)
!393 = !DISubprogram(name: "atof", scope: !365, file: !365, line: 102, type: !394, flags: DIFlagPrototyped, spFlags: 0)
!394 = !DISubroutineType(types: !395)
!395 = !{!212, !90}
!396 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !397, file: !370, line: 145)
!397 = !DISubprogram(name: "atoi", scope: !365, file: !365, line: 105, type: !398, flags: DIFlagPrototyped, spFlags: 0)
!398 = !DISubroutineType(types: !399)
!399 = !{!9, !90}
!400 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !401, file: !370, line: 146)
!401 = !DISubprogram(name: "atol", scope: !365, file: !365, line: 108, type: !402, flags: DIFlagPrototyped, spFlags: 0)
!402 = !DISubroutineType(types: !403)
!403 = !{!228, !90}
!404 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !405, file: !370, line: 147)
!405 = !DISubprogram(name: "bsearch", scope: !365, file: !365, line: 960, type: !406, flags: DIFlagPrototyped, spFlags: 0)
!406 = !DISubroutineType(types: !407)
!407 = !{!138, !408, !408, !86, !86, !410}
!408 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !409, size: 64)
!409 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!410 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !365, line: 948, baseType: !411)
!411 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !412, size: 64)
!412 = !DISubroutineType(types: !413)
!413 = !{!9, !408, !408}
!414 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !415, file: !370, line: 148)
!415 = !DISubprogram(name: "calloc", scope: !365, file: !365, line: 675, type: !383, flags: DIFlagPrototyped, spFlags: 0)
!416 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !417, file: !370, line: 149)
!417 = !DISubprogram(name: "div", scope: !365, file: !365, line: 992, type: !418, flags: DIFlagPrototyped, spFlags: 0)
!418 = !DISubroutineType(types: !419)
!419 = !{!368, !9, !9}
!420 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !421, file: !370, line: 150)
!421 = !DISubprogram(name: "exit", scope: !365, file: !365, line: 756, type: !422, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!422 = !DISubroutineType(types: !423)
!423 = !{null, !9}
!424 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !425, file: !370, line: 151)
!425 = !DISubprogram(name: "free", scope: !365, file: !365, line: 687, type: !426, flags: DIFlagPrototyped, spFlags: 0)
!426 = !DISubroutineType(types: !427)
!427 = !{null, !138}
!428 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !429, file: !370, line: 152)
!429 = !DISubprogram(name: "getenv", scope: !365, file: !365, line: 773, type: !430, flags: DIFlagPrototyped, spFlags: 0)
!430 = !DISubroutineType(types: !431)
!431 = !{!161, !90}
!432 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !433, file: !370, line: 153)
!433 = !DISubprogram(name: "labs", scope: !365, file: !365, line: 981, type: !434, flags: DIFlagPrototyped, spFlags: 0)
!434 = !DISubroutineType(types: !435)
!435 = !{!228, !228}
!436 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !437, file: !370, line: 154)
!437 = !DISubprogram(name: "ldiv", scope: !365, file: !365, line: 994, type: !438, flags: DIFlagPrototyped, spFlags: 0)
!438 = !DISubroutineType(types: !439)
!439 = !{!372, !228, !228}
!440 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !441, file: !370, line: 155)
!441 = !DISubprogram(name: "malloc", scope: !365, file: !365, line: 672, type: !442, flags: DIFlagPrototyped, spFlags: 0)
!442 = !DISubroutineType(types: !443)
!443 = !{!138, !86}
!444 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !445, file: !370, line: 157)
!445 = !DISubprogram(name: "mblen", scope: !365, file: !365, line: 1062, type: !446, flags: DIFlagPrototyped, spFlags: 0)
!446 = !DISubroutineType(types: !447)
!447 = !{!9, !90, !86}
!448 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !449, file: !370, line: 158)
!449 = !DISubprogram(name: "mbstowcs", scope: !365, file: !365, line: 1073, type: !450, flags: DIFlagPrototyped, spFlags: 0)
!450 = !DISubroutineType(types: !451)
!451 = !{!86, !53, !89, !86}
!452 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !453, file: !370, line: 159)
!453 = !DISubprogram(name: "mbtowc", scope: !365, file: !365, line: 1065, type: !454, flags: DIFlagPrototyped, spFlags: 0)
!454 = !DISubroutineType(types: !455)
!455 = !{!9, !53, !89, !86}
!456 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !457, file: !370, line: 161)
!457 = !DISubprogram(name: "qsort", scope: !365, file: !365, line: 970, type: !458, flags: DIFlagPrototyped, spFlags: 0)
!458 = !DISubroutineType(types: !459)
!459 = !{null, !138, !86, !86, !410}
!460 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !461, file: !370, line: 164)
!461 = !DISubprogram(name: "quick_exit", scope: !365, file: !365, line: 762, type: !422, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !463, file: !370, line: 167)
!463 = !DISubprogram(name: "rand", scope: !365, file: !365, line: 573, type: !464, flags: DIFlagPrototyped, spFlags: 0)
!464 = !DISubroutineType(types: !465)
!465 = !{!9}
!466 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !467, file: !370, line: 168)
!467 = !DISubprogram(name: "realloc", scope: !365, file: !365, line: 683, type: !468, flags: DIFlagPrototyped, spFlags: 0)
!468 = !DISubroutineType(types: !469)
!469 = !{!138, !138, !86}
!470 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !471, file: !370, line: 169)
!471 = !DISubprogram(name: "srand", scope: !365, file: !365, line: 575, type: !472, flags: DIFlagPrototyped, spFlags: 0)
!472 = !DISubroutineType(types: !473)
!473 = !{null, !24}
!474 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !475, file: !370, line: 170)
!475 = !DISubprogram(name: "strtod", scope: !365, file: !365, line: 118, type: !476, flags: DIFlagPrototyped, spFlags: 0)
!476 = !DISubroutineType(types: !477)
!477 = !{!212, !89, !478}
!478 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !479)
!479 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !161, size: 64)
!480 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !481, file: !370, line: 171)
!481 = !DISubprogram(name: "strtol", linkageName: "__isoc23_strtol", scope: !365, file: !365, line: 215, type: !482, flags: DIFlagPrototyped, spFlags: 0)
!482 = !DISubroutineType(types: !483)
!483 = !{!228, !89, !478, !9}
!484 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !485, file: !370, line: 172)
!485 = !DISubprogram(name: "strtoul", linkageName: "__isoc23_strtoul", scope: !365, file: !365, line: 219, type: !486, flags: DIFlagPrototyped, spFlags: 0)
!486 = !DISubroutineType(types: !487)
!487 = !{!88, !89, !478, !9}
!488 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !489, file: !370, line: 173)
!489 = !DISubprogram(name: "system", scope: !365, file: !365, line: 923, type: !398, flags: DIFlagPrototyped, spFlags: 0)
!490 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !491, file: !370, line: 175)
!491 = !DISubprogram(name: "wcstombs", scope: !365, file: !365, line: 1077, type: !492, flags: DIFlagPrototyped, spFlags: 0)
!492 = !DISubroutineType(types: !493)
!493 = !{!86, !160, !63, !86}
!494 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !495, file: !370, line: 176)
!495 = !DISubprogram(name: "wctomb", scope: !365, file: !365, line: 1069, type: !496, flags: DIFlagPrototyped, spFlags: 0)
!496 = !DISubroutineType(types: !497)
!497 = !{!9, !161, !52}
!498 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !499, file: !370, line: 204)
!499 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !365, line: 81, baseType: !500)
!500 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !365, line: 77, size: 128, flags: DIFlagTypePassByValue, elements: !501, identifier: "_ZTS7lldiv_t")
!501 = !{!502, !503}
!502 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !500, file: !365, line: 79, baseType: !285, size: 64)
!503 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !500, file: !365, line: 80, baseType: !285, size: 64, offset: 64)
!504 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !505, file: !370, line: 210)
!505 = !DISubprogram(name: "_Exit", scope: !365, file: !365, line: 768, type: !422, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!506 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !507, file: !370, line: 214)
!507 = !DISubprogram(name: "llabs", scope: !365, file: !365, line: 984, type: !508, flags: DIFlagPrototyped, spFlags: 0)
!508 = !DISubroutineType(types: !509)
!509 = !{!285, !285}
!510 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !511, file: !370, line: 220)
!511 = !DISubprogram(name: "lldiv", scope: !365, file: !365, line: 998, type: !512, flags: DIFlagPrototyped, spFlags: 0)
!512 = !DISubroutineType(types: !513)
!513 = !{!499, !285, !285}
!514 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !515, file: !370, line: 231)
!515 = !DISubprogram(name: "atoll", scope: !365, file: !365, line: 113, type: !516, flags: DIFlagPrototyped, spFlags: 0)
!516 = !DISubroutineType(types: !517)
!517 = !{!285, !90}
!518 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !519, file: !370, line: 232)
!519 = !DISubprogram(name: "strtoll", linkageName: "__isoc23_strtoll", scope: !365, file: !365, line: 238, type: !520, flags: DIFlagPrototyped, spFlags: 0)
!520 = !DISubroutineType(types: !521)
!521 = !{!285, !89, !478, !9}
!522 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !523, file: !370, line: 233)
!523 = !DISubprogram(name: "strtoull", linkageName: "__isoc23_strtoull", scope: !365, file: !365, line: 243, type: !524, flags: DIFlagPrototyped, spFlags: 0)
!524 = !DISubroutineType(types: !525)
!525 = !{!290, !89, !478, !9}
!526 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !527, file: !370, line: 235)
!527 = !DISubprogram(name: "strtof", scope: !365, file: !365, line: 124, type: !528, flags: DIFlagPrototyped, spFlags: 0)
!528 = !DISubroutineType(types: !529)
!529 = !{!219, !89, !478}
!530 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !531, file: !370, line: 236)
!531 = !DISubprogram(name: "strtold", scope: !365, file: !365, line: 127, type: !532, flags: DIFlagPrototyped, spFlags: 0)
!532 = !DISubroutineType(types: !533)
!533 = !{!280, !89, !478}
!534 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !499, file: !370, line: 244)
!535 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !505, file: !370, line: 246)
!536 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !507, file: !370, line: 248)
!537 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !538, file: !370, line: 249)
!538 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !276, file: !370, line: 217, type: !512, flags: DIFlagPrototyped, spFlags: 0)
!539 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !511, file: !370, line: 250)
!540 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !515, file: !370, line: 252)
!541 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !527, file: !370, line: 253)
!542 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !519, file: !370, line: 254)
!543 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !523, file: !370, line: 255)
!544 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !531, file: !370, line: 256)
!545 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !546, file: !548, line: 98)
!546 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !547, line: 7, baseType: !46)
!547 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "", checksumkind: CSK_MD5, checksum: "571f9fb6223c42439075fdde11a0de5d")
!548 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/cstdio", directory: "")
!549 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !550, file: !548, line: 99)
!550 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpos_t", file: !551, line: 85, baseType: !552)
!551 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "1e435c46987a169d9f9186f63a512303")
!552 = !DIDerivedType(tag: DW_TAG_typedef, name: "__fpos_t", file: !553, line: 14, baseType: !554)
!553 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__fpos_t.h", directory: "", checksumkind: CSK_MD5, checksum: "32de8bdaf3551a6c0a9394f9af4389ce")
!554 = !DICompositeType(tag: DW_TAG_structure_type, name: "_G_fpos_t", file: !553, line: 10, size: 128, flags: DIFlagFwdDecl, identifier: "_ZTS9_G_fpos_t")
!555 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !556, file: !548, line: 101)
!556 = !DISubprogram(name: "clearerr", scope: !551, file: !551, line: 860, type: !557, flags: DIFlagPrototyped, spFlags: 0)
!557 = !DISubroutineType(types: !558)
!558 = !{null, !559}
!559 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !546, size: 64)
!560 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !561, file: !548, line: 102)
!561 = !DISubprogram(name: "fclose", scope: !551, file: !551, line: 184, type: !562, flags: DIFlagPrototyped, spFlags: 0)
!562 = !DISubroutineType(types: !563)
!563 = !{!9, !559}
!564 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !565, file: !548, line: 103)
!565 = !DISubprogram(name: "feof", scope: !551, file: !551, line: 862, type: !562, flags: DIFlagPrototyped, spFlags: 0)
!566 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !567, file: !548, line: 104)
!567 = !DISubprogram(name: "ferror", scope: !551, file: !551, line: 864, type: !562, flags: DIFlagPrototyped, spFlags: 0)
!568 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !569, file: !548, line: 105)
!569 = !DISubprogram(name: "fflush", scope: !551, file: !551, line: 236, type: !562, flags: DIFlagPrototyped, spFlags: 0)
!570 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !571, file: !548, line: 106)
!571 = !DISubprogram(name: "fgetc", scope: !551, file: !551, line: 575, type: !562, flags: DIFlagPrototyped, spFlags: 0)
!572 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !573, file: !548, line: 107)
!573 = !DISubprogram(name: "fgetpos", scope: !551, file: !551, line: 829, type: !574, flags: DIFlagPrototyped, spFlags: 0)
!574 = !DISubroutineType(types: !575)
!575 = !{!9, !576, !577}
!576 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !559)
!577 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !578)
!578 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !550, size: 64)
!579 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !580, file: !548, line: 108)
!580 = !DISubprogram(name: "fgets", scope: !551, file: !551, line: 654, type: !581, flags: DIFlagPrototyped, spFlags: 0)
!581 = !DISubroutineType(types: !582)
!582 = !{!161, !160, !9, !576}
!583 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !584, file: !548, line: 109)
!584 = !DISubprogram(name: "fopen", scope: !551, file: !551, line: 264, type: !585, flags: DIFlagPrototyped, spFlags: 0)
!585 = !DISubroutineType(types: !586)
!586 = !{!559, !89, !89}
!587 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !588, file: !548, line: 110)
!588 = !DISubprogram(name: "fprintf", scope: !551, file: !551, line: 357, type: !589, flags: DIFlagPrototyped, spFlags: 0)
!589 = !DISubroutineType(types: !590)
!590 = !{!9, !576, !89, null}
!591 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !592, file: !548, line: 111)
!592 = !DISubprogram(name: "fputc", scope: !551, file: !551, line: 611, type: !593, flags: DIFlagPrototyped, spFlags: 0)
!593 = !DISubroutineType(types: !594)
!594 = !{!9, !9, !559}
!595 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !596, file: !548, line: 112)
!596 = !DISubprogram(name: "fputs", scope: !551, file: !551, line: 717, type: !597, flags: DIFlagPrototyped, spFlags: 0)
!597 = !DISubroutineType(types: !598)
!598 = !{!9, !89, !576}
!599 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !600, file: !548, line: 113)
!600 = !DISubprogram(name: "fread", scope: !551, file: !551, line: 738, type: !601, flags: DIFlagPrototyped, spFlags: 0)
!601 = !DISubroutineType(types: !602)
!602 = !{!86, !603, !86, !86, !576}
!603 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !138)
!604 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !605, file: !548, line: 114)
!605 = !DISubprogram(name: "freopen", scope: !551, file: !551, line: 271, type: !606, flags: DIFlagPrototyped, spFlags: 0)
!606 = !DISubroutineType(types: !607)
!607 = !{!559, !89, !89, !576}
!608 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !609, file: !548, line: 115)
!609 = !DISubprogram(name: "fscanf", linkageName: "__isoc23_fscanf", scope: !551, file: !551, line: 442, type: !589, flags: DIFlagPrototyped, spFlags: 0)
!610 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !611, file: !548, line: 116)
!611 = !DISubprogram(name: "fseek", scope: !551, file: !551, line: 779, type: !612, flags: DIFlagPrototyped, spFlags: 0)
!612 = !DISubroutineType(types: !613)
!613 = !{!9, !559, !228, !9}
!614 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !615, file: !548, line: 117)
!615 = !DISubprogram(name: "fsetpos", scope: !551, file: !551, line: 835, type: !616, flags: DIFlagPrototyped, spFlags: 0)
!616 = !DISubroutineType(types: !617)
!617 = !{!9, !559, !618}
!618 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !619, size: 64)
!619 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !550)
!620 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !621, file: !548, line: 118)
!621 = !DISubprogram(name: "ftell", scope: !551, file: !551, line: 785, type: !622, flags: DIFlagPrototyped, spFlags: 0)
!622 = !DISubroutineType(types: !623)
!623 = !{!228, !559}
!624 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !625, file: !548, line: 119)
!625 = !DISubprogram(name: "fwrite", scope: !551, file: !551, line: 745, type: !626, flags: DIFlagPrototyped, spFlags: 0)
!626 = !DISubroutineType(types: !627)
!627 = !{!86, !628, !86, !86, !576}
!628 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !408)
!629 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !630, file: !548, line: 120)
!630 = !DISubprogram(name: "getc", scope: !551, file: !551, line: 576, type: !562, flags: DIFlagPrototyped, spFlags: 0)
!631 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !632, file: !548, line: 121)
!632 = !DISubprogram(name: "getchar", scope: !551, file: !551, line: 582, type: !464, flags: DIFlagPrototyped, spFlags: 0)
!633 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !634, file: !548, line: 126)
!634 = !DISubprogram(name: "perror", scope: !551, file: !551, line: 878, type: !635, flags: DIFlagPrototyped, spFlags: 0)
!635 = !DISubroutineType(types: !636)
!636 = !{null, !90}
!637 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !638, file: !548, line: 127)
!638 = !DISubprogram(name: "printf", scope: !551, file: !551, line: 363, type: !639, flags: DIFlagPrototyped, spFlags: 0)
!639 = !DISubroutineType(types: !640)
!640 = !{!9, !89, null}
!641 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !642, file: !548, line: 128)
!642 = !DISubprogram(name: "putc", scope: !551, file: !551, line: 612, type: !593, flags: DIFlagPrototyped, spFlags: 0)
!643 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !644, file: !548, line: 129)
!644 = !DISubprogram(name: "putchar", scope: !551, file: !551, line: 618, type: !330, flags: DIFlagPrototyped, spFlags: 0)
!645 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !646, file: !548, line: 130)
!646 = !DISubprogram(name: "puts", scope: !551, file: !551, line: 724, type: !398, flags: DIFlagPrototyped, spFlags: 0)
!647 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !648, file: !548, line: 131)
!648 = !DISubprogram(name: "remove", scope: !551, file: !551, line: 158, type: !398, flags: DIFlagPrototyped, spFlags: 0)
!649 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !650, file: !548, line: 132)
!650 = !DISubprogram(name: "rename", scope: !551, file: !551, line: 160, type: !651, flags: DIFlagPrototyped, spFlags: 0)
!651 = !DISubroutineType(types: !652)
!652 = !{!9, !90, !90}
!653 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !654, file: !548, line: 133)
!654 = !DISubprogram(name: "rewind", scope: !551, file: !551, line: 790, type: !557, flags: DIFlagPrototyped, spFlags: 0)
!655 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !656, file: !548, line: 134)
!656 = !DISubprogram(name: "scanf", linkageName: "__isoc23_scanf", scope: !551, file: !551, line: 445, type: !639, flags: DIFlagPrototyped, spFlags: 0)
!657 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !658, file: !548, line: 135)
!658 = !DISubprogram(name: "setbuf", scope: !551, file: !551, line: 334, type: !659, flags: DIFlagPrototyped, spFlags: 0)
!659 = !DISubroutineType(types: !660)
!660 = !{null, !576, !160}
!661 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !662, file: !548, line: 136)
!662 = !DISubprogram(name: "setvbuf", scope: !551, file: !551, line: 339, type: !663, flags: DIFlagPrototyped, spFlags: 0)
!663 = !DISubroutineType(types: !664)
!664 = !{!9, !576, !160, !9, !86}
!665 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !666, file: !548, line: 137)
!666 = !DISubprogram(name: "sprintf", scope: !551, file: !551, line: 365, type: !667, flags: DIFlagPrototyped, spFlags: 0)
!667 = !DISubroutineType(types: !668)
!668 = !{!9, !160, !89, null}
!669 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !670, file: !548, line: 138)
!670 = !DISubprogram(name: "sscanf", linkageName: "__isoc23_sscanf", scope: !551, file: !551, line: 447, type: !671, flags: DIFlagPrototyped, spFlags: 0)
!671 = !DISubroutineType(types: !672)
!672 = !{!9, !89, !89, null}
!673 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !674, file: !548, line: 139)
!674 = !DISubprogram(name: "tmpfile", scope: !551, file: !551, line: 194, type: !675, flags: DIFlagPrototyped, spFlags: 0)
!675 = !DISubroutineType(types: !676)
!676 = !{!559}
!677 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !678, file: !548, line: 141)
!678 = !DISubprogram(name: "tmpnam", scope: !551, file: !551, line: 211, type: !679, flags: DIFlagPrototyped, spFlags: 0)
!679 = !DISubroutineType(types: !680)
!680 = !{!161, !161}
!681 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !682, file: !548, line: 143)
!682 = !DISubprogram(name: "ungetc", scope: !551, file: !551, line: 731, type: !593, flags: DIFlagPrototyped, spFlags: 0)
!683 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !684, file: !548, line: 144)
!684 = !DISubprogram(name: "vfprintf", scope: !551, file: !551, line: 372, type: !685, flags: DIFlagPrototyped, spFlags: 0)
!685 = !DISubroutineType(types: !686)
!686 = !{!9, !576, !89, !132}
!687 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !688, file: !548, line: 145)
!688 = !DISubprogram(name: "vprintf", scope: !551, file: !551, line: 378, type: !689, flags: DIFlagPrototyped, spFlags: 0)
!689 = !DISubroutineType(types: !690)
!690 = !{!9, !89, !132}
!691 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !692, file: !548, line: 146)
!692 = !DISubprogram(name: "vsprintf", scope: !551, file: !551, line: 380, type: !693, flags: DIFlagPrototyped, spFlags: 0)
!693 = !DISubroutineType(types: !694)
!694 = !{!9, !160, !89, !132}
!695 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !696, file: !548, line: 175)
!696 = !DISubprogram(name: "snprintf", scope: !551, file: !551, line: 385, type: !697, flags: DIFlagPrototyped, spFlags: 0)
!697 = !DISubroutineType(types: !698)
!698 = !{!9, !160, !86, !89, null}
!699 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !700, file: !548, line: 176)
!700 = !DISubprogram(name: "vfscanf", linkageName: "__isoc23_vfscanf", scope: !551, file: !551, line: 511, type: !685, flags: DIFlagPrototyped, spFlags: 0)
!701 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !702, file: !548, line: 177)
!702 = !DISubprogram(name: "vscanf", linkageName: "__isoc23_vscanf", scope: !551, file: !551, line: 516, type: !689, flags: DIFlagPrototyped, spFlags: 0)
!703 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !704, file: !548, line: 178)
!704 = !DISubprogram(name: "vsnprintf", scope: !551, file: !551, line: 389, type: !705, flags: DIFlagPrototyped, spFlags: 0)
!705 = !DISubroutineType(types: !706)
!706 = !{!9, !160, !86, !89, !132}
!707 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !276, entity: !708, file: !548, line: 179)
!708 = !DISubprogram(name: "vsscanf", linkageName: "__isoc23_vsscanf", scope: !551, file: !551, line: 519, type: !709, flags: DIFlagPrototyped, spFlags: 0)
!709 = !DISubroutineType(types: !710)
!710 = !{!9, !89, !89, !132}
!711 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !696, file: !548, line: 185)
!712 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !700, file: !548, line: 186)
!713 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !702, file: !548, line: 187)
!714 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !704, file: !548, line: 188)
!715 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !708, file: !548, line: 189)
!716 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !717, file: !723, line: 58)
!717 = !DIDerivedType(tag: DW_TAG_typedef, name: "max_align_t", file: !718, line: 24, baseType: !719)
!718 = !DIFile(filename: "/usr/lib/llvm-17/lib/clang/17/include/__stddef_max_align_t.h", directory: "", checksumkind: CSK_MD5, checksum: "48e8e2456f77e6cda35d245130fa7259")
!719 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !718, line: 19, size: 256, flags: DIFlagTypePassByValue, elements: !720, identifier: "_ZTS11max_align_t")
!720 = !{!721, !722}
!721 = !DIDerivedType(tag: DW_TAG_member, name: "__clang_max_align_nonce1", scope: !719, file: !718, line: 20, baseType: !285, size: 64, align: 64)
!722 = !DIDerivedType(tag: DW_TAG_member, name: "__clang_max_align_nonce2", scope: !719, file: !718, line: 22, baseType: !280, size: 128, align: 128, offset: 128)
!723 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/cstddef", directory: "")
!724 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !725, file: !731, line: 82)
!725 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctrans_t", file: !726, line: 48, baseType: !727)
!726 = !DIFile(filename: "/usr/include/wctype.h", directory: "", checksumkind: CSK_MD5, checksum: "eff95da6508e8f67a3c7b77d9d8ab229")
!727 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !728, size: 64)
!728 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !729)
!729 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !730, line: 41, baseType: !9)
!730 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!731 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/cwctype", directory: "")
!732 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !733, file: !731, line: 83)
!733 = !DIDerivedType(tag: DW_TAG_typedef, name: "wctype_t", file: !734, line: 38, baseType: !88)
!734 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/wctype-wchar.h", directory: "", checksumkind: CSK_MD5, checksum: "7f19501745f9a1fbbace8f0f185de59a")
!735 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !32, file: !731, line: 84)
!736 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !737, file: !731, line: 86)
!737 = !DISubprogram(name: "iswalnum", scope: !734, file: !734, line: 95, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!738 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !739, file: !731, line: 87)
!739 = !DISubprogram(name: "iswalpha", scope: !734, file: !734, line: 101, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!740 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !741, file: !731, line: 89)
!741 = !DISubprogram(name: "iswblank", scope: !734, file: !734, line: 146, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!742 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !743, file: !731, line: 91)
!743 = !DISubprogram(name: "iswcntrl", scope: !734, file: !734, line: 104, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!744 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !745, file: !731, line: 92)
!745 = !DISubprogram(name: "iswctype", scope: !734, file: !734, line: 159, type: !746, flags: DIFlagPrototyped, spFlags: 0)
!746 = !DISubroutineType(types: !747)
!747 = !{!9, !32, !733}
!748 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !749, file: !731, line: 93)
!749 = !DISubprogram(name: "iswdigit", scope: !734, file: !734, line: 108, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!750 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !751, file: !731, line: 94)
!751 = !DISubprogram(name: "iswgraph", scope: !734, file: !734, line: 112, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!752 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !753, file: !731, line: 95)
!753 = !DISubprogram(name: "iswlower", scope: !734, file: !734, line: 117, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!754 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !755, file: !731, line: 96)
!755 = !DISubprogram(name: "iswprint", scope: !734, file: !734, line: 120, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!756 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !757, file: !731, line: 97)
!757 = !DISubprogram(name: "iswpunct", scope: !734, file: !734, line: 125, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!758 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !759, file: !731, line: 98)
!759 = !DISubprogram(name: "iswspace", scope: !734, file: !734, line: 130, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!760 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !761, file: !731, line: 99)
!761 = !DISubprogram(name: "iswupper", scope: !734, file: !734, line: 135, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!762 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !763, file: !731, line: 100)
!763 = !DISubprogram(name: "iswxdigit", scope: !734, file: !734, line: 140, type: !239, flags: DIFlagPrototyped, spFlags: 0)
!764 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !765, file: !731, line: 101)
!765 = !DISubprogram(name: "towctrans", scope: !726, file: !726, line: 55, type: !766, flags: DIFlagPrototyped, spFlags: 0)
!766 = !DISubroutineType(types: !767)
!767 = !{!32, !32, !725}
!768 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !769, file: !731, line: 102)
!769 = !DISubprogram(name: "towlower", scope: !734, file: !734, line: 166, type: !770, flags: DIFlagPrototyped, spFlags: 0)
!770 = !DISubroutineType(types: !771)
!771 = !{!32, !32}
!772 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !773, file: !731, line: 103)
!773 = !DISubprogram(name: "towupper", scope: !734, file: !734, line: 169, type: !770, flags: DIFlagPrototyped, spFlags: 0)
!774 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !775, file: !731, line: 104)
!775 = !DISubprogram(name: "wctrans", scope: !726, file: !726, line: 52, type: !776, flags: DIFlagPrototyped, spFlags: 0)
!776 = !DISubroutineType(types: !777)
!777 = !{!725, !90}
!778 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !779, file: !731, line: 105)
!779 = !DISubprogram(name: "wctype", scope: !734, file: !734, line: 155, type: !780, flags: DIFlagPrototyped, spFlags: 0)
!780 = !DISubroutineType(types: !781)
!781 = !{!733, !90}
!782 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !783, file: !787, line: 51)
!783 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !784, line: 24, baseType: !785)
!784 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "", checksumkind: CSK_MD5, checksum: "649b383a60bfa3eb90e85840b2b0be20")
!785 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !730, line: 37, baseType: !786)
!786 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!787 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/13/../../../../include/c++/13/cstdint", directory: "")
!788 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !789, file: !787, line: 52)
!789 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !784, line: 25, baseType: !790)
!790 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !730, line: 39, baseType: !791)
!791 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!792 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !793, file: !787, line: 53)
!793 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !784, line: 26, baseType: !729)
!794 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !795, file: !787, line: 54)
!795 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !784, line: 27, baseType: !796)
!796 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !730, line: 44, baseType: !228)
!797 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !798, file: !787, line: 56)
!798 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !799, line: 47, baseType: !786)
!799 = !DIFile(filename: "/usr/include/stdint.h", directory: "", checksumkind: CSK_MD5, checksum: "bfb03fa9c46a839e35c32b929fbdbb8e")
!800 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !801, file: !787, line: 57)
!801 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !799, line: 49, baseType: !228)
!802 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !803, file: !787, line: 58)
!803 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !799, line: 50, baseType: !228)
!804 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !805, file: !787, line: 59)
!805 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !799, line: 51, baseType: !228)
!806 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !807, file: !787, line: 61)
!807 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !808, line: 25, baseType: !809)
!808 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-least.h", directory: "", checksumkind: CSK_MD5, checksum: "a866be81c480920b0293bd5f6336a0a3")
!809 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least8_t", file: !730, line: 52, baseType: !785)
!810 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !811, file: !787, line: 62)
!811 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !808, line: 26, baseType: !812)
!812 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least16_t", file: !730, line: 54, baseType: !790)
!813 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !814, file: !787, line: 63)
!814 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !808, line: 27, baseType: !815)
!815 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least32_t", file: !730, line: 56, baseType: !729)
!816 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !817, file: !787, line: 64)
!817 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !808, line: 28, baseType: !818)
!818 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int_least64_t", file: !730, line: 58, baseType: !796)
!819 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !820, file: !787, line: 66)
!820 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !799, line: 90, baseType: !821)
!821 = !DIDerivedType(tag: DW_TAG_typedef, name: "__intmax_t", file: !730, line: 72, baseType: !228)
!822 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !823, file: !787, line: 67)
!823 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !799, line: 76, baseType: !228)
!824 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !825, file: !787, line: 69)
!825 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !826, line: 24, baseType: !827)
!826 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!827 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !730, line: 38, baseType: !828)
!828 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!829 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !830, file: !787, line: 70)
!830 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !826, line: 25, baseType: !831)
!831 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !730, line: 40, baseType: !832)
!832 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!833 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !834, file: !787, line: 71)
!834 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !826, line: 26, baseType: !835)
!835 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !730, line: 42, baseType: !24)
!836 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !837, file: !787, line: 72)
!837 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !826, line: 27, baseType: !838)
!838 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !730, line: 45, baseType: !88)
!839 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !840, file: !787, line: 74)
!840 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !799, line: 60, baseType: !828)
!841 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !842, file: !787, line: 75)
!842 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !799, line: 62, baseType: !88)
!843 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !844, file: !787, line: 76)
!844 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !799, line: 63, baseType: !88)
!845 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !846, file: !787, line: 77)
!846 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !799, line: 64, baseType: !88)
!847 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !848, file: !787, line: 79)
!848 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !808, line: 31, baseType: !849)
!849 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least8_t", file: !730, line: 53, baseType: !827)
!850 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !851, file: !787, line: 80)
!851 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !808, line: 32, baseType: !852)
!852 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least16_t", file: !730, line: 55, baseType: !831)
!853 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !854, file: !787, line: 81)
!854 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !808, line: 33, baseType: !855)
!855 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least32_t", file: !730, line: 57, baseType: !835)
!856 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !857, file: !787, line: 82)
!857 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !808, line: 34, baseType: !858)
!858 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint_least64_t", file: !730, line: 59, baseType: !838)
!859 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !860, file: !787, line: 84)
!860 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !799, line: 91, baseType: !861)
!861 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uintmax_t", file: !730, line: 73, baseType: !88)
!862 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !12, entity: !863, file: !787, line: 85)
!863 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !799, line: 79, baseType: !88)
!864 = !{i32 7, !"Dwarf Version", i32 5}
!865 = !{i32 2, !"Debug Info Version", i32 3}
!866 = !{i32 1, !"wchar_size", i32 4}
!867 = !{i32 8, !"PIC Level", i32 2}
!868 = !{i32 7, !"PIE Level", i32 2}
!869 = !{i32 7, !"uwtable", i32 2}
!870 = !{i32 7, !"frame-pointer", i32 2}
!871 = !{!"Ubuntu clang version 17.0.6 (9ubuntu1)"}
!872 = distinct !DISubprogram(name: "benchmark_function", linkageName: "_Z18benchmark_functioni", scope: !7, file: !7, line: 25, type: !330, scopeLine: 25, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !873)
!873 = !{}
!874 = !DILocalVariable(name: "input", arg: 1, scope: !872, file: !7, line: 25, type: !9)
!875 = !DILocation(line: 25, column: 28, scope: !872)
!876 = !DILocalVariable(name: "acc", scope: !872, file: !7, line: 26, type: !9)
!877 = !DILocation(line: 26, column: 9, scope: !872)
!878 = !DILocation(line: 26, column: 15, scope: !872)
!879 = !DILocation(line: 31, column: 17, scope: !880)
!880 = distinct !DILexicalBlock(scope: !872, file: !7, line: 31, column: 9)
!881 = !DILocation(line: 31, column: 10, scope: !880)
!882 = !DILocation(line: 31, column: 25, scope: !880)
!883 = !DILocation(line: 31, column: 30, scope: !880)
!884 = !DILocation(line: 31, column: 9, scope: !872)
!885 = !DILocation(line: 32, column: 13, scope: !886)
!886 = distinct !DILexicalBlock(scope: !880, file: !7, line: 31, column: 36)
!887 = !DILocation(line: 33, column: 5, scope: !886)
!888 = !DILocation(line: 34, column: 13, scope: !889)
!889 = distinct !DILexicalBlock(scope: !880, file: !7, line: 33, column: 12)
!890 = !DILocation(line: 37, column: 17, scope: !891)
!891 = distinct !DILexicalBlock(scope: !872, file: !7, line: 37, column: 9)
!892 = !DILocation(line: 37, column: 10, scope: !891)
!893 = !DILocation(line: 37, column: 25, scope: !891)
!894 = !DILocation(line: 37, column: 30, scope: !891)
!895 = !DILocation(line: 37, column: 9, scope: !872)
!896 = !DILocation(line: 38, column: 13, scope: !897)
!897 = distinct !DILexicalBlock(scope: !891, file: !7, line: 37, column: 36)
!898 = !DILocation(line: 39, column: 5, scope: !897)
!899 = !DILocation(line: 40, column: 25, scope: !900)
!900 = distinct !DILexicalBlock(scope: !891, file: !7, line: 39, column: 12)
!901 = !DILocation(line: 40, column: 16, scope: !900)
!902 = !DILocation(line: 40, column: 13, scope: !900)
!903 = !DILocation(line: 43, column: 17, scope: !904)
!904 = distinct !DILexicalBlock(scope: !872, file: !7, line: 43, column: 9)
!905 = !DILocation(line: 43, column: 10, scope: !904)
!906 = !DILocation(line: 43, column: 25, scope: !904)
!907 = !DILocation(line: 43, column: 30, scope: !904)
!908 = !DILocation(line: 43, column: 9, scope: !872)
!909 = !DILocation(line: 44, column: 13, scope: !910)
!910 = distinct !DILexicalBlock(scope: !904, file: !7, line: 43, column: 36)
!911 = !DILocation(line: 45, column: 5, scope: !910)
!912 = !DILocation(line: 46, column: 25, scope: !913)
!913 = distinct !DILexicalBlock(scope: !904, file: !7, line: 45, column: 12)
!914 = !DILocation(line: 46, column: 16, scope: !913)
!915 = !DILocation(line: 46, column: 13, scope: !913)
!916 = !DILocation(line: 49, column: 17, scope: !917)
!917 = distinct !DILexicalBlock(scope: !872, file: !7, line: 49, column: 9)
!918 = !DILocation(line: 49, column: 10, scope: !917)
!919 = !DILocation(line: 49, column: 25, scope: !917)
!920 = !DILocation(line: 49, column: 30, scope: !917)
!921 = !DILocation(line: 49, column: 9, scope: !872)
!922 = !DILocation(line: 50, column: 13, scope: !923)
!923 = distinct !DILexicalBlock(scope: !917, file: !7, line: 49, column: 35)
!924 = !DILocation(line: 51, column: 5, scope: !923)
!925 = !DILocation(line: 52, column: 25, scope: !926)
!926 = distinct !DILexicalBlock(scope: !917, file: !7, line: 51, column: 12)
!927 = !DILocation(line: 52, column: 16, scope: !926)
!928 = !DILocation(line: 52, column: 13, scope: !926)
!929 = !DILocation(line: 55, column: 17, scope: !930)
!930 = distinct !DILexicalBlock(scope: !872, file: !7, line: 55, column: 9)
!931 = !DILocation(line: 55, column: 10, scope: !930)
!932 = !DILocation(line: 55, column: 25, scope: !930)
!933 = !DILocation(line: 55, column: 30, scope: !930)
!934 = !DILocation(line: 55, column: 9, scope: !872)
!935 = !DILocation(line: 56, column: 13, scope: !936)
!936 = distinct !DILexicalBlock(scope: !930, file: !7, line: 55, column: 36)
!937 = !DILocation(line: 57, column: 5, scope: !936)
!938 = !DILocation(line: 58, column: 25, scope: !939)
!939 = distinct !DILexicalBlock(scope: !930, file: !7, line: 57, column: 12)
!940 = !DILocation(line: 58, column: 16, scope: !939)
!941 = !DILocation(line: 58, column: 13, scope: !939)
!942 = !DILocation(line: 61, column: 17, scope: !943)
!943 = distinct !DILexicalBlock(scope: !872, file: !7, line: 61, column: 9)
!944 = !DILocation(line: 61, column: 10, scope: !943)
!945 = !DILocation(line: 61, column: 25, scope: !943)
!946 = !DILocation(line: 61, column: 30, scope: !943)
!947 = !DILocation(line: 61, column: 9, scope: !872)
!948 = !DILocation(line: 62, column: 13, scope: !949)
!949 = distinct !DILexicalBlock(scope: !943, file: !7, line: 61, column: 36)
!950 = !DILocation(line: 63, column: 5, scope: !949)
!951 = !DILocation(line: 64, column: 25, scope: !952)
!952 = distinct !DILexicalBlock(scope: !943, file: !7, line: 63, column: 12)
!953 = !DILocation(line: 64, column: 16, scope: !952)
!954 = !DILocation(line: 64, column: 13, scope: !952)
!955 = !DILocation(line: 67, column: 17, scope: !956)
!956 = distinct !DILexicalBlock(scope: !872, file: !7, line: 67, column: 9)
!957 = !DILocation(line: 67, column: 10, scope: !956)
!958 = !DILocation(line: 67, column: 25, scope: !956)
!959 = !DILocation(line: 67, column: 30, scope: !956)
!960 = !DILocation(line: 67, column: 9, scope: !872)
!961 = !DILocation(line: 68, column: 13, scope: !962)
!962 = distinct !DILexicalBlock(scope: !956, file: !7, line: 67, column: 36)
!963 = !DILocation(line: 69, column: 5, scope: !962)
!964 = !DILocation(line: 70, column: 25, scope: !965)
!965 = distinct !DILexicalBlock(scope: !956, file: !7, line: 69, column: 12)
!966 = !DILocation(line: 70, column: 16, scope: !965)
!967 = !DILocation(line: 70, column: 13, scope: !965)
!968 = !DILocation(line: 73, column: 17, scope: !969)
!969 = distinct !DILexicalBlock(scope: !872, file: !7, line: 73, column: 9)
!970 = !DILocation(line: 73, column: 10, scope: !969)
!971 = !DILocation(line: 73, column: 25, scope: !969)
!972 = !DILocation(line: 73, column: 30, scope: !969)
!973 = !DILocation(line: 73, column: 9, scope: !872)
!974 = !DILocation(line: 74, column: 13, scope: !975)
!975 = distinct !DILexicalBlock(scope: !969, file: !7, line: 73, column: 36)
!976 = !DILocation(line: 75, column: 5, scope: !975)
!977 = !DILocation(line: 76, column: 25, scope: !978)
!978 = distinct !DILexicalBlock(scope: !969, file: !7, line: 75, column: 12)
!979 = !DILocation(line: 76, column: 16, scope: !978)
!980 = !DILocation(line: 76, column: 13, scope: !978)
!981 = !DILocation(line: 79, column: 17, scope: !982)
!982 = distinct !DILexicalBlock(scope: !872, file: !7, line: 79, column: 9)
!983 = !DILocation(line: 79, column: 10, scope: !982)
!984 = !DILocation(line: 79, column: 25, scope: !982)
!985 = !DILocation(line: 79, column: 30, scope: !982)
!986 = !DILocation(line: 79, column: 9, scope: !872)
!987 = !DILocation(line: 80, column: 13, scope: !988)
!988 = distinct !DILexicalBlock(scope: !982, file: !7, line: 79, column: 35)
!989 = !DILocation(line: 81, column: 5, scope: !988)
!990 = !DILocation(line: 82, column: 25, scope: !991)
!991 = distinct !DILexicalBlock(scope: !982, file: !7, line: 81, column: 12)
!992 = !DILocation(line: 82, column: 16, scope: !991)
!993 = !DILocation(line: 82, column: 13, scope: !991)
!994 = !DILocation(line: 85, column: 17, scope: !995)
!995 = distinct !DILexicalBlock(scope: !872, file: !7, line: 85, column: 9)
!996 = !DILocation(line: 85, column: 10, scope: !995)
!997 = !DILocation(line: 85, column: 26, scope: !995)
!998 = !DILocation(line: 85, column: 32, scope: !995)
!999 = !DILocation(line: 85, column: 9, scope: !872)
!1000 = !DILocation(line: 86, column: 13, scope: !1001)
!1001 = distinct !DILexicalBlock(scope: !995, file: !7, line: 85, column: 38)
!1002 = !DILocation(line: 87, column: 5, scope: !1001)
!1003 = !DILocation(line: 88, column: 25, scope: !1004)
!1004 = distinct !DILexicalBlock(scope: !995, file: !7, line: 87, column: 12)
!1005 = !DILocation(line: 88, column: 16, scope: !1004)
!1006 = !DILocation(line: 88, column: 13, scope: !1004)
!1007 = !DILocalVariable(name: "i", scope: !1008, file: !7, line: 94, type: !9)
!1008 = distinct !DILexicalBlock(scope: !872, file: !7, line: 94, column: 5)
!1009 = !DILocation(line: 94, column: 14, scope: !1008)
!1010 = !DILocation(line: 94, column: 10, scope: !1008)
!1011 = !DILocation(line: 94, column: 21, scope: !1012)
!1012 = distinct !DILexicalBlock(scope: !1008, file: !7, line: 94, column: 5)
!1013 = !DILocation(line: 94, column: 23, scope: !1012)
!1014 = !DILocation(line: 94, column: 5, scope: !1008)
!1015 = !DILocation(line: 95, column: 21, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !1017, file: !7, line: 95, column: 13)
!1017 = distinct !DILexicalBlock(scope: !1012, file: !7, line: 94, column: 34)
!1018 = !DILocation(line: 95, column: 27, scope: !1016)
!1019 = !DILocation(line: 95, column: 25, scope: !1016)
!1020 = !DILocation(line: 95, column: 14, scope: !1016)
!1021 = !DILocation(line: 95, column: 34, scope: !1016)
!1022 = !DILocation(line: 95, column: 39, scope: !1016)
!1023 = !DILocation(line: 95, column: 13, scope: !1017)
!1024 = !DILocation(line: 96, column: 17, scope: !1025)
!1025 = distinct !DILexicalBlock(scope: !1016, file: !7, line: 95, column: 45)
!1026 = !DILocation(line: 97, column: 9, scope: !1025)
!1027 = !DILocation(line: 98, column: 29, scope: !1028)
!1028 = distinct !DILexicalBlock(scope: !1016, file: !7, line: 97, column: 16)
!1029 = !DILocation(line: 98, column: 20, scope: !1028)
!1030 = !DILocation(line: 98, column: 17, scope: !1028)
!1031 = !DILocation(line: 101, column: 21, scope: !1032)
!1032 = distinct !DILexicalBlock(scope: !1017, file: !7, line: 101, column: 13)
!1033 = !DILocation(line: 101, column: 27, scope: !1032)
!1034 = !DILocation(line: 101, column: 25, scope: !1032)
!1035 = !DILocation(line: 101, column: 14, scope: !1032)
!1036 = !DILocation(line: 101, column: 34, scope: !1032)
!1037 = !DILocation(line: 101, column: 39, scope: !1032)
!1038 = !DILocation(line: 101, column: 13, scope: !1017)
!1039 = !DILocation(line: 102, column: 17, scope: !1040)
!1040 = distinct !DILexicalBlock(scope: !1032, file: !7, line: 101, column: 45)
!1041 = !DILocation(line: 103, column: 9, scope: !1040)
!1042 = !DILocation(line: 104, column: 29, scope: !1043)
!1043 = distinct !DILexicalBlock(scope: !1032, file: !7, line: 103, column: 16)
!1044 = !DILocation(line: 104, column: 20, scope: !1043)
!1045 = !DILocation(line: 104, column: 17, scope: !1043)
!1046 = !DILocation(line: 107, column: 21, scope: !1047)
!1047 = distinct !DILexicalBlock(scope: !1017, file: !7, line: 107, column: 13)
!1048 = !DILocation(line: 107, column: 27, scope: !1047)
!1049 = !DILocation(line: 107, column: 25, scope: !1047)
!1050 = !DILocation(line: 107, column: 14, scope: !1047)
!1051 = !DILocation(line: 107, column: 34, scope: !1047)
!1052 = !DILocation(line: 107, column: 39, scope: !1047)
!1053 = !DILocation(line: 107, column: 13, scope: !1017)
!1054 = !DILocation(line: 108, column: 17, scope: !1055)
!1055 = distinct !DILexicalBlock(scope: !1047, file: !7, line: 107, column: 44)
!1056 = !DILocation(line: 109, column: 9, scope: !1055)
!1057 = !DILocation(line: 110, column: 29, scope: !1058)
!1058 = distinct !DILexicalBlock(scope: !1047, file: !7, line: 109, column: 16)
!1059 = !DILocation(line: 110, column: 20, scope: !1058)
!1060 = !DILocation(line: 110, column: 17, scope: !1058)
!1061 = !DILocation(line: 112, column: 5, scope: !1017)
!1062 = !DILocation(line: 94, column: 29, scope: !1012)
!1063 = !DILocation(line: 94, column: 5, scope: !1012)
!1064 = distinct !{!1064, !1014, !1065, !1066}
!1065 = !DILocation(line: 112, column: 5, scope: !1008)
!1066 = !{!"llvm.loop.mustprogress"}
!1067 = !DILocation(line: 117, column: 17, scope: !1068)
!1068 = distinct !DILexicalBlock(scope: !872, file: !7, line: 117, column: 9)
!1069 = !DILocation(line: 117, column: 10, scope: !1068)
!1070 = !DILocation(line: 117, column: 26, scope: !1068)
!1071 = !DILocation(line: 117, column: 31, scope: !1068)
!1072 = !DILocation(line: 117, column: 9, scope: !872)
!1073 = !DILocation(line: 118, column: 13, scope: !1074)
!1074 = distinct !DILexicalBlock(scope: !1068, file: !7, line: 117, column: 37)
!1075 = !DILocation(line: 119, column: 5, scope: !1074)
!1076 = !DILocation(line: 120, column: 25, scope: !1077)
!1077 = distinct !DILexicalBlock(scope: !1068, file: !7, line: 119, column: 12)
!1078 = !DILocation(line: 120, column: 16, scope: !1077)
!1079 = !DILocation(line: 120, column: 13, scope: !1077)
!1080 = !DILocation(line: 123, column: 17, scope: !1081)
!1081 = distinct !DILexicalBlock(scope: !872, file: !7, line: 123, column: 9)
!1082 = !DILocation(line: 123, column: 10, scope: !1081)
!1083 = !DILocation(line: 123, column: 26, scope: !1081)
!1084 = !DILocation(line: 123, column: 31, scope: !1081)
!1085 = !DILocation(line: 123, column: 9, scope: !872)
!1086 = !DILocation(line: 124, column: 13, scope: !1087)
!1087 = distinct !DILexicalBlock(scope: !1081, file: !7, line: 123, column: 37)
!1088 = !DILocation(line: 125, column: 5, scope: !1087)
!1089 = !DILocation(line: 126, column: 25, scope: !1090)
!1090 = distinct !DILexicalBlock(scope: !1081, file: !7, line: 125, column: 12)
!1091 = !DILocation(line: 126, column: 16, scope: !1090)
!1092 = !DILocation(line: 126, column: 13, scope: !1090)
!1093 = !DILocation(line: 129, column: 17, scope: !1094)
!1094 = distinct !DILexicalBlock(scope: !872, file: !7, line: 129, column: 9)
!1095 = !DILocation(line: 129, column: 10, scope: !1094)
!1096 = !DILocation(line: 129, column: 26, scope: !1094)
!1097 = !DILocation(line: 129, column: 31, scope: !1094)
!1098 = !DILocation(line: 129, column: 9, scope: !872)
!1099 = !DILocation(line: 130, column: 13, scope: !1100)
!1100 = distinct !DILexicalBlock(scope: !1094, file: !7, line: 129, column: 37)
!1101 = !DILocation(line: 131, column: 5, scope: !1100)
!1102 = !DILocation(line: 132, column: 25, scope: !1103)
!1103 = distinct !DILexicalBlock(scope: !1094, file: !7, line: 131, column: 12)
!1104 = !DILocation(line: 132, column: 16, scope: !1103)
!1105 = !DILocation(line: 132, column: 13, scope: !1103)
!1106 = !DILocation(line: 135, column: 17, scope: !1107)
!1107 = distinct !DILexicalBlock(scope: !872, file: !7, line: 135, column: 9)
!1108 = !DILocation(line: 135, column: 10, scope: !1107)
!1109 = !DILocation(line: 135, column: 26, scope: !1107)
!1110 = !DILocation(line: 135, column: 31, scope: !1107)
!1111 = !DILocation(line: 135, column: 9, scope: !872)
!1112 = !DILocation(line: 136, column: 13, scope: !1113)
!1113 = distinct !DILexicalBlock(scope: !1107, file: !7, line: 135, column: 37)
!1114 = !DILocation(line: 137, column: 5, scope: !1113)
!1115 = !DILocation(line: 138, column: 25, scope: !1116)
!1116 = distinct !DILexicalBlock(scope: !1107, file: !7, line: 137, column: 12)
!1117 = !DILocation(line: 138, column: 16, scope: !1116)
!1118 = !DILocation(line: 138, column: 13, scope: !1116)
!1119 = !DILocation(line: 141, column: 17, scope: !1120)
!1120 = distinct !DILexicalBlock(scope: !872, file: !7, line: 141, column: 9)
!1121 = !DILocation(line: 141, column: 10, scope: !1120)
!1122 = !DILocation(line: 141, column: 26, scope: !1120)
!1123 = !DILocation(line: 141, column: 31, scope: !1120)
!1124 = !DILocation(line: 141, column: 9, scope: !872)
!1125 = !DILocation(line: 142, column: 13, scope: !1126)
!1126 = distinct !DILexicalBlock(scope: !1120, file: !7, line: 141, column: 37)
!1127 = !DILocation(line: 143, column: 5, scope: !1126)
!1128 = !DILocation(line: 144, column: 25, scope: !1129)
!1129 = distinct !DILexicalBlock(scope: !1120, file: !7, line: 143, column: 12)
!1130 = !DILocation(line: 144, column: 16, scope: !1129)
!1131 = !DILocation(line: 144, column: 13, scope: !1129)
!1132 = !DILocation(line: 147, column: 17, scope: !1133)
!1133 = distinct !DILexicalBlock(scope: !872, file: !7, line: 147, column: 9)
!1134 = !DILocation(line: 147, column: 10, scope: !1133)
!1135 = !DILocation(line: 147, column: 26, scope: !1133)
!1136 = !DILocation(line: 147, column: 31, scope: !1133)
!1137 = !DILocation(line: 147, column: 9, scope: !872)
!1138 = !DILocation(line: 148, column: 13, scope: !1139)
!1139 = distinct !DILexicalBlock(scope: !1133, file: !7, line: 147, column: 36)
!1140 = !DILocation(line: 149, column: 5, scope: !1139)
!1141 = !DILocation(line: 150, column: 25, scope: !1142)
!1142 = distinct !DILexicalBlock(scope: !1133, file: !7, line: 149, column: 12)
!1143 = !DILocation(line: 150, column: 16, scope: !1142)
!1144 = !DILocation(line: 150, column: 13, scope: !1142)
!1145 = !DILocation(line: 153, column: 17, scope: !1146)
!1146 = distinct !DILexicalBlock(scope: !872, file: !7, line: 153, column: 9)
!1147 = !DILocation(line: 153, column: 10, scope: !1146)
!1148 = !DILocation(line: 153, column: 26, scope: !1146)
!1149 = !DILocation(line: 153, column: 31, scope: !1146)
!1150 = !DILocation(line: 153, column: 9, scope: !872)
!1151 = !DILocation(line: 154, column: 13, scope: !1152)
!1152 = distinct !DILexicalBlock(scope: !1146, file: !7, line: 153, column: 37)
!1153 = !DILocation(line: 155, column: 5, scope: !1152)
!1154 = !DILocation(line: 156, column: 25, scope: !1155)
!1155 = distinct !DILexicalBlock(scope: !1146, file: !7, line: 155, column: 12)
!1156 = !DILocation(line: 156, column: 16, scope: !1155)
!1157 = !DILocation(line: 156, column: 13, scope: !1155)
!1158 = !DILocation(line: 159, column: 17, scope: !1159)
!1159 = distinct !DILexicalBlock(scope: !872, file: !7, line: 159, column: 9)
!1160 = !DILocation(line: 159, column: 10, scope: !1159)
!1161 = !DILocation(line: 159, column: 26, scope: !1159)
!1162 = !DILocation(line: 159, column: 31, scope: !1159)
!1163 = !DILocation(line: 159, column: 9, scope: !872)
!1164 = !DILocation(line: 160, column: 13, scope: !1165)
!1165 = distinct !DILexicalBlock(scope: !1159, file: !7, line: 159, column: 37)
!1166 = !DILocation(line: 161, column: 5, scope: !1165)
!1167 = !DILocation(line: 162, column: 25, scope: !1168)
!1168 = distinct !DILexicalBlock(scope: !1159, file: !7, line: 161, column: 12)
!1169 = !DILocation(line: 162, column: 16, scope: !1168)
!1170 = !DILocation(line: 162, column: 13, scope: !1168)
!1171 = !DILocation(line: 165, column: 17, scope: !1172)
!1172 = distinct !DILexicalBlock(scope: !872, file: !7, line: 165, column: 9)
!1173 = !DILocation(line: 165, column: 10, scope: !1172)
!1174 = !DILocation(line: 165, column: 26, scope: !1172)
!1175 = !DILocation(line: 165, column: 31, scope: !1172)
!1176 = !DILocation(line: 165, column: 9, scope: !872)
!1177 = !DILocation(line: 166, column: 13, scope: !1178)
!1178 = distinct !DILexicalBlock(scope: !1172, file: !7, line: 165, column: 37)
!1179 = !DILocation(line: 167, column: 5, scope: !1178)
!1180 = !DILocation(line: 168, column: 25, scope: !1181)
!1181 = distinct !DILexicalBlock(scope: !1172, file: !7, line: 167, column: 12)
!1182 = !DILocation(line: 168, column: 16, scope: !1181)
!1183 = !DILocation(line: 168, column: 13, scope: !1181)
!1184 = !DILocation(line: 171, column: 17, scope: !1185)
!1185 = distinct !DILexicalBlock(scope: !872, file: !7, line: 171, column: 9)
!1186 = !DILocation(line: 171, column: 10, scope: !1185)
!1187 = !DILocation(line: 171, column: 26, scope: !1185)
!1188 = !DILocation(line: 171, column: 32, scope: !1185)
!1189 = !DILocation(line: 171, column: 9, scope: !872)
!1190 = !DILocation(line: 172, column: 13, scope: !1191)
!1191 = distinct !DILexicalBlock(scope: !1185, file: !7, line: 171, column: 38)
!1192 = !DILocation(line: 173, column: 5, scope: !1191)
!1193 = !DILocation(line: 174, column: 25, scope: !1194)
!1194 = distinct !DILexicalBlock(scope: !1185, file: !7, line: 173, column: 12)
!1195 = !DILocation(line: 174, column: 16, scope: !1194)
!1196 = !DILocation(line: 174, column: 13, scope: !1194)
!1197 = !DILocation(line: 177, column: 17, scope: !1198)
!1198 = distinct !DILexicalBlock(scope: !872, file: !7, line: 177, column: 9)
!1199 = !DILocation(line: 177, column: 10, scope: !1198)
!1200 = !DILocation(line: 177, column: 26, scope: !1198)
!1201 = !DILocation(line: 177, column: 31, scope: !1198)
!1202 = !DILocation(line: 177, column: 9, scope: !872)
!1203 = !DILocation(line: 178, column: 13, scope: !1204)
!1204 = distinct !DILexicalBlock(scope: !1198, file: !7, line: 177, column: 36)
!1205 = !DILocation(line: 179, column: 5, scope: !1204)
!1206 = !DILocation(line: 180, column: 25, scope: !1207)
!1207 = distinct !DILexicalBlock(scope: !1198, file: !7, line: 179, column: 12)
!1208 = !DILocation(line: 180, column: 16, scope: !1207)
!1209 = !DILocation(line: 180, column: 13, scope: !1207)
!1210 = !DILocation(line: 183, column: 17, scope: !1211)
!1211 = distinct !DILexicalBlock(scope: !872, file: !7, line: 183, column: 9)
!1212 = !DILocation(line: 183, column: 10, scope: !1211)
!1213 = !DILocation(line: 183, column: 26, scope: !1211)
!1214 = !DILocation(line: 183, column: 32, scope: !1211)
!1215 = !DILocation(line: 183, column: 9, scope: !872)
!1216 = !DILocation(line: 184, column: 13, scope: !1217)
!1217 = distinct !DILexicalBlock(scope: !1211, file: !7, line: 183, column: 38)
!1218 = !DILocation(line: 185, column: 5, scope: !1217)
!1219 = !DILocation(line: 186, column: 25, scope: !1220)
!1220 = distinct !DILexicalBlock(scope: !1211, file: !7, line: 185, column: 12)
!1221 = !DILocation(line: 186, column: 16, scope: !1220)
!1222 = !DILocation(line: 186, column: 13, scope: !1220)
!1223 = !DILocalVariable(name: "j", scope: !1224, file: !7, line: 192, type: !9)
!1224 = distinct !DILexicalBlock(scope: !872, file: !7, line: 192, column: 5)
!1225 = !DILocation(line: 192, column: 14, scope: !1224)
!1226 = !DILocation(line: 192, column: 10, scope: !1224)
!1227 = !DILocation(line: 192, column: 21, scope: !1228)
!1228 = distinct !DILexicalBlock(scope: !1224, file: !7, line: 192, column: 5)
!1229 = !DILocation(line: 192, column: 23, scope: !1228)
!1230 = !DILocation(line: 192, column: 5, scope: !1224)
!1231 = !DILocation(line: 193, column: 21, scope: !1232)
!1232 = distinct !DILexicalBlock(scope: !1233, file: !7, line: 193, column: 13)
!1233 = distinct !DILexicalBlock(scope: !1228, file: !7, line: 192, column: 34)
!1234 = !DILocation(line: 193, column: 27, scope: !1232)
!1235 = !DILocation(line: 193, column: 25, scope: !1232)
!1236 = !DILocation(line: 193, column: 14, scope: !1232)
!1237 = !DILocation(line: 193, column: 34, scope: !1232)
!1238 = !DILocation(line: 193, column: 39, scope: !1232)
!1239 = !DILocation(line: 193, column: 13, scope: !1233)
!1240 = !DILocation(line: 194, column: 17, scope: !1241)
!1241 = distinct !DILexicalBlock(scope: !1232, file: !7, line: 193, column: 45)
!1242 = !DILocation(line: 195, column: 9, scope: !1241)
!1243 = !DILocation(line: 196, column: 29, scope: !1244)
!1244 = distinct !DILexicalBlock(scope: !1232, file: !7, line: 195, column: 16)
!1245 = !DILocation(line: 196, column: 20, scope: !1244)
!1246 = !DILocation(line: 196, column: 17, scope: !1244)
!1247 = !DILocation(line: 199, column: 21, scope: !1248)
!1248 = distinct !DILexicalBlock(scope: !1233, file: !7, line: 199, column: 13)
!1249 = !DILocation(line: 199, column: 27, scope: !1248)
!1250 = !DILocation(line: 199, column: 25, scope: !1248)
!1251 = !DILocation(line: 199, column: 14, scope: !1248)
!1252 = !DILocation(line: 199, column: 34, scope: !1248)
!1253 = !DILocation(line: 199, column: 39, scope: !1248)
!1254 = !DILocation(line: 199, column: 13, scope: !1233)
!1255 = !DILocation(line: 200, column: 17, scope: !1256)
!1256 = distinct !DILexicalBlock(scope: !1248, file: !7, line: 199, column: 45)
!1257 = !DILocation(line: 201, column: 9, scope: !1256)
!1258 = !DILocation(line: 202, column: 29, scope: !1259)
!1259 = distinct !DILexicalBlock(scope: !1248, file: !7, line: 201, column: 16)
!1260 = !DILocation(line: 202, column: 20, scope: !1259)
!1261 = !DILocation(line: 202, column: 17, scope: !1259)
!1262 = !DILocation(line: 204, column: 5, scope: !1233)
!1263 = !DILocation(line: 192, column: 29, scope: !1228)
!1264 = !DILocation(line: 192, column: 5, scope: !1228)
!1265 = distinct !{!1265, !1230, !1266, !1066}
!1266 = !DILocation(line: 204, column: 5, scope: !1224)
!1267 = !DILocation(line: 209, column: 17, scope: !1268)
!1268 = distinct !DILexicalBlock(scope: !872, file: !7, line: 209, column: 9)
!1269 = !DILocation(line: 209, column: 10, scope: !1268)
!1270 = !DILocation(line: 209, column: 26, scope: !1268)
!1271 = !DILocation(line: 209, column: 31, scope: !1268)
!1272 = !DILocation(line: 209, column: 9, scope: !872)
!1273 = !DILocation(line: 210, column: 13, scope: !1274)
!1274 = distinct !DILexicalBlock(scope: !1268, file: !7, line: 209, column: 37)
!1275 = !DILocation(line: 211, column: 5, scope: !1274)
!1276 = !DILocation(line: 212, column: 25, scope: !1277)
!1277 = distinct !DILexicalBlock(scope: !1268, file: !7, line: 211, column: 12)
!1278 = !DILocation(line: 212, column: 16, scope: !1277)
!1279 = !DILocation(line: 212, column: 13, scope: !1277)
!1280 = !DILocation(line: 215, column: 17, scope: !1281)
!1281 = distinct !DILexicalBlock(scope: !872, file: !7, line: 215, column: 9)
!1282 = !DILocation(line: 215, column: 10, scope: !1281)
!1283 = !DILocation(line: 215, column: 26, scope: !1281)
!1284 = !DILocation(line: 215, column: 31, scope: !1281)
!1285 = !DILocation(line: 215, column: 9, scope: !872)
!1286 = !DILocation(line: 216, column: 13, scope: !1287)
!1287 = distinct !DILexicalBlock(scope: !1281, file: !7, line: 215, column: 37)
!1288 = !DILocation(line: 217, column: 5, scope: !1287)
!1289 = !DILocation(line: 218, column: 25, scope: !1290)
!1290 = distinct !DILexicalBlock(scope: !1281, file: !7, line: 217, column: 12)
!1291 = !DILocation(line: 218, column: 16, scope: !1290)
!1292 = !DILocation(line: 218, column: 13, scope: !1290)
!1293 = !DILocation(line: 221, column: 17, scope: !1294)
!1294 = distinct !DILexicalBlock(scope: !872, file: !7, line: 221, column: 9)
!1295 = !DILocation(line: 221, column: 10, scope: !1294)
!1296 = !DILocation(line: 221, column: 26, scope: !1294)
!1297 = !DILocation(line: 221, column: 31, scope: !1294)
!1298 = !DILocation(line: 221, column: 9, scope: !872)
!1299 = !DILocation(line: 222, column: 13, scope: !1300)
!1300 = distinct !DILexicalBlock(scope: !1294, file: !7, line: 221, column: 36)
!1301 = !DILocation(line: 223, column: 5, scope: !1300)
!1302 = !DILocation(line: 224, column: 25, scope: !1303)
!1303 = distinct !DILexicalBlock(scope: !1294, file: !7, line: 223, column: 12)
!1304 = !DILocation(line: 224, column: 16, scope: !1303)
!1305 = !DILocation(line: 224, column: 13, scope: !1303)
!1306 = !DILocation(line: 227, column: 17, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !872, file: !7, line: 227, column: 9)
!1308 = !DILocation(line: 227, column: 10, scope: !1307)
!1309 = !DILocation(line: 227, column: 26, scope: !1307)
!1310 = !DILocation(line: 227, column: 31, scope: !1307)
!1311 = !DILocation(line: 227, column: 9, scope: !872)
!1312 = !DILocation(line: 228, column: 13, scope: !1313)
!1313 = distinct !DILexicalBlock(scope: !1307, file: !7, line: 227, column: 37)
!1314 = !DILocation(line: 229, column: 5, scope: !1313)
!1315 = !DILocation(line: 230, column: 25, scope: !1316)
!1316 = distinct !DILexicalBlock(scope: !1307, file: !7, line: 229, column: 12)
!1317 = !DILocation(line: 230, column: 16, scope: !1316)
!1318 = !DILocation(line: 230, column: 13, scope: !1316)
!1319 = !DILocation(line: 233, column: 17, scope: !1320)
!1320 = distinct !DILexicalBlock(scope: !872, file: !7, line: 233, column: 9)
!1321 = !DILocation(line: 233, column: 10, scope: !1320)
!1322 = !DILocation(line: 233, column: 26, scope: !1320)
!1323 = !DILocation(line: 233, column: 31, scope: !1320)
!1324 = !DILocation(line: 233, column: 9, scope: !872)
!1325 = !DILocation(line: 234, column: 13, scope: !1326)
!1326 = distinct !DILexicalBlock(scope: !1320, file: !7, line: 233, column: 37)
!1327 = !DILocation(line: 235, column: 5, scope: !1326)
!1328 = !DILocation(line: 236, column: 25, scope: !1329)
!1329 = distinct !DILexicalBlock(scope: !1320, file: !7, line: 235, column: 12)
!1330 = !DILocation(line: 236, column: 16, scope: !1329)
!1331 = !DILocation(line: 236, column: 13, scope: !1329)
!1332 = !DILocation(line: 239, column: 17, scope: !1333)
!1333 = distinct !DILexicalBlock(scope: !872, file: !7, line: 239, column: 9)
!1334 = !DILocation(line: 239, column: 10, scope: !1333)
!1335 = !DILocation(line: 239, column: 26, scope: !1333)
!1336 = !DILocation(line: 239, column: 31, scope: !1333)
!1337 = !DILocation(line: 239, column: 9, scope: !872)
!1338 = !DILocation(line: 240, column: 13, scope: !1339)
!1339 = distinct !DILexicalBlock(scope: !1333, file: !7, line: 239, column: 37)
!1340 = !DILocation(line: 241, column: 5, scope: !1339)
!1341 = !DILocation(line: 242, column: 25, scope: !1342)
!1342 = distinct !DILexicalBlock(scope: !1333, file: !7, line: 241, column: 12)
!1343 = !DILocation(line: 242, column: 16, scope: !1342)
!1344 = !DILocation(line: 242, column: 13, scope: !1342)
!1345 = !DILocation(line: 245, column: 17, scope: !1346)
!1346 = distinct !DILexicalBlock(scope: !872, file: !7, line: 245, column: 9)
!1347 = !DILocation(line: 245, column: 10, scope: !1346)
!1348 = !DILocation(line: 245, column: 26, scope: !1346)
!1349 = !DILocation(line: 245, column: 31, scope: !1346)
!1350 = !DILocation(line: 245, column: 9, scope: !872)
!1351 = !DILocation(line: 246, column: 13, scope: !1352)
!1352 = distinct !DILexicalBlock(scope: !1346, file: !7, line: 245, column: 37)
!1353 = !DILocation(line: 247, column: 5, scope: !1352)
!1354 = !DILocation(line: 248, column: 25, scope: !1355)
!1355 = distinct !DILexicalBlock(scope: !1346, file: !7, line: 247, column: 12)
!1356 = !DILocation(line: 248, column: 16, scope: !1355)
!1357 = !DILocation(line: 248, column: 13, scope: !1355)
!1358 = !DILocation(line: 251, column: 17, scope: !1359)
!1359 = distinct !DILexicalBlock(scope: !872, file: !7, line: 251, column: 9)
!1360 = !DILocation(line: 251, column: 10, scope: !1359)
!1361 = !DILocation(line: 251, column: 26, scope: !1359)
!1362 = !DILocation(line: 251, column: 31, scope: !1359)
!1363 = !DILocation(line: 251, column: 9, scope: !872)
!1364 = !DILocation(line: 252, column: 13, scope: !1365)
!1365 = distinct !DILexicalBlock(scope: !1359, file: !7, line: 251, column: 36)
!1366 = !DILocation(line: 253, column: 5, scope: !1365)
!1367 = !DILocation(line: 254, column: 25, scope: !1368)
!1368 = distinct !DILexicalBlock(scope: !1359, file: !7, line: 253, column: 12)
!1369 = !DILocation(line: 254, column: 16, scope: !1368)
!1370 = !DILocation(line: 254, column: 13, scope: !1368)
!1371 = !DILocation(line: 257, column: 17, scope: !1372)
!1372 = distinct !DILexicalBlock(scope: !872, file: !7, line: 257, column: 9)
!1373 = !DILocation(line: 257, column: 10, scope: !1372)
!1374 = !DILocation(line: 257, column: 26, scope: !1372)
!1375 = !DILocation(line: 257, column: 32, scope: !1372)
!1376 = !DILocation(line: 257, column: 9, scope: !872)
!1377 = !DILocation(line: 258, column: 13, scope: !1378)
!1378 = distinct !DILexicalBlock(scope: !1372, file: !7, line: 257, column: 38)
!1379 = !DILocation(line: 259, column: 5, scope: !1378)
!1380 = !DILocation(line: 260, column: 25, scope: !1381)
!1381 = distinct !DILexicalBlock(scope: !1372, file: !7, line: 259, column: 12)
!1382 = !DILocation(line: 260, column: 16, scope: !1381)
!1383 = !DILocation(line: 260, column: 13, scope: !1381)
!1384 = !DILocation(line: 263, column: 17, scope: !1385)
!1385 = distinct !DILexicalBlock(scope: !872, file: !7, line: 263, column: 9)
!1386 = !DILocation(line: 263, column: 10, scope: !1385)
!1387 = !DILocation(line: 263, column: 26, scope: !1385)
!1388 = !DILocation(line: 263, column: 31, scope: !1385)
!1389 = !DILocation(line: 263, column: 9, scope: !872)
!1390 = !DILocation(line: 264, column: 13, scope: !1391)
!1391 = distinct !DILexicalBlock(scope: !1385, file: !7, line: 263, column: 37)
!1392 = !DILocation(line: 265, column: 5, scope: !1391)
!1393 = !DILocation(line: 266, column: 25, scope: !1394)
!1394 = distinct !DILexicalBlock(scope: !1385, file: !7, line: 265, column: 12)
!1395 = !DILocation(line: 266, column: 16, scope: !1394)
!1396 = !DILocation(line: 266, column: 13, scope: !1394)
!1397 = !DILocalVariable(name: "k", scope: !1398, file: !7, line: 272, type: !9)
!1398 = distinct !DILexicalBlock(scope: !872, file: !7, line: 272, column: 5)
!1399 = !DILocation(line: 272, column: 14, scope: !1398)
!1400 = !DILocation(line: 272, column: 10, scope: !1398)
!1401 = !DILocation(line: 272, column: 21, scope: !1402)
!1402 = distinct !DILexicalBlock(scope: !1398, file: !7, line: 272, column: 5)
!1403 = !DILocation(line: 272, column: 23, scope: !1402)
!1404 = !DILocation(line: 272, column: 5, scope: !1398)
!1405 = !DILocation(line: 273, column: 21, scope: !1406)
!1406 = distinct !DILexicalBlock(scope: !1407, file: !7, line: 273, column: 13)
!1407 = distinct !DILexicalBlock(scope: !1402, file: !7, line: 272, column: 34)
!1408 = !DILocation(line: 273, column: 27, scope: !1406)
!1409 = !DILocation(line: 273, column: 25, scope: !1406)
!1410 = !DILocation(line: 273, column: 14, scope: !1406)
!1411 = !DILocation(line: 273, column: 34, scope: !1406)
!1412 = !DILocation(line: 273, column: 39, scope: !1406)
!1413 = !DILocation(line: 273, column: 13, scope: !1407)
!1414 = !DILocation(line: 274, column: 17, scope: !1415)
!1415 = distinct !DILexicalBlock(scope: !1406, file: !7, line: 273, column: 45)
!1416 = !DILocation(line: 275, column: 9, scope: !1415)
!1417 = !DILocation(line: 276, column: 29, scope: !1418)
!1418 = distinct !DILexicalBlock(scope: !1406, file: !7, line: 275, column: 16)
!1419 = !DILocation(line: 276, column: 20, scope: !1418)
!1420 = !DILocation(line: 276, column: 17, scope: !1418)
!1421 = !DILocation(line: 279, column: 21, scope: !1422)
!1422 = distinct !DILexicalBlock(scope: !1407, file: !7, line: 279, column: 13)
!1423 = !DILocation(line: 279, column: 27, scope: !1422)
!1424 = !DILocation(line: 279, column: 25, scope: !1422)
!1425 = !DILocation(line: 279, column: 14, scope: !1422)
!1426 = !DILocation(line: 279, column: 34, scope: !1422)
!1427 = !DILocation(line: 279, column: 39, scope: !1422)
!1428 = !DILocation(line: 279, column: 13, scope: !1407)
!1429 = !DILocation(line: 280, column: 17, scope: !1430)
!1430 = distinct !DILexicalBlock(scope: !1422, file: !7, line: 279, column: 45)
!1431 = !DILocation(line: 281, column: 9, scope: !1430)
!1432 = !DILocation(line: 282, column: 29, scope: !1433)
!1433 = distinct !DILexicalBlock(scope: !1422, file: !7, line: 281, column: 16)
!1434 = !DILocation(line: 282, column: 20, scope: !1433)
!1435 = !DILocation(line: 282, column: 17, scope: !1433)
!1436 = !DILocation(line: 285, column: 21, scope: !1437)
!1437 = distinct !DILexicalBlock(scope: !1407, file: !7, line: 285, column: 13)
!1438 = !DILocation(line: 285, column: 27, scope: !1437)
!1439 = !DILocation(line: 285, column: 25, scope: !1437)
!1440 = !DILocation(line: 285, column: 14, scope: !1437)
!1441 = !DILocation(line: 285, column: 34, scope: !1437)
!1442 = !DILocation(line: 285, column: 39, scope: !1437)
!1443 = !DILocation(line: 285, column: 13, scope: !1407)
!1444 = !DILocation(line: 286, column: 17, scope: !1445)
!1445 = distinct !DILexicalBlock(scope: !1437, file: !7, line: 285, column: 45)
!1446 = !DILocation(line: 287, column: 9, scope: !1445)
!1447 = !DILocation(line: 288, column: 29, scope: !1448)
!1448 = distinct !DILexicalBlock(scope: !1437, file: !7, line: 287, column: 16)
!1449 = !DILocation(line: 288, column: 20, scope: !1448)
!1450 = !DILocation(line: 288, column: 17, scope: !1448)
!1451 = !DILocation(line: 291, column: 21, scope: !1452)
!1452 = distinct !DILexicalBlock(scope: !1407, file: !7, line: 291, column: 13)
!1453 = !DILocation(line: 291, column: 27, scope: !1452)
!1454 = !DILocation(line: 291, column: 25, scope: !1452)
!1455 = !DILocation(line: 291, column: 14, scope: !1452)
!1456 = !DILocation(line: 291, column: 34, scope: !1452)
!1457 = !DILocation(line: 291, column: 39, scope: !1452)
!1458 = !DILocation(line: 291, column: 13, scope: !1407)
!1459 = !DILocation(line: 292, column: 17, scope: !1460)
!1460 = distinct !DILexicalBlock(scope: !1452, file: !7, line: 291, column: 45)
!1461 = !DILocation(line: 293, column: 9, scope: !1460)
!1462 = !DILocation(line: 294, column: 29, scope: !1463)
!1463 = distinct !DILexicalBlock(scope: !1452, file: !7, line: 293, column: 16)
!1464 = !DILocation(line: 294, column: 20, scope: !1463)
!1465 = !DILocation(line: 294, column: 17, scope: !1463)
!1466 = !DILocation(line: 296, column: 5, scope: !1407)
!1467 = !DILocation(line: 272, column: 29, scope: !1402)
!1468 = !DILocation(line: 272, column: 5, scope: !1402)
!1469 = distinct !{!1469, !1404, !1470, !1066}
!1470 = !DILocation(line: 296, column: 5, scope: !1398)
!1471 = !DILocation(line: 301, column: 17, scope: !1472)
!1472 = distinct !DILexicalBlock(scope: !872, file: !7, line: 301, column: 9)
!1473 = !DILocation(line: 301, column: 10, scope: !1472)
!1474 = !DILocation(line: 301, column: 26, scope: !1472)
!1475 = !DILocation(line: 301, column: 31, scope: !1472)
!1476 = !DILocation(line: 301, column: 9, scope: !872)
!1477 = !DILocation(line: 302, column: 13, scope: !1478)
!1478 = distinct !DILexicalBlock(scope: !1472, file: !7, line: 301, column: 37)
!1479 = !DILocation(line: 303, column: 5, scope: !1478)
!1480 = !DILocation(line: 304, column: 25, scope: !1481)
!1481 = distinct !DILexicalBlock(scope: !1472, file: !7, line: 303, column: 12)
!1482 = !DILocation(line: 304, column: 16, scope: !1481)
!1483 = !DILocation(line: 304, column: 13, scope: !1481)
!1484 = !DILocation(line: 307, column: 17, scope: !1485)
!1485 = distinct !DILexicalBlock(scope: !872, file: !7, line: 307, column: 9)
!1486 = !DILocation(line: 307, column: 10, scope: !1485)
!1487 = !DILocation(line: 307, column: 26, scope: !1485)
!1488 = !DILocation(line: 307, column: 31, scope: !1485)
!1489 = !DILocation(line: 307, column: 9, scope: !872)
!1490 = !DILocation(line: 308, column: 13, scope: !1491)
!1491 = distinct !DILexicalBlock(scope: !1485, file: !7, line: 307, column: 37)
!1492 = !DILocation(line: 309, column: 5, scope: !1491)
!1493 = !DILocation(line: 310, column: 25, scope: !1494)
!1494 = distinct !DILexicalBlock(scope: !1485, file: !7, line: 309, column: 12)
!1495 = !DILocation(line: 310, column: 16, scope: !1494)
!1496 = !DILocation(line: 310, column: 13, scope: !1494)
!1497 = !DILocation(line: 313, column: 17, scope: !1498)
!1498 = distinct !DILexicalBlock(scope: !872, file: !7, line: 313, column: 9)
!1499 = !DILocation(line: 313, column: 10, scope: !1498)
!1500 = !DILocation(line: 313, column: 26, scope: !1498)
!1501 = !DILocation(line: 313, column: 31, scope: !1498)
!1502 = !DILocation(line: 313, column: 9, scope: !872)
!1503 = !DILocation(line: 314, column: 13, scope: !1504)
!1504 = distinct !DILexicalBlock(scope: !1498, file: !7, line: 313, column: 37)
!1505 = !DILocation(line: 315, column: 5, scope: !1504)
!1506 = !DILocation(line: 316, column: 25, scope: !1507)
!1507 = distinct !DILexicalBlock(scope: !1498, file: !7, line: 315, column: 12)
!1508 = !DILocation(line: 316, column: 16, scope: !1507)
!1509 = !DILocation(line: 316, column: 13, scope: !1507)
!1510 = !DILocation(line: 319, column: 17, scope: !1511)
!1511 = distinct !DILexicalBlock(scope: !872, file: !7, line: 319, column: 9)
!1512 = !DILocation(line: 319, column: 10, scope: !1511)
!1513 = !DILocation(line: 319, column: 26, scope: !1511)
!1514 = !DILocation(line: 319, column: 31, scope: !1511)
!1515 = !DILocation(line: 319, column: 9, scope: !872)
!1516 = !DILocation(line: 320, column: 13, scope: !1517)
!1517 = distinct !DILexicalBlock(scope: !1511, file: !7, line: 319, column: 37)
!1518 = !DILocation(line: 321, column: 5, scope: !1517)
!1519 = !DILocation(line: 322, column: 25, scope: !1520)
!1520 = distinct !DILexicalBlock(scope: !1511, file: !7, line: 321, column: 12)
!1521 = !DILocation(line: 322, column: 16, scope: !1520)
!1522 = !DILocation(line: 322, column: 13, scope: !1520)
!1523 = !DILocation(line: 325, column: 17, scope: !1524)
!1524 = distinct !DILexicalBlock(scope: !872, file: !7, line: 325, column: 9)
!1525 = !DILocation(line: 325, column: 10, scope: !1524)
!1526 = !DILocation(line: 325, column: 26, scope: !1524)
!1527 = !DILocation(line: 325, column: 31, scope: !1524)
!1528 = !DILocation(line: 325, column: 9, scope: !872)
!1529 = !DILocation(line: 326, column: 13, scope: !1530)
!1530 = distinct !DILexicalBlock(scope: !1524, file: !7, line: 325, column: 37)
!1531 = !DILocation(line: 327, column: 5, scope: !1530)
!1532 = !DILocation(line: 328, column: 25, scope: !1533)
!1533 = distinct !DILexicalBlock(scope: !1524, file: !7, line: 327, column: 12)
!1534 = !DILocation(line: 328, column: 16, scope: !1533)
!1535 = !DILocation(line: 328, column: 13, scope: !1533)
!1536 = !DILocation(line: 331, column: 17, scope: !1537)
!1537 = distinct !DILexicalBlock(scope: !872, file: !7, line: 331, column: 9)
!1538 = !DILocation(line: 331, column: 10, scope: !1537)
!1539 = !DILocation(line: 331, column: 26, scope: !1537)
!1540 = !DILocation(line: 331, column: 31, scope: !1537)
!1541 = !DILocation(line: 331, column: 9, scope: !872)
!1542 = !DILocation(line: 332, column: 13, scope: !1543)
!1543 = distinct !DILexicalBlock(scope: !1537, file: !7, line: 331, column: 36)
!1544 = !DILocation(line: 333, column: 5, scope: !1543)
!1545 = !DILocation(line: 334, column: 25, scope: !1546)
!1546 = distinct !DILexicalBlock(scope: !1537, file: !7, line: 333, column: 12)
!1547 = !DILocation(line: 334, column: 16, scope: !1546)
!1548 = !DILocation(line: 334, column: 13, scope: !1546)
!1549 = !DILocation(line: 337, column: 17, scope: !1550)
!1550 = distinct !DILexicalBlock(scope: !872, file: !7, line: 337, column: 9)
!1551 = !DILocation(line: 337, column: 10, scope: !1550)
!1552 = !DILocation(line: 337, column: 26, scope: !1550)
!1553 = !DILocation(line: 337, column: 31, scope: !1550)
!1554 = !DILocation(line: 337, column: 9, scope: !872)
!1555 = !DILocation(line: 338, column: 13, scope: !1556)
!1556 = distinct !DILexicalBlock(scope: !1550, file: !7, line: 337, column: 37)
!1557 = !DILocation(line: 339, column: 5, scope: !1556)
!1558 = !DILocation(line: 340, column: 25, scope: !1559)
!1559 = distinct !DILexicalBlock(scope: !1550, file: !7, line: 339, column: 12)
!1560 = !DILocation(line: 340, column: 16, scope: !1559)
!1561 = !DILocation(line: 340, column: 13, scope: !1559)
!1562 = !DILocation(line: 343, column: 17, scope: !1563)
!1563 = distinct !DILexicalBlock(scope: !872, file: !7, line: 343, column: 9)
!1564 = !DILocation(line: 343, column: 10, scope: !1563)
!1565 = !DILocation(line: 343, column: 26, scope: !1563)
!1566 = !DILocation(line: 343, column: 31, scope: !1563)
!1567 = !DILocation(line: 343, column: 9, scope: !872)
!1568 = !DILocation(line: 344, column: 13, scope: !1569)
!1569 = distinct !DILexicalBlock(scope: !1563, file: !7, line: 343, column: 37)
!1570 = !DILocation(line: 345, column: 5, scope: !1569)
!1571 = !DILocation(line: 346, column: 25, scope: !1572)
!1572 = distinct !DILexicalBlock(scope: !1563, file: !7, line: 345, column: 12)
!1573 = !DILocation(line: 346, column: 16, scope: !1572)
!1574 = !DILocation(line: 346, column: 13, scope: !1572)
!1575 = !DILocation(line: 349, column: 17, scope: !1576)
!1576 = distinct !DILexicalBlock(scope: !872, file: !7, line: 349, column: 9)
!1577 = !DILocation(line: 349, column: 10, scope: !1576)
!1578 = !DILocation(line: 349, column: 26, scope: !1576)
!1579 = !DILocation(line: 349, column: 31, scope: !1576)
!1580 = !DILocation(line: 349, column: 9, scope: !872)
!1581 = !DILocation(line: 350, column: 13, scope: !1582)
!1582 = distinct !DILexicalBlock(scope: !1576, file: !7, line: 349, column: 37)
!1583 = !DILocation(line: 351, column: 5, scope: !1582)
!1584 = !DILocation(line: 352, column: 25, scope: !1585)
!1585 = distinct !DILexicalBlock(scope: !1576, file: !7, line: 351, column: 12)
!1586 = !DILocation(line: 352, column: 16, scope: !1585)
!1587 = !DILocation(line: 352, column: 13, scope: !1585)
!1588 = !DILocation(line: 355, column: 17, scope: !1589)
!1589 = distinct !DILexicalBlock(scope: !872, file: !7, line: 355, column: 9)
!1590 = !DILocation(line: 355, column: 10, scope: !1589)
!1591 = !DILocation(line: 355, column: 26, scope: !1589)
!1592 = !DILocation(line: 355, column: 32, scope: !1589)
!1593 = !DILocation(line: 355, column: 9, scope: !872)
!1594 = !DILocation(line: 356, column: 13, scope: !1595)
!1595 = distinct !DILexicalBlock(scope: !1589, file: !7, line: 355, column: 38)
!1596 = !DILocation(line: 357, column: 5, scope: !1595)
!1597 = !DILocation(line: 358, column: 25, scope: !1598)
!1598 = distinct !DILexicalBlock(scope: !1589, file: !7, line: 357, column: 12)
!1599 = !DILocation(line: 358, column: 16, scope: !1598)
!1600 = !DILocation(line: 358, column: 13, scope: !1598)
!1601 = !DILocation(line: 361, column: 12, scope: !872)
!1602 = !DILocation(line: 361, column: 5, scope: !872)
!1603 = distinct !DISubprogram(name: "opaque", linkageName: "_ZL6opaqueii", scope: !7, file: !7, line: 13, type: !1604, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !873)
!1604 = !DISubroutineType(types: !1605)
!1605 = !{!9, !9, !9}
!1606 = !DILocalVariable(name: "x", arg: 1, scope: !1603, file: !7, line: 13, type: !9)
!1607 = !DILocation(line: 13, column: 30, scope: !1603)
!1608 = !DILocalVariable(name: "salt", arg: 2, scope: !1603, file: !7, line: 13, type: !9)
!1609 = !DILocation(line: 13, column: 37, scope: !1603)
!1610 = !DILocation(line: 14, column: 9, scope: !1603)
!1611 = !DILocation(line: 14, column: 11, scope: !1603)
!1612 = !DILocation(line: 14, column: 21, scope: !1603)
!1613 = !DILocation(line: 14, column: 36, scope: !1603)
!1614 = !DILocation(line: 14, column: 34, scope: !1603)
!1615 = !DILocation(line: 14, column: 7, scope: !1603)
!1616 = !DILocation(line: 15, column: 11, scope: !1603)
!1617 = !DILocation(line: 15, column: 13, scope: !1603)
!1618 = !DILocation(line: 15, column: 7, scope: !1603)
!1619 = !DILocation(line: 16, column: 11, scope: !1603)
!1620 = !DILocation(line: 16, column: 13, scope: !1603)
!1621 = !DILocation(line: 16, column: 7, scope: !1603)
!1622 = !DILocation(line: 17, column: 11, scope: !1603)
!1623 = !DILocation(line: 17, column: 13, scope: !1603)
!1624 = !DILocation(line: 17, column: 7, scope: !1603)
!1625 = !DILocation(line: 18, column: 12, scope: !1603)
!1626 = !DILocation(line: 18, column: 14, scope: !1603)
!1627 = !DILocation(line: 18, column: 5, scope: !1603)
!1628 = distinct !DISubprogram(name: "doubleIt", linkageName: "_ZL8doubleIti", scope: !7, file: !7, line: 21, type: !330, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !873)
!1629 = !DILocalVariable(name: "x", arg: 1, scope: !1628, file: !7, line: 21, type: !9)
!1630 = !DILocation(line: 21, column: 32, scope: !1628)
!1631 = !DILocation(line: 22, column: 12, scope: !1628)
!1632 = !DILocation(line: 22, column: 14, scope: !1628)
!1633 = !DILocation(line: 22, column: 5, scope: !1628)
!1634 = distinct !DISubprogram(name: "main", scope: !7, file: !7, line: 364, type: !464, scopeLine: 364, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !873)
!1635 = !DILocalVariable(name: "x", scope: !1634, file: !7, line: 365, type: !9)
!1636 = !DILocation(line: 365, column: 9, scope: !1634)
!1637 = !DILocation(line: 365, column: 13, scope: !1634)
!1638 = !DILocation(line: 366, column: 28, scope: !1634)
!1639 = !DILocation(line: 366, column: 9, scope: !1634)
!1640 = !DILocation(line: 366, column: 7, scope: !1634)
!1641 = !DILocation(line: 367, column: 14, scope: !1634)
!1642 = !DILocation(line: 367, column: 12, scope: !1634)
!1643 = !DILocation(line: 368, column: 18, scope: !1634)
!1644 = !DILocation(line: 368, column: 15, scope: !1634)
!1645 = !DILocation(line: 368, column: 25, scope: !1634)
!1646 = !DILocation(line: 369, column: 5, scope: !1634)
