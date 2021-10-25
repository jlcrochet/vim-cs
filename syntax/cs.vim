" Vim syntax file
" Language: C#
" Author: Jeffrey Crochet <jlcrochet@pm.me>
" URL: github.com/jlcrochet/vim-cs

if exists("b:current_syntax")
  finish
endif

syn include @csXML syntax/xml.vim

let b:current_syntax = "cs"

" Syntax {{{1
syn sync fromstart

syn cluster csTop contains=TOP

" Miscellaneous (low priority) {{{2
syn keyword csKeywordError contained
      \ abstract as
      \ base bool break byte
      \ case catch char checked class const continue
      \ decimal default delegate do double
      \ else enum event explicit extern
      \ false finally fixed float for foreach
      \ goto
      \ if implicit in int interface internal is
      \ lock long
      \ namespace new null
      \ object operator out override
      \ params private protected public
      \ readonly ref return
      \ sbyte sealed short sizeof stackalloc static string struct switch
      \ this throw true try typeof
      \ uint ulong unchecked unsafe ushort using
      \ virtual void volatile
      \ while

" LHS {{{2
syn keyword csStatement global alias

syn keyword csStatement class struct interface nextgroup=csTypeName skipwhite skipnl
syn match csTypeName /\%#=1\h\w*\%(<.\{-}>\)\=/ contained contains=csKeywordError,csGenericParameters nextgroup=csTypeBlock,csTypeInheritanceOperator,csTypeConstraint skipwhite skipnl
syn match csTypeName /\%#=1@\h\w*\%(<.\{-}>\)\=/ contained contains=csGenericParameters nextgroup=csTypeBlock,csTypeInheritanceOperator skipwhite skipnl
syn region csGenericParameters matchgroup=csDelimiter start=/\%#=1</ end=/\%#=1>/ contained oneline contains=csGenericParameter,csModifier nextgroup=csTypeBlock skipwhite skipnl
syn match csGenericParameter /\%#=1\h\w*/ contained contains=csKeywordError
syn match csGenericParameter /\%#=1@\h\w*/ contained
syn match csTypeInheritanceOperator /\%#=1:/ contained nextgroup=csTypeInheritee,csTypeInheriteeKeyword skipwhite skipnl
syn match csTypeInheritee /\%#=1\h\w*\%(<.\{-}>\)\=/ contained contains=csKeywordError,csGeneric nextgroup=csTypeBlock,csTypeInheriteeMemberAccessOperator,csTypeInheriteeComma,csTypeConstraint,csTypeInheriteeArguments,csTypeConstraintModifier skipwhite skipnl
syn match csTypeInheritee /\%#=1@\h\w*\%(<.\{-}>\)\=/ contained contains=csGeneric nextgroup=csTypeBlock,csTypeInheriteeMemberAccessOperator,csTypeInheriteeComma,csTypeConstraint,csTypeInheriteeArguments,csTypeConstraintModifier skipwhite skipnl
syn keyword csTypeInheriteeKeyword contained nextgroup=csTypeBlock,csTypeInheriteeComma,csTypeConstraint,csTypeConstraintModifier skipwhite skipnl
      \ sbyte short int long byte ushort uint ulong float double decimal nint nuint
      \ char bool object string void dynamic
      \ class struct enum default notnull
syn match csTypeConstraintModifier /\%#=1?/ contained nextgroup=csTypeInheriteeMemberAccessOperator,csTypeInheriteeComma,csTypeConstraint skipwhite skipnl
syn keyword csTypeInheriteeKeyword new contained nextgroup=csTypeInheriteeArguments,csTypeInheritee skipwhite skipnl
syn keyword csTypeInheriteeKeyword managed unmanaged contained nextgroup=csTypeBlock,csTypeInheriteeComma skipwhite skipnl
syn region csTypeInheriteeArguments matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csTypeVariable nextgroup=csTypeBlock,csTypeInheriteeComma,csTypeConstraint,csTypeConstraintLambdaOperator skipwhite skipnl
syn match csTypeConstraintLambdaOperator /\%#=1=>/ contained nextgroup=csTypeInheriteeKeyword skipwhite skipnl
syn match csTypeInheriteeMemberAccessOperator /\%#=1\./ contained nextgroup=csTypeInheritee,csTypeInheriteeKeyword skipwhite skipnl
syn match csTypeInheriteeComma /\%#=1,/ contained nextgroup=csTypeInheritee,csTypeInheriteeKeyword skipwhite skipnl
syn keyword csTypeConstraint where contained nextgroup=csTypeVariable skipwhite skipnl
syn match csTypeVariable /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csTypeInheritanceOperator skipwhite skipnl
syn match csTypeVariable /\%#=1@\h\w*/ contained nextgroup=csTypeInheritanceOperator skipwhite skipnl
syn region csTypeBlock matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=csStatement,csModifier,csType,csTypeIdentifier,csBlock,csComma,csAttribute,csOperatorModifier,csTypeTuple fold

syn keyword csStatement record nextgroup=csRecordName,csRecordModifier skipwhite skipnl
syn keyword csRecordModifier struct class contained nextgroup=csRecordName skipwhite skipnl
syn match csRecordName /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csTypeBlock,csRecordProperties,csTypeInheritanceOperator skipwhite skipnl
syn match csRecordName /\%#=1@\h\w*/ contained nextgroup=csTypeBlock,csRecordProperties,csTypeInheritanceOperator skipwhite skipnl
syn region csRecordProperties matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csType,csTypeIdentifier nextgroup=csTypeBlock,csTypeInheritanceOperator skipwhite skipnl

syn match csDestructorSign /\%#=1\~/ contained containedin=csTypeBlock nextgroup=csDestructor skipwhite skipnl
syn match csDestructor /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csParameters skipwhite skipnl
syn match csDestructor /\%#=1@\h\w*/ contained nextgroup=csParameters skipwhite skipnl

syn keyword csStatement enum nextgroup=csEnumName skipwhite skipnl
syn match csEnumName /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csEnumBlock,csEnumInheritanceOperator skipwhite skipnl
syn match csEnumName /\%#=1@\h\w*/ contained nextgroup=csEnumBlock,csEnumInheritanceOperator skipwhite skipnl
syn match csEnumInheritanceOperator /\%#=1:/ contained nextgroup=csEnumType skipwhite skipnl
syn keyword csEnumType byte sbyte short ushort int uint long ulong nint nuint contained nextgroup=csEnumBlock skipwhite skipnl
syn region csEnumBlock matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=csDeclarator fold

syn keyword csStatement namespace nextgroup=csNamespaceName skipwhite skipnl
syn match csNamespaceName /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csNamespaceNameSeparator,csNamespaceBlock skipwhite skipnl
syn match csNamespaceName /\%#=1@\h\w*/ contained nextgroup=csNamespaceNameSeparator,csNamespaceBlock skipwhite skipnl
syn match csNamespaceNameSeparator /\%#=1\./ contained nextgroup=csNamespaceName skipwhite skipnl
syn region csNamespaceBlock matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=TOP fold

syn keyword csStatement if switch while nextgroup=csCondition skipwhite skipnl
syn region csCondition matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@csRHS

syn keyword csStatement else do

syn keyword csCaseStatement case nextgroup=csCasePatterns
syn region csCasePatterns start=/\%#=1/ end=/\%#=1[,;:\])}]\@=/ contained contains=@csRHS,csOperator,csPatternBlock,csPatternKeyword,csRHSTypeIdentifier

syn keyword csStatement default

syn keyword csStatement for foreach nextgroup=csIterationExpressions skipwhite skipnl
syn region csIterationExpressions matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@csTop,csIterationCondition
syn region csIterationCondition start=/\%#=1;/ end=/\%#=1;/ contained contains=@csRHS

syn keyword csStatement break continue yield

syn keyword csStatement goto nextgroup=csRHSIdentifier,csCaseStatement skipwhite skipnl

syn keyword csStatement return throw nextgroup=@csRHS skipwhite skipnl

syn keyword csStatement try finally
syn keyword csStatement catch nextgroup=csCatchCondition skipwhite skipnl
syn region csCatchCondition matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csTypeIdentifier nextgroup=csOperatorKeyword skipwhite skipnl

syn keyword csStatement checked unchecked

syn keyword csStatement lock nextgroup=csCondition skipwhite skipnl

syn keyword csModifier
      \ abstract async
      \ const
      \ event explicit extern
      \ fixed
      \ implicit in
      \ new
      \ out override
      \ params partial
      \ ref readonly
      \ sealed
      \ unsafe
      \ virtual volatile

syn keyword csModifier delegate nextgroup=csFunctionPointerModifier skipwhite skipnl
syn match csFunctionPointerModifier /\%#=1\*/ contained nextgroup=csGeneric,csFunctionPointerManaged skipwhite skipnl
syn keyword csFunctionPointerManaged managed unmanaged contained nextgroup=csGeneric,csFunctionPointerTypes skipwhite skipnl
syn region csFunctionPointerTypes matchgroup=csDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=csTypeIdentifier nextgroup=csGeneric skipwhite skipnl

syn keyword csStatement using nextgroup=csGuardedStatement,csStatement,csIdentifier,csModifier skipwhite skipnl
syn keyword csStatement fixed nextgroup=csGuardedStatement skipwhite skipnl
syn region csGuardedStatement matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=TOP

syn keyword csModifier public protected private internal static nextgroup=csConstructor skipwhite skipnl
syn match csConstructor /\%#=1\h\w*(\@=/ contained contains=csKeywordError nextgroup=csConstructorParameters
syn match csConstructor /\%#=1@\h\w*(\@=/ contained nextgroup=csConstructorParameters
syn region csConstructorParameters matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csTypeIdentifier,csModifier,csAttribute nextgroup=csLambdaOperator,csConstructorInheritanceOperator skipwhite skipnl
syn match csConstructorInheritanceOperator /\%#=1:/ contained nextgroup=csMethodConstant skipwhite skipnl
syn keyword csMethodConstant this base contained nextgroup=csMethodConstantParameters skipwhite skipnl
syn region csMethodConstantParameters matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@csRHS nextgroup=csLambdaOperator skipwhite skipnl

syn keyword csOperatorModifier operator nextgroup=csOperatorMethod,csBooleanOperatorMethod,csConversionMethod,csConversionMethodKeyword skipwhite skipnl
syn match csOperatorMethod /\%#=1\%(++\=\|--\=\|[~*/%&|^]\|[=!]=\|<[<=]\=\|>[>=]\=\|\.\.\)/ contained nextgroup=csParameters skipwhite skipnl
syn keyword csBooleanOperatorMethod true false contained nextgroup=csParameters skipwhite skipnl
syn match csConversionMethod /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csParameters skipwhite skipnl
syn match csConversionMethod /\%#=1@\h\w*/ contained nextgroup=csParameters skipwhite skipnl
syn keyword csConversionMethodKeyword contained nextgroup=csParameters skipwhite skipnl
      \ sbyte short int long byte ushort uint ulong float double decimal nint nuint
      \ char bool object string void dynamic

syn keyword csType nextgroup=csDeclarator,csIndexerThis,csMemberAccessOperator,csInvocation,csTypeModifier,csOperatorModifier skipwhite skipnl
      \ sbyte short int long byte ushort uint ulong float double decimal nint nuint
      \ char bool object string void dynamic

syn keyword csStatement var nextgroup=csDeclarator,csTupleDeclarator skipwhite skipnl
syn region csTupleDeclarator matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csDeclarator nextgroup=csAssignmentOperator skipwhite skipnl

syn match csIdentifier /\%#=1@\=\h\w*\%(<.\{-}>\)\=\%(?\.\@!\)\=\**\%(\[.\{-}\]\)*/ contains=csGeneric,csTypeModifier nextgroup=csDeclarator,csIndexerThis,csAssignmentOperator,csCompoundAssignmentOperator,csMemberAccessOperator,csNullForgivingOperator,csInvocation,csIndex,csOperatorModifier,csPropertyBlock skipwhite skipnl
syn region csGeneric matchgroup=csDelimiter start=/\%#=1</ end=/\%#=1>/ contained contains=csType,csTypeIdentifier,csModifier nextgroup=csDeclarator,csIndexerThis,csOperatorModifier,csPropertyBlock skipwhite skipnl
syn region csInvocation matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@csRHS nextgroup=csInvocation,csIndex,csOperator skipwhite skipnl
syn region csIndex matchgroup=csDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=@csRHS nextgroup=csInvocation,csIndex,csOperator skipwhite skipnl

syn keyword csConstant this base nextgroup=csAssignmentOperator,csCompoundAssignmentOperator,csMemberAccessOperator,csInvocation,csIndex skipwhite skipnl

syn keyword csIndexerThis this contained nextgroup=csIndexerParameters skipwhite skipnl
syn region csIndexerParameters matchgroup=csDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=csTypeIdentifier,csModifier nextgroup=csPropertyBlock,csLambdaOperator skipwhite skipnl

syn match csDeclarator /\%#=1\h\w*\%(<.\{-}>\)\=/ contained contains=csKeywordError,csGenericParameters nextgroup=csAssignmentOperator,csLambdaOperator,csParameters,csPropertyBlock,csDeclaratorMemberAccessOperator,csOperatorKeyword skipwhite skipnl
syn match csDeclarator /\%#=1@\h\w*\%(<.\{-}>\)\=/ contained contains=csGenericParameters nextgroup=csAssignmentOperator,csLambdaOperator,csParameters,csPropertyBlock,csDeclaratorMemberAccessOperator,csOperatorKeyword skipwhite skipnl
syn match csNotDeclarator /\%#=1\<\h\w*\%(<.\{-}>\)\=\ze\s*\./ contained containedin=csDeclarator contains=csGeneric
syn match csNotDeclarator /\%#=1@\h\w*\%(<.\{-}>\)\=\ze\s*\./ contained containedin=csDeclarator contains=csGeneric
syn match csDeclaratorMemberAccessOperator /\%#=1\./ contained nextgroup=csDeclarator,csIdentifier,csIndexerThis skipwhite skipnl
syn region csParameters matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csTypeIdentifier,csModifier,csThisModifier,csTypeTuple,csAttribute nextgroup=csLambdaOperator,csBlock,csMethodTypeConstraint skipwhite skipnl
syn keyword csThisModifier this contained
syn region csPropertyBlock matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=csAccessor,csModifier nextgroup=csAssignmentOperator skipwhite skipnl fold
syn keyword csAccessor get set init add remove contained nextgroup=csBlock,csLambdaOperator skipwhite skipnl
syn match csComma /\%#=1,/ nextgroup=csDeclarator skipwhite skipnl

syn match csMethodTypeInheritanceOperator /\%#=1:/ contained nextgroup=csMethodTypeInheritee,csMethodTypeInheriteeKeyword skipwhite skipnl
syn match csMethodTypeInheritee /\%#=1\h\w*\%(<.\{-}>\)\=/ contained contains=csKeywordError,csGeneric nextgroup=csMethodTypeInheriteeMemberAccessOperator,csMethodTypeInheriteeComma,csMethodTypeConstraint,csMethodTypeConstraintModifier,csMethodTypeInheriteeArguments,csLambdaOperator skipwhite skipnl
syn match csMethodTypeInheritee /\%#=1@\h\w*\%(<.\{-}>\)\=/ contained contains=csGeneric nextgroup=csMethodTypeInheriteeMemberAccessOperator,csMethodTypeInheriteeComma,csMethodTypeConstraint,csMethodTypeConstraintModifier,csMethodTypeInheriteeArguments,csLambdaOperator skipwhite skipnl
syn keyword csMethodTypeInheriteeKeyword contained nextgroup=csMethodTypeInheriteeComma,csMethodTypeConstraint,csMethodTypeConstraintModifier,csMethodTypeConstraintLambdaOperator skipwhite skipnl
      \ sbyte short int long byte ushort uint ulong float double decimal nint nuint
      \ char bool object string void dynamic
      \ class struct enum default notnull
syn match csMethodTypeConstraintModifier /\%#=1?/ contained nextgroup=csMethodTypeInheriteeMemberAccessOperator,csMethodTypeInheriteeComma,csMethodTypeConstraint,csLambdaOperator skipwhite skipnl
syn keyword csMethodTypeInheriteeKeyword new contained nextgroup=csMethodTypeInheriteeArguments,csMethodTypeInheritee skipwhite skipnl
syn keyword csMethodTypeInheriteeKeyword managed unmanaged contained nextgroup=csMethodTypeInheriteeComma,csLambdaOperator skipwhite skipnl
syn region csMethodTypeInheriteeArguments matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained nextgroup=csMethodTypeInheriteeComma,csMethodTypeConstraint,csMethodTypeConstraintLambdaOperator skipwhite skipnl
syn match csMethodTypeConstraintLambdaOperator /\%#=1=>/ contained nextgroup=csMethodTypeInheriteeKeyword skipwhite skipnl
syn match csMethodTypeInheriteeMemberAccessOperator /\%#=1\./ contained nextgroup=csMethodTypeInheritee,csMethodTypeInheriteeKeyword skipwhite skipnl
syn match csMethodTypeInheriteeComma /\%#=1,/ contained nextgroup=csMethodTypeInheritee,csMethodTypeInheriteeKeyword skipwhite skipnl
syn keyword csMethodTypeConstraint where contained nextgroup=csMethodTypeVariable skipwhite skipnl
syn match csMethodTypeVariable /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csMethodTypeInheritanceOperator skipwhite skipnl
syn match csMethodTypeVariable /\%#=1@\h\w*/ contained nextgroup=csMethodTypeInheritanceOperator skipwhite skipnl

syn region csTypeTuple matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csType,csTypeTuple,csIdentifier nextgroup=csDeclarator skipwhite skipnl

syn region csGroup matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contains=@csRHS,csRHSTypeIdentifier nextgroup=csAssignmentOperator,csMemberAccessOperator,csDeclarator,csInvocation,csIndex,csOperatorKeyword skipwhite skipnl

syn region csAttribute matchgroup=csDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contains=@csRHS

syn match csAssignmentOperator /\%#=1=/ contained nextgroup=@csRHS,csRHSTypeIdentifier,csInitializer skipwhite skipnl
syn match csCompoundAssignmentOperator /\%#=1\%([+\-*/%^]\|&&\=\|||\=\|??\|<<\|>>\)=/ contained nextgroup=@csRHS,csRHSTypeIdentifier,csInitializer skipwhite skipnl

syn match csLambdaOperator /\%#=1=>/ contained nextgroup=@csRHS,csBlock skipwhite skipnl

syn match csMemberAccessOperator /\%#=1?\=\./ contained nextgroup=csIdentifier,csConstant skipwhite skipnl
syn match csMemberAccessOperator /\%#=1->/ contained nextgroup=csIdentifier skipwhite skipnl
syn match csMemberAccessOperator /\%#=1::/ contained nextgroup=csIdentifier skipwhite skipnl

syn match csNullForgivingOperator /\%#=1!/ contained nextgroup=csMemberAccessOperator,csInvocation,csIndex skipwhite skipnl

syn match csIncrementOperator /\%#=1++/
syn match csDecrementOperator /\%#=1--/
syn match csPointerOperator /\%#=1[*&]/

" RHS {{{2
syn cluster csLiterals contains=
      \ csNumber,csBoolean,csNull,csRHSConstant,csCharacter,csString

syn cluster csRHS contains=
      \ @csLiterals,
      \ csUnaryOperator,csUnaryOperatorKeyword,csRHSIdentifier,csRHSType,
      \ csRHSGroup,csFunctionKeyword,csRHSAttribute,csLINQExpression

syn cluster csOperators contains=csOperator,csOperatorKeyword,csTernaryOperator

syn match csUnaryOperator /\%#=1++\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csUnaryOperator /\%#=1--\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csUnaryOperator /\%#=1\.\./ contained nextgroup=@csRHS skipwhite skipnl
syn match csUnaryOperator /\%#=1[!~*&^]/ contained nextgroup=@csRHS skipwhite skipnl

syn keyword csUnaryOperatorKeyword new nextgroup=csRHSIdentifier,csRHSType,csInitializer,csRHSInvocation,csRHSIndex skipwhite skipnl
syn keyword csUnaryOperatorKeyword stackalloc nextgroup=csRHSIdentifier,csRHSType,csInitializer,csRHSIndex skipwhite skipnl
syn keyword csUnaryOperatorKeyword ref out in contained nextgroup=@csRHS skipwhite skipnl
syn keyword csUnaryOperatorKeyword await nextgroup=csStatement,@csRHS skipwhite skipnl
syn keyword csUnaryOperatorKeyword async contained nextgroup=csRHSTypeIdentifier,csRHSType,csRHSGroup skipwhite skipnl
syn keyword csUnaryOperatorKeyword throw nextgroup=@csRHS skipwhite skipnl
syn keyword csUnaryOperatorKeyword static contained nextgroup=csRHSType,csRHSIdentifier skipwhite skipnl
syn keyword csUnaryOperatorKeyword delegate contained nextgroup=csFunctionPointerModifier skipwhite skipnl

syn keyword csUnaryOperatorKeyword var contained nextgroup=csRHSDeclarator,csRHSTupleDeclarator skipwhite skipnl
syn match csRHSDeclarator /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=@csOperators skipwhite skipnl
syn region csRHSTupleDeclarator matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=csRHSDeclarator nextgroup=@csOperators skipwhite skipnl

syn keyword csRHSType contained nextgroup=csMemberAccessOperator,csRHSGroup,csRHSIndex,csRHSDeclarator,csTypeModifier,csOperatorKeyword skipwhite skipnl
      \ sbyte short int long byte ushort uint ulong float double decimal nint nuint
      \ char bool object string void dynamic

syn match csRHSIdentifier /\%#=1\h\w*\%(<.\{-}>\)\=/ contained contains=csKeywordError,csGeneric nextgroup=@csOperators,csRHSInvocation,csRHSIndex,csInitializer,csOperatorModifier skipwhite skipnl
syn match csRHSIdentifier /\%#=1@\h\w*\%(<.\{-}>\)\=/ contained contains=csGeneric nextgroup=@csOperators,csRHSInvocation,csRHSIndex,csInitializer,csOperatorModifier skipwhite skipnl
syn region csRHSInvocation matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@csRHS nextgroup=@csOperators,csInitializer,csRHSInvocation,csRHSIndex skipwhite skipnl
syn region csRHSIndex matchgroup=csDelimiter start=/\%#=1?\=\[/ end=/\%#=1\]/ contained contains=@csRHS nextgroup=@csOperators,csRHSInvocation,csRHSIndex,csInitializer skipwhite skipnl

syn region csInitializer matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=@csRHS,csInitializer nextgroup=@csOperators skipwhite skipnl

execute g:cs#syntax#numbers

syn keyword csBoolean true false contained nextgroup=@csOperators skipwhite skipnl
syn keyword csNull null contained nextgroup=@csOperators skipwhite skipnl
syn keyword csRHSConstant this base contained nextgroup=@csOperators,csRHSInvocation,csRHSIndex skipwhite skipnl

syn match csCharacter /\%#=1'\%(\\\%(x\x\{1,4}\|u\x\{4}\|U\x\{8}\|.\)\|.\)'/ contained contains=csEscapeSequence,csEscapeSequenceError nextgroup=@csOperators skipwhite skipnl

syn region csString matchgroup=csStringDelimiter start=/\%#=1"/   end=/\%#=1"/ contained oneline contains=csEscapeSequence,csEscapeSequenceError nextgroup=@csOperators skipwhite skipnl
syn region csString matchgroup=csStringDelimiter start=/\%#=1$"/  end=/\%#=1"/ contained oneline contains=csBraceEscape,csEscapeSequence,csEscapeSequenceError,csStringInterpolation,csStringInterpolationError nextgroup=@csOperators skipwhite skipnl
syn region csString matchgroup=csStringDelimiter start=/\%#=1@"/  end=/\%#=1"/ contained skip=/\%#=1""/ contains=csQuoteEscape nextgroup=@csOperators skipwhite skipnl
syn region csString matchgroup=csStringDelimiter start=/\%#=1$@"/ end=/\%#=1"/ contained skip=/\%#=1""/ contains=csBraceEscape,csQuoteEscape,csStringInterpolation,csStringInterpolationError nextgroup=@csOperators skipwhite skipnl
syn region csString matchgroup=csStringDelimiter start=/\%#=1@$"/ end=/\%#=1"/ contained skip=/\%#=1""/ contains=csQuoteEscape,csBraceEscape,csStringInterpolation,csStringInterpolationError nextgroup=@csOperators skipwhite skipnl

syn match csStringInterpolationError /\%#=1[{}]/ contained
syn region csStringInterpolation matchgroup=csStringInterpolationDelimiter start=/\%#=1{/ end=/\%#=1\%(:.\{-}\)\=}/ contained oneline contains=@csRHS

syn match csEscapeSequenceError /\%#=1\\./ contained
syn match csEscapeSequence /\%#=1\\\%(['"\\0abfnrtv]\|x\x\{1,4}\|u\x\{4}\|U\x\{8}\)/ contained

syn match csQuoteEscape /\%#=1""/ contained
syn match csBraceEscape /\%#=1{{/ contained
syn match csBraceEscape /\%#=1}}/ contained

syn region csTernaryOperator matchgroup=csOperator start=/\%#=1?/ end=/\%#=1:/ contained oneline contains=@csRHS nextgroup=@csRHS skipwhite skipnl

syn match csOperator /\%#=1!/ contained nextgroup=@csOperators,csRHSInvocation,csRHSIndex skipwhite skipnl
syn match csOperator /\%#=1!=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1=[=]\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1=>/ contained nextgroup=@csRHS,csBlock skipwhite skipnl
syn match csOperator /\%#=1[+*/%]=\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1-[>=]\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1++/ contained nextgroup=@csOperators skipwhite skipnl
syn match csOperator /\%#=1--/ contained nextgroup=@csOperators skipwhite skipnl
syn match csOperator /\%#=1<\%(<=\=\|=\)\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1>\%(>=\=\|=\)\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1&&\==\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1||\==\=/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1??=\=/ contained nextgroup=@csRHS skipwhite skipnl

syn match csOperator /\%#=1\./ contained nextgroup=csRHSIdentifier,csRHSConstant skipwhite skipnl
syn match csOperator /\%#=1\.\./ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1?\./ contained nextgroup=csRHSIdentifier,csRHSConstant skipwhite skipnl
syn match csOperator /\%#=1:/ contained nextgroup=@csRHS skipwhite skipnl
syn match csOperator /\%#=1::/ contained nextgroup=csRHSIdentifier skipwhite skipnl

syn region csRHSGroup matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@csRHS,csRHSTypeIdentifier nextgroup=@csRHS,@csOperators skipwhite skipnl
syn match csRHSTypeIdentifier /\%#=1\h\w*\%(<.\{-}>\)\=\%(?[.\[]\@!\)\=\**/ contained contains=csType,csKeywordError,csGeneric,csTypeModifier nextgroup=csDeclarator,@csOperators,csRHSGroup,csRHSIndex skipwhite skipnl
syn match csRHSTypeIdentifier /\%#=1@\h\w*\%(<.\{-}>\)\=\%(?[.\[]\@!\)\=\**/ contained contains=csGeneric,csTypeModifier nextgroup=csDeclarator,@csOperators,csRHSGroup,csRHSIndex skipwhite skipnl

syn keyword csOperatorKeyword as contained nextgroup=csRHSTypeIdentifier skipwhite skipnl
syn keyword csOperatorKeyword in when and or contained nextgroup=@csRHS skipwhite skipnl

syn keyword csOperatorKeyword is contained nextgroup=csPatterns
syn region csPatterns start=/\%#=1/ end=/\%#=1[,;:\])}]\@=/ contained contains=@csLiterals,csOperator,csTernaryOperator,csPatternIdentifier,csPatternGroup,csObjectPattern,csPatternKeyword
syn match csPatternIdentifier /\%#=1\h\w*\%(<.\{-}>\)\=/ contained contains=csType,csGeneric,csKeywordError nextgroup=csDeclarator,csPatternKeyword,csPatternGroup,csRHSIndex skipwhite skipnl
syn match csPatternIdentifier /\%#=1@\h\w*\%(<.\{-}>\)\=/ contained contains=csGeneric nextgroup=csDeclarator,csPatternKeyword,csPatternGroup,csRHSIndex skipwhite skipnl
syn region csPatternGroup matchgroup=csDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@csRHS,csOperator,csPatternGroup,csPatternBlock,csPatternKeyword nextgroup=csDeclarator,csPatternKeyword,csRHSInvocation,csRHSIndex skipwhite skipnl
syn keyword csPatternKeyword and or not when contained
syn region csObjectPattern matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=csPatternProperty nextgroup=csDeclarator,csPatternKeyword skipwhite skipnl
syn match csPatternProperty /\%#=1\h\w*/ contained contains=csKeywordError nextgroup=csPatternPropertyColon,csPatternPropertyMemberAccessOperator skipwhite skipnl
syn match csPatternProperty /\%#=1@\h\w*/ contained nextgroup=csPatternPropertyColon,csPatternPropertyMemberAccessOperator skipwhite skipnl
syn match csPatternPropertyColon /\%#=1:/ contained nextgroup=csPatterns skipwhite skipnl
syn match csPatternPropertyMemberAccessOperator /\%#=1\./ contained nextgroup=csPatternProperty skipwhite skipnl

syn keyword csOperatorKeyword switch contained nextgroup=csPatternBlock skipwhite skipnl
syn region csPatternBlock matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=@csLiterals,csUnaryOperatorKeyword,csOperator,csTernaryOperator,csPatternIdentifier,csPatternGroup,csObjectPattern,csPatternKeyword nextgroup=@csOperators skipwhite skipnl fold

syn keyword csOperatorKeyword with contained nextgroup=csInitializer skipwhite skipnl

syn keyword csFunctionKeyword typeof default checked unchecked sizeof nameof contained nextgroup=csRHSInvocation skipwhite skipnl

syn region csRHSAttribute matchgroup=csDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=@csRHS nextgroup=@csRHS,@csOperators skipwhite skipnl

syn region csLINQExpression start=/\%#=1\<from\>/ end=/\%#=1[)\]};]\@=/ contained transparent contains=csLINQKeyword,@csRHS
syn keyword csLINQKeyword from into contained nextgroup=csDeclarator,csLINQDeclaration skipwhite skipnl
syn match csLINQDeclaration /\%#=1@\=\h\w*\%(\.@\=\h\w*\)*\%(<.\{-}>\)\=\s\+\%(in\>\)\@!@\=\h\w*/ contained contains=csType,csIdentifier
syn keyword csLINQKeyword let contained nextgroup=csDeclarator skipwhite skipnl
syn keyword csLINQKeyword in where select orderby group by ascending descending join on equals contained

" Miscellaneous (high priority) {{{2
syn region csComment matchgroup=csCommentDelimiter start=/\%#=1\/\// end=/\%#=1$/ contains=csTodo containedin=ALLBUT,csString,csComment
syn region csComment matchgroup=csCommentDelimiter start=/\%#=1\/\*/ end=/\%#=1\*\// contains=csTodo containedin=ALLBUT,csString,csComment fold
syn region csComment matchgroup=csCommentDelimiter start=/\%#=1\/\/\// end=/\%#=1$/ contains=csTodo,@csXML containedin=ALLBUT,csString,csComment
syn region csComment matchgroup=csCommentDelimiter start=/\%#=1\/\/\*/ end=/\%#=1\*\/\// contains=csTodo,@csXML containedin=ALLBUT,csString,csComment fold
syn keyword csTodo TODO NOTE XXX FIXME HACK TBD contained

syn match csDirective /\%#=1^\s*\zs#.*/ containedin=ALLBUT,csDirective,csString,csComment

syn match csTypeModifier /\%#=1[*?]/ contained nextgroup=csDeclarator,csTypeModifier skipwhite skipnl
syn region csTypeModifier matchgroup=csDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=@csRHS nextgroup=csDeclarator,csInitializer,csTypeModifier skipwhite skipnl

syn match csTypeIdentifier /\%#=1\h\w*\%(<.\{-}>\)\=?\=\**\%(\[.\{-}\]\)*/ contained contains=csType,csKeywordError,csGeneric,csTypeModifier nextgroup=csDeclarator,csIndexerThis,csTypeMemberAccessOperator,csOperatorModifier skipwhite skipnl
syn match csTypeIdentifier /\%#=1@\h\w*\%(<.\{-}>\)\=?\=\**\%(\[.\{-}\]\)*/ contained contains=csGeneric,csTypeModifier nextgroup=csDeclarator,csIndexerThis,csTypeMemberAccessOperator,csOperatorModifier skipwhite skipnl
syn match csTypeMemberAccessOperator /\%#=1\./ contained nextgroup=csTypeIdentifier skipwhite skipnl
syn match csTypeMemberAccessOperator /\%#=1::/ contained nextgroup=csTypeIdentifier skipwhite skipnl

syn region csBlock matchgroup=csDelimiter start=/\%#=1{/ end=/\%#=1}/ contains=TOP fold

" Highlighting {{{1
hi def link csComment Comment
hi def link csCommentDelimiter csComment
hi def link csTodo Todo
hi def link csDirective PreProc
hi def link csStatement Statement
hi def link csCaseStatement csStatement
hi def link csTypeName Typedef
hi def link csRecordName csTypeName
hi def link csRecordModifier csStatement
hi def link csGenericParameter csDeclarator
hi def link csTypeInheritanceOperator csOperator
hi def link csTypeConstraintLambdaOperator csOperator
hi def link csTypeInheriteeMemberAccessOperator csMemberAccessOperator
hi def link csTypeConstraint csStatement
hi def link csTypeConstraintModifier csTypeModifier
hi def link csTypeInheriteeKeyword Keyword
hi def link csMethodTypeInheritanceOperator csTypeInheritanceOperator
hi def link csMethodTypeConstraintLambdaOperator csTypeConstraintLambdaOperator
hi def link csMethodTypeInheriteeMemberAccessOperator csTypeInheriteeMemberAccessOperator
hi def link csMethodTypeConstraint csTypeConstraint
hi def link csMethodTypeInheriteeKeyword csTypeInheriteeKeyword
hi def link csMethodTypeConstraintModifier csTypeConstraintModifier
hi def link csTypeVariable csIdentifier
hi def link csEnumName Typedef
hi def link csEnumInheritanceOperator csOperator
hi def link csEnumType csType
hi def link csNamespaceName Typedef
hi def link csNamespaceNameSeparator csOperator
hi def link csDelimiter Delimiter
hi def link csModifier csStatement
hi def link csFunctionPointerModifier csTypeModifier
hi def link csOperatorModifier csModifier
hi def link csOperatorMethod csOperator
hi def link csBooleanOperatorMethod csBoolean
hi def link csIncrementOperator csOperator
hi def link csDecrementOperator csOperator
hi def link csPointerOperator csOperator
hi def link csType Type
hi def link csTypeModifier csType
hi def link csTypeIdentifier csIdentifier
hi def link csRHSTypeIdentifier csTypeIdentifier
hi def link csTypeMemberAccessOperator csMemberAccessOperator
hi def link csDeclarator Identifier
hi def link csNotDeclarator csIdentifier
hi def link csDeclaratorMemberAccessOperator csMemberAccessOperator
hi def link csConstructor csDeclarator
hi def link csConstructorInheritanceOperator csOperator
hi def link csDestructorSign csOperator
hi def link csDestructor csConstructor
hi def link csMethodConstant csConstant
hi def link csConstant Constant
hi def link csRHSConstant csConstant
hi def link csIndexerThis csConstant
hi def link csThisModifier csConstant
hi def link csOperator Operator
hi def link csAssignmentOperator csOperator
hi def link csCompoundAssignmentOperator csAssignmentOperator
hi def link csMemberAccessOperator csOperator
hi def link csNullForgivingOperator csOperator
hi def link csLambdaOperator csOperator
hi def link csAccessor csStatement
hi def link csOperatorKeyword Keyword
hi def link csPatternKeyword csOperatorKeyword
hi def link csPatternProperty csIdentifier
hi def link csPatternPropertyMemberAccessOperator csMemberAccessOperator
hi def link csUnaryOperatorKeyword csOperatorKeyword
hi def link csRHSDeclarator csDeclarator
hi def link csRHSIdentifier csIdentifier
hi def link csRHSType csType
hi def link csLINQKeyword Keyword
hi def link csUnaryOperator csOperator
hi def link csPatternIdentifier csIdentifier
hi def link csFunctionKeyword Keyword
hi def link csNumber Number
hi def link csBoolean Boolean
hi def link csNull Constant
hi def link csCharacter Character
hi def link csString String
hi def link csStringDelimiter csString
hi def link csStringInterpolationDelimiter PreProc
hi def link csStringInterpolationError Error
hi def link csEscapeSequence PreProc
hi def link csEscapeSequenceError Error
hi def link csQuoteEscape csEscapeSequence
hi def link csBraceEscape csEscapeSequence
hi def link csFieldInitializer csDeclarator
hi def link csKeywordError Error
" }}}1

" vim:fdm=marker
