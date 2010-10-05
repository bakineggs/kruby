kmod KRUBY-SYNTAX is
  --- looked at parse.y in ruby

  --- %token <id>   tIDENTIFIER tFID tGVAR tIVAR tCONSTANT tCVAR tLABEL
  sorts Identifier Fid Gvar Ivar Constant Cvar Label

  --- %token <node> tINTEGER tFLOAT tSTRING_CONTENT tCHAR
  sorts Integer Float StringContent Char

  --- %token <node> tNTH_REF tBACK_REF
  sorts NthRef BackRef

  --- %token <num>  tREGEXP_END
  sort RegexpEnd

  --- %type <node> singleton strings string string1 xstring regexp
  sorts Singleton Strings String String1 Xstring Regexp

  --- %type <node> string_contents xstring_contents regexp_contents string_content
  sorts StringContents XstringContents RegexpContents StringContent

  --- %type <node> words qwords word_list qword_list word
  sorts Words Qwords WordList QwordList Word

  --- %type <node> literal numeric dsym cpath
  sorts Literal Numeric Dsym Cpath

  --- %type <node> top_compstmt top_stmts top_stmt
  sorts TopCompstmt TopStmts TopStmt

  --- %type <node> bodystmt compstmt stmts stmt expr arg primary command command_call method_call
  sorts Bodystmt Compstmt Stmts Stmt Expr Arg Primary Command CommandCall MethodCall

  --- %type <node> expr_value arg_value primary_value
  sorts ExprValue ArgValue PrimaryValue

  --- %type <node> if_tail opt_else case_body cases opt_rescue exc_list exc_var opt_ensure
  sorts IfTail OptElse CaseBody Cases OptRescue ExcList ExcVar OptEnsure

  --- %type <node> args call_args opt_call_args
  sorts Args CallArgs OptCallArgs

  --- %type <node> paren_args opt_paren_args
  sorts ParenArgs OptParenArgs

  --- %type <node> command_args aref_args opt_block_arg block_arg var_ref var_lhs
  sorts CommandArgs ArefArgs OptBlockArg BlockArg VarRef VarLhs

  --- %type <node> command_asgn mrhs superclass block_call block_command
  sorts CommandAsgn Mrhs Superclass BlockCall BlockCommand

  --- %type <node> f_block_optarg f_block_opt
  sorts FBlockOptarg FBlockOpt

  --- %type <node> f_arglist f_args f_arg f_arg_item f_optarg f_marg f_marg_list f_margs
  sorts FArglist FArgs FArg FArgItem FOptarg FMarg FMargList FMargs

  --- %type <node> assoc_list assocs assoc undef_list backref string_dvar for_var
  sorts AssocList Assocs Assoc UndefList Backref StringDvar ForVar

  --- %type <node> block_param opt_block_param block_param_def f_opt
  sorts BlockParam OptBlockParam BlockParamDef FOpt

  --- %type <node> bv_decls opt_bv_decl bvar
  sorts BvDecls OptBvDecl Bvar

  --- %type <node> lambda f_larglist lambda_body
  sorts Lambda FLarglist LambdaBody

  --- %type <node> brace_block cmd_brace_block do_block lhs none fitem
  sorts BraceBlock CmdBraceBlock DoBlock Lhs None Fitem

  --- %type <node> mlhs mlhs_head mlhs_basic mlhs_item mlhs_node mlhs_post mlhs_inner
  sorts Mlhs MlhsHead MlhsBasic MlhsItem MlhsNode MlhsPost MlhsInner

  --- %type <id>   fsym variable sym symbol operation operation2 operation3
  sorts Fsym Variable Sym Symbol Operation Operation2 Operation3

  --- %type <id>   cname fname op f_rest_arg f_block_arg opt_f_block_arg f_norm_arg f_bad_arg
  sorts Cname Fname Op FRestArg FBlockArg OptFBlockArg FNormArg FBadArg

  --- %token tUPLUS		/* unary+ */
  --- %token tUMINUS		/* unary- */
  --- %token tPOW		/* ** */
  --- %token tCMP		/* <=> */
  --- %token tEQ		/* == */
  --- %token tEQQ		/* === */
  --- %token tNEQ		/* != */
  --- %token tGEQ		/* >= */
  --- %token tLEQ		/* <= */
  --- %token tANDOP tOROP	/* && and || */
  --- %token tMATCH tNMATCH	/* =~ and !~ */
  --- %token tDOT2 tDOT3	/* .. and ... */
  --- %token tAREF tASET	/* [] and []= */
  --- %token tLSHFT tRSHFT	/* << and >> */
  --- %token tCOLON2		/* :: */
  --- %token tCOLON3		/* :: at EXPR_BEG */
  --- %token <id> tOP_ASGN	/* +=, -=  etc. */
  --- %token tASSOC		/* => */
  --- %token tLPAREN		/* ( */
  --- %token tLPAREN_ARG	/* ( */
  --- %token tRPAREN		/* ) */
  --- %token tLBRACK		/* [ */
  --- %token tLBRACE		/* { */
  --- %token tLBRACE_ARG	/* { */
  --- %token tSTAR		/* * */
  --- %token tAMPER		/* & */
  --- %token tLAMBDA		/* -> */
  --- %token tSYMBEG tSTRING_BEG tXSTRING_BEG tREGEXP_BEG tWORDS_BEG tQWORDS_BEG
  --- %token tSTRING_DBEG tSTRING_DVAR tSTRING_END tLAMBEG

  sort OpAsgn
  syntax OpAsgn ::= +=
                  | -=
                  | *=
                  | /= --- are there others?

  ---

  sort Rparen
  syntax Rparen ::= OptNl )

  sort Rbracket
  syntax Rbracket ::= OptNl ]

  sort OptNl
  syntax OptNl ::=
                 | \n

  --- %%

  sort Program
  syntax Program ::= TopCompStmt

  syntax TopCompStmt ::= TopStmts OptTerms

  syntax TopStmts ::= None
                    | TopStmt
                    | TopStmts Terms TopStmt
                    | Error TopStmt

  syntax TopStmt ::= Stmt
                   | `BEGIN` { TopCompStmt }

  syntax Bodystmt ::= Compstmt OptRescue OptElse OptEnsure

  syntax Compstmt ::= Stmts OptTerms

  syntax Stmts ::= None
                 | Stmt
                 | Stmts Terms Stmt
                 | Error Stmt

  syntax Stmt ::= alias Fitem Fitem
                | alias Gvar Gvar
                | alias Gvar BackRef
                | alias Gvar NthRef
                | undef UndefList
                | Stmt ModifierIf ExprValue
                | Stmt ModifierUnless ExprValue
                | Stmt ModifierWhile ExprValue
                | Stmt ModifierUntil ExprValue
                | Stmt ModifierRescue Stmt
                | END { Compstmt }
                | CommandAsgn
                | Mlhs = CommandCall
                | VarLhs OpAsgn CommandCall
                | PrimaryValue [ OptCallArgs Rbracket OpAsgn CommandCall
                | PrimaryValue . Identifier OpAsgn CommandCall
                | PrimaryValue . Constant OpAsgn CommandCall
                | PrimaryValue :: Constant OpAsgn CommandCall --- yyerror
                | PrimaryValue :: Identifier OpAsgn CommandCall
                | Backref OpAsgn CommandCall
                | Lhs = Mrhs
                | Mlhs = ArgValue
                | Mlhs = Mrhs
                | Expr

  syntax CommandAsgn ::= Lhs = CommandCall
                       | Lhs = CommandAsgn

  syntax Expr ::= CommandCall
                | Expr and Expr
                | Expr or Expr
                | not OptNl Expr
                | ! CommandCall
                | Arg

  syntax ExprValue ::= Expr

  syntax CommandCall ::= Command
                       | BlockCommand

  syntax BlockCommand ::= BlockCall
                        | BlockCall . Operation2 CommandArgs
                        | BlockCall :: Operation2 CommandArgs

  syntax CmdBraceBlock ::= { OptBlockParam CompStmt }

  syntax Command ::= Operation CommandArgs --- %prec tLOWEST
                   | Operation CommandArgs CmdBraceBlock
                   | PrimaryValue . Operation2 CommandArgs --- %prec tLOWEST
                   | PrimaryValue . Operation2 CommandArgs CmdBraceBlock
                   | PrimaryValue :: Operation2 CommandArgs --- %prec tLOWEST
                   | PrimaryValue :: Operation2 CommandArgs CmdBraceBlock
                   | super CommandArgs
                   | yield CommandArgs
                   | return CallArgs
                   | break CallArgs
                   | next CallArgs

  syntax Mlhs ::= MlhsBasic
                | ( MlhsInner RParen

  syntax MlhsInner ::= MlhsBasic
                     | ( MlhsInner Rparen

  syntax MlhsBasic ::= MlhsHead
                     | MlhsHead MlhsItem
                     | MlhsHead * MlhsNode
                     | MlhsHead * MlhsNode , MlhsPost
                     | MlhsHead *
                     | MlhsHead * , MlhsPost
                     | * MlhsNode
                     | * MlhsNode , MlhsPost
                     | *
                     | * , MlhsPost

  syntax MlhsItem ::= MlhsNode
                    | ( MlhsInner Rparen

  syntax MlhsHead ::= MlhsItem ,
                    | MlhsHead MlhsItem ,

  syntax MlhsPost ::= MlhsItem
                    | MlhsPost , MlhsItem

  syntax MlhsNode ::= Variable
                    | PrimaryValue [ OptCallArgs Rbracket
                    | PrimaryValue . Identifier
                    | PrimaryValue :: Identifier
                    | PrimaryValue . Constant
                    | PrimaryValue :: Constant
                    | :: Constant
                    | Backref

  syntax Lhs ::= Variable
               | PrimaryValue [ OptCallArgs Rbracket
               | PrimaryValue . Identifier
               | PrimaryValue :: Identifier
               | PrimaryValue . Constant
               | PrimaryValue :: Constant
               | :: Constant
               | Backref

  syntax Cname ::= Identifier
                 | Constant

  syntax Cpath ::= Cname
                 | :: Cname
                 | PrimaryValue :: Cname

  syntax Fname ::= Identifier
                 | Constant
                 | Fid
                 | Op
                 | Reswords

  syntax Fsym ::= Fname
                | Symbol

  syntax Fitem ::= Fsym
                 | Dsym

  syntax UndefList ::= Fitem
                     | UndefList , Fitem

  syntax Op ::= `|`
              | ^
              | &
              | <=>
              | ==
              | ===
              | =~
              | !~
              | >
              | >=
              | <
              | <=
              | !=
              | <<
              | >>
              | +
              | -
              | *
              | /
              | %
              | **
              | !
              | ~
              | tUPLUS --- unary+ ??
              | tUMINUS	--- unary- ??
              | []
              | []=
              | `

  syntax Reswords ::= keyword__LINE__ --- ??
                    | keyword__FILE__ --- ??
                    | keyword__ENCODING__ --- ??
                    | `BEGIN`
                    | `END`
                    | alias
                    | and
                    | begin
                    | break
                    | case
                    | class
                    | def
                    | defined
                    | do
                    | else
                    | elsif
                    | end
                    | ensure
                    | false
                    | for
                    | in
                    | module
                    | next
                    | nil
                    | not
                    | or
                    | redo
                    | rescue
                    | retry
                    | return
                    | self
                    | super
                    | then
                    | true
                    | undef
                    | when
                    | yield
                    | if
                    | unless
                    | while
                    | until
endkm
