kmod KRUBY-SYNTAX is
  sorts Program TopCompstmt TopStmts TopStmt Bodystmt Compstmt Stmts Stmt
  sorts Expr ExprValue
  sorts CommandCall BlockCommand CmdBraceBlock Command
  sorts Mlhs MlhsInner MlhsBasic MlhsItem MlhsHead MlhsPost MlhsNode Lhs
  sorts Cname Cpath Fname Fsym Fitem UndefList Op Reswords
  sorts Arg ArgValue ArefArgs ParenArgs OptParenArgs OptCallArgs CallArgs
  sorts CommandArgs BlockArg OptBlockArg Args
  sorts Mrhs Primary PrimaryValue
  sorts KBegin KIf KUnless KWhile KUntil KCase KFor KClass KModule KDef KEnd
  sorts Then Do IfTail OptElse ForVar FMarg FMargList FMargs
  sorts BlockParam OptBlockParam BlockParamDef OptBvDecl BvDecls Bvar Lambda
  sorts FLarglist LambdaBody DoBlock BlockCall MethodCall BraceBlock CaseBody
  sorts Cases OptRescue ExcList ExcVar OptEnsure Literal
  sorts Strings String String1 Xstring Regexp Words WordList Word
  sorts Qwords QwordList StringContents XstringContents RegexpContents
  sorts StringContent StringDvar Symbol Sym Dsym Variable VarRef VarLhs Backref
  sorts Superclass FArglist FArgs FBadArg FNormArg FArgItem FArg FOpt FBlockOpt
  sorts FBlockOptarg FOptarg RestargMark FRestArg BlkargMark FBlockArg OptFBlockArg
  sorts SIngleton AssocList Assocs Assoc Operation Operation2 Operation3 DotOrColon
  sorts OptTerms OptNl RParen RBracket Trailer Term Terms None Error

  syntax Program ::= TopCompstmt

  syntax TopCompstmt ::= TopStmts OptTerms

  syntax TopStmts ::= None | TopStmt | TopStmts Terms TopStmt | Error TopStmt

  syntax TopStmt ::= Stmt l `BEGIN` { TopCompstmt }

  syntax Bodystmt ::= Compstmt OptRescue OptElse OptEnsure

  syntax Compstmt ::= Stmts OptTerms

  syntax Stmts ::= None | Stmt | Stmts Terms Stmt | Error Stmt

  syntax Stmt ::= alias Fitem Fitem
endkm
