%{
  #include <stdio.h>
  #include "cgen.h"		


extern int yylex(void);
extern int line_num;
%}

%union
{
	char* crepr;
}
//Termatika Symbola  
%token <crepr> TK_IDENT
%token KEYWORD_VOID 
%token KEYWORD_FUNC 
%token KEYWORD_START 
%token KEYWORD_STRING 
%token KEYWORD_CONST 
%token KEYWORD_NUMBER 
%token KEYWORD_BOOLEAN 
%token KEYWORD_TRUE  
%token KEYWORD_FALSE 
%token KEYWORD_VAR 
%token KEYWORD_IF 
%token KEYWORD_ELSE 
%token KEYWORD_FOR 
%token KEYWORD_WHILE 
%token KEYWORD_FUNCTION 
%token KEYWORD_BREAK 
%token KEYWORD_CONTIMUE 
%token KEYWORD_NOT 
%token KEYWORD_AND 
%token KEYWORD_OR 
%token KEYWORD_RETURN 
%token KEYWORD_NULL
%token ASSIGN_OP   
%token RELATIONAL_ASSIGN_OP
%token NOTEQUAL_OP    
%token SMALLER_OP    
%token SMALLER_OR_EQ_OP   
%token POWER_OP   
%token <crepr> CONST_STRING     
%token <crepr> CONST_INT  
%token <crepr> CONST_DEM  
%token <crepr> CONST_EXP 

%start program //Arxiko symbolo ths grammatikhs tha einai to program

//Mh Termatika Symbola
%type <crepr> decl_list  decl_list_item_id parameter_list if_statement const_decl const_var_decl var_decl var_const_decl function_return_type
%type <crepr> const_decl_list const_decl_list_item for_statement function_call boolean_const func_decl array_decl_infunction empty_array_decl
%type <crepr> var_decl_list var_decl_list_item  assignment_command body function_parameters_call func_decl_list parameter
%type <crepr> type_spec simple_commands while_statement break_statement return_statement continue_statement array_assign
%type <crepr>  expr ARITHMETIC_CONST ARITMETIC_EXPR statements  non_simple_comments array array_decl array_decl_list

//Operators me megalyterh proteraiothta pane sto telos

%left KEYWORD_OR
%left KEYWORD_AND 
%left  RELATIONAL_ASSIGN_OP NOTEQUAL_OP SMALLER_OP SMALLER_OR_EQ_OP

%left '-' '+'
%left '*' '/' '%'
%right POWER_OP
%right KEYWORD_NOT 



//--------------KANONES THS GRAMMATIKHS-------------
%%

program: decl_list func_decl_list  KEYWORD_FUNCTION KEYWORD_START '(' ')' ':' KEYWORD_VOID '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if (yyerror_count == 0) {
  //  #include  <mslib.h>  //gia tis synarthseis diabasmatos-grapsimatos
  //ta include einai sto arxeio mslib.h sto str c_prologue
     puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n%s\n\n", $1,$2);
	  printf("int main() {\n   %s\n} \n", $10);
	}
}
|decl_list array_decl_list func_decl_list   KEYWORD_FUNCTION KEYWORD_START '(' ')' ':' KEYWORD_VOID '{' body '}' { 
	if (yyerror_count == 0) {
     puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n%s\n%s\n\n", $1,$2,$3);
	  printf("int main() {\n   %s\n} \n", $11);
	}
}
|func_decl_list KEYWORD_FUNCTION KEYWORD_START '(' ')' ':' KEYWORD_VOID '{' body '}' { 
	if (yyerror_count == 0) {
     puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("int main() {\n   %s\n} \n", $9);
	}
}
|array_decl_list func_decl_list KEYWORD_FUNCTION KEYWORD_START '(' ')' ':' KEYWORD_VOID '{' body '}' { 
	if (yyerror_count == 0) {
     puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n%s\n\n", $1,$2);
	  printf("int main() {\n   %s\n} \n", $10);
	}
}
|decl_list KEYWORD_FUNCTION KEYWORD_START '(' ')' ':' KEYWORD_VOID '{' body '}' { 
	if (yyerror_count == 0) {
     puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("int main() {\n   %s\n} \n", $9);
	}
}
|decl_list array_decl_list KEYWORD_FUNCTION KEYWORD_START '(' ')' ':' KEYWORD_VOID '{' body '}' { 
	if (yyerror_count == 0) {
     puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n%s\n\n", $1,$2);
	  printf("int main() {\n   %s\n} \n", $10);
	}
}
|KEYWORD_FUNCTION KEYWORD_START '(' ')' ':' KEYWORD_VOID '{' body '}' { 
	if (yyerror_count == 0) {
     puts(c_prologue); 
	  printf("/* program */ \n\n");
	  
	  printf("int main() {\n   %s\n} \n", $8);
	}
}
;

body:
 decl_list non_simple_comments { $$ = template("%s\n%s",$1,$2); }
| non_simple_comments { $$ = template("%s",$1); }
;

decl_list:
 var_const_decl { $$ = $1; }

;

var_const_decl:
 const_decl { $$ = template("%s", $1); }
| const_var_decl  { $$ = template("%s", $1); }
| var_decl  { $$ = template("%s", $1); }
;

const_var_decl:
const_decl var_decl { $$ = template("%s\n%s",$1,$2); }
;

func_decl_list:
func_decl_list func_decl { $$ = template("%s %s",$1,$2); }
|func_decl { $$ = template("%s", $1); }
;

func_decl:
KEYWORD_FUNCTION TK_IDENT '(' parameter_list ')' ':' function_return_type '{'  body    '}' { $$ = template("\n%s %s(%s)\n{\n%s\n}", $7, $2,$4,$9); }
;

var_decl:
var_decl  KEYWORD_VAR var_decl_list ':' type_spec ';'  { $$ = template("\n%s\n%s %s;",$1, $5, $3); } 
|KEYWORD_VAR var_decl_list ':' type_spec ';' { $$ = template("%s %s;", $4, $2); } 

;

const_decl:
const_decl KEYWORD_CONST const_decl_list ':' type_spec ';' { $$ = template("%s \nconst %s %s;",$1, $5, $3); }
|KEYWORD_CONST const_decl_list ':' type_spec ';' { $$ = template("const %s %s;", $4, $2); }
 ;

array_decl_list:
array_decl_list array_decl { $$ = template("%s %s",$1, $2); } 
|array_decl { $$ = template("%s",$1); } 
;

array_decl:
array ':' type_spec';' { $$ = template("\n%s %s;",$3,$1); } 
| empty_array_decl { $$ = $1; }
;

empty_array_decl:
'['']' ':' TK_IDENT ';' { $$ = template("\n* %s;",$4); }
;

array:
TK_IDENT'['CONST_INT ']' { $$ = template("%s[%s]",$1,$3); } 
;

parameter_list:
%empty { $$=""; }
|parameter_list ','parameter{ $$ = template("%s,%s",$1,$3); }
|parameter { $$ = template("%s",$1); }
;

parameter:
TK_IDENT ':' type_spec{ $$ = template("%s %s",  $3,$1); }
|TK_IDENT '['']' ':' type_spec{ $$ = template("%s  %s[]",  $5,$1); }
;

boolean_const:
KEYWORD_TRUE { $$ = template("1");}
| KEYWORD_FALSE { $$ = template("0");}
;

var_decl_list:
var_decl_list ',' var_decl_list_item{ $$ = template("%s, %s", $1, $3); }
| var_decl_list_item { $$ = template("%s", $1); }
;

var_decl_list_item:
decl_list_item_id { $$ = template("%s",$1); }
|decl_list_item_id ASSIGN_OP expr { $$ = template("%s=%s", $1, $3);}
| TK_IDENT '['CONST_INT']' { $$ = template("*%s", $1); } 
;

const_decl_list: 
const_decl_list ',' const_decl_list_item { $$ = template("%s, %s", $1, $3); }
| const_decl_list_item { $$ = template("%s", $1); }
;

const_decl_list_item: 
decl_list_item_id ASSIGN_OP expr { $$ = template("%s = %s", $1, $3);}
;

decl_list_item_id: 
TK_IDENT { $$ = $1; } 
;

type_spec:
 KEYWORD_NUMBER { $$ = "double"; }
| KEYWORD_STRING { $$ = "char*" ;}
| KEYWORD_BOOLEAN { $$="int"; }
;

function_return_type:
%empty { $$ = "void"; }
| KEYWORD_NUMBER { $$ = "double"; }
| KEYWORD_STRING { $$ = "char*" ;}
| KEYWORD_BOOLEAN { $$="int"; }
| KEYWORD_VOID { $$ = "void"; }
|'['']' type_spec {$$=template("%s *",$3);}
;

expr:
ARITMETIC_EXPR { $$ = template("%s",$1);}
;

ARITMETIC_EXPR:
  ARITHMETIC_CONST                                            { $$ = $1; }
| CONST_STRING                                                { $$ = $1; }
| boolean_const                                               { $$ = $1; }
| function_call                                               { $$ = $1; }
| TK_IDENT                                                    { $$ = template("%s",$1);  }
| '(' ARITMETIC_EXPR ')'                                      { $$ = template("(%s)", $2); }
| KEYWORD_NOT ARITMETIC_EXPR                                  { $$ = template("!%s",$2);  }
| ARITMETIC_EXPR '+' ARITMETIC_EXPR                           { $$ = template("%s + %s", $1, $3); }
| ARITMETIC_EXPR '-' ARITMETIC_EXPR                           { $$ = template("%s - %s", $1, $3); }
| '+' ARITMETIC_EXPR                                          { $$ = template("+%s",$2);}
| '-' ARITMETIC_EXPR                                          { $$ = template("-%s",$2);}
| array_assign												  { $$ = template("%s",$1);}
| ARITMETIC_EXPR POWER_OP ARITMETIC_EXPR                      { $$ = template("%s + %s", $1, $3); }
| ARITMETIC_EXPR '*' ARITMETIC_EXPR                           { $$ = template("%s * %s", $1, $3); }
| ARITMETIC_EXPR RELATIONAL_ASSIGN_OP ARITMETIC_EXPR          { $$ = template("%s == %s",$1,$3); }  
| ARITMETIC_EXPR NOTEQUAL_OP ARITMETIC_EXPR                   { $$ = template("%s != %s",$1,$3); }
| ARITMETIC_EXPR SMALLER_OP ARITMETIC_EXPR                    { $$ = template("%s < %s",$1,$3);  }
| ARITMETIC_EXPR SMALLER_OR_EQ_OP ARITMETIC_EXPR              { $$ = template("%s <= %s",$1,$3);  }
| ARITMETIC_EXPR KEYWORD_AND ARITMETIC_EXPR                   { $$ = template("%s && %s",$1,$3); }  
| ARITMETIC_EXPR KEYWORD_OR ARITMETIC_EXPR                    { $$ = template("%s || %s",$1,$3); }
| ARITMETIC_EXPR '/' ARITMETIC_EXPR                           { $$ = template("%s / %s", $1, $3); }
| ARITMETIC_EXPR '%' ARITMETIC_EXPR                           { $$ = template("(int)%s %% (int)%s", $1, $3); }
;

ARITHMETIC_CONST:
CONST_INT       { $$ = $1; } 
| CONST_DEM     { $$=$1; }
| CONST_EXP     { $$=$1; }
;


statements:
 simple_commands	{ $$ = template("%s",$1); }
|'{'  non_simple_comments    '}'';' { $$ = template("{%s}",$2); }
;

non_simple_comments:
%empty { $$=""; }
| non_simple_comments simple_commands { $$ = template("%s\n%s",$1,$2); }
;

simple_commands: 
 if_statement { $$ = template("	%s",$1); }
| for_statement { $$ = template("	%s",$1); }
| assignment_command ';' { $$ = template("	%s;",$1); }
| function_call';' { $$ = template("	%s;",$1); }
| while_statement { $$ = template("	%s",$1); }
| break_statement';' { $$ = template("	%s",$1); }
| continue_statement';' { $$ = template("	%s",$1); }
| return_statement';' {$$ = template("	%s;",$1); }
;

assignment_command:
TK_IDENT ASSIGN_OP expr { $$ = template("%s = %s",$1,$3); }
| array_assign ASSIGN_OP expr{ $$=template("%s = %s",$1,$3); } 
| array_decl_infunction { $$ = template("%s",$1); } //Den einai assigment apla mphke edw gt alliws tha eixame conflict,kathws arxizoun kai ta 2 me ton kanona array
;

array_assign:
TK_IDENT'['TK_IDENT ']' { $$ = template("%s[(int)%s]",$1,$3); } 
|TK_IDENT'['CONST_INT ']' { $$ = template("%s[%s]",$1,$3); } 

;

array_decl_infunction:
array ':' type_spec  { $$ = template("\n%s %s",$3,$1); } 
;

if_statement:
 KEYWORD_IF '('expr')'  statements { $$ = template("if (%s)\n%s ",$3,$5); }
| KEYWORD_IF '('expr')'   statements KEYWORD_ELSE statements { $$ = template("if (%s)\n%s\n\telse%s ",$3,$5,$7); }
;


for_statement:
KEYWORD_FOR '('assignment_command ';' expr ';' assignment_command ')' statements { $$ = template("for (%s;%s;%s)\n\t%s",$3,$5,$7,$9); }
|KEYWORD_FOR '('assignment_command ';' ';' assignment_command ')' statements { $$ = template("for (%s;;%s)%s",$3,$6,$8); }

;

while_statement:
KEYWORD_WHILE '('expr')' statements { $$ = template("while (%s)\n%s",$3,$5); }
;

break_statement:
KEYWORD_BREAK { $$ = template("break;"); }
;

continue_statement:
KEYWORD_CONTIMUE { $$ = template("continue;"); }
;

return_statement:
KEYWORD_RETURN {$$ = template("return");}
|KEYWORD_RETURN expr {$$ = template("return %s",$2);}
;

function_call:
TK_IDENT'(' function_parameters_call ')' { $$ = template("%s(%s)",$1,$3); }
;

function_parameters_call:
%empty { $$=""; }
|function_parameters_call','ARITMETIC_EXPR { $$ = template("%s,%s",$1,$3); }
|ARITMETIC_EXPR { $$ = template("%s",$1); }
;

%%
int main () {
  if ( yyparse() == 0 ) //Synarthsh tou Lektikou m Analyth H yyparse kalei thn yylex g n pairnei tokens
    printf("//Accepted!\n");
  else
    printf("\nRejected!\n");
}