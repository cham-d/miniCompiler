%{
  #include <stdio.h>
  #include <string.h>  
  #include "cgen.h"
  #include  "myanalyzer.tab.h"
int lineNum = 1;
int debug =0; //Gia n mhn fainontai ta printf sto arxeio myprog.c
%}

/*Arxikes Synthykes sto video 1.15.10*/
ID      [a-zA-Z_][0-9a-zA-Z_]*
DIGIT   [0-9]
INTEGER ([1-9]+{DIGIT}*)?{DIGIT}
DECIMAL  {INTEGER}?"."{DIGIT}+
EXP      {DECIMAL}[E|e][+|-]?{INTEGER}
STRING   \"(\\[nt\"r]|[^\n"\\])*\"

%x comment 

%%  
{STRING}    { if (debug == 1) printf("%-40s %s\n","Token CONST_STRING  ", yytext);  yylval.crepr = strdup(yytext);
             return CONST_STRING;}

{INTEGER}    {if (debug == 1) printf("%-40s %s\n","Token CONST_INT:  ", yytext);  yylval.crepr = strdup(yytext);
             return CONST_INT;}
{DECIMAL}    {if (debug == 1) printf("%-40s %s\n","Token CONST_DEM:  ", yytext);  yylval.crepr = strdup(yytext);
             return CONST_DEM;}

{EXP}        {if (debug == 1) printf("%-40s %s\n","Token CONST_EXP:  ", yytext);  yylval.crepr = strdup(yytext);
             return CONST_EXP;}

number      {if (debug == 1) printf("%-40s %s\n","Token KW_NUMBER:  ", yytext);
             return KEYWORD_NUMBER;}
             
if          {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_IF:  ", yytext);
            return KEYWORD_IF;}

else		    {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_ELSE:  ", yytext);
            return KEYWORD_ELSE;}

boolean     {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_BOOLEAN:  ", yytext);
            return KEYWORD_BOOLEAN;}

string      {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_STRING:  ", yytext);
            return KEYWORD_STRING;}

void        {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_VOID:  ", yytext);
            return KEYWORD_VOID;}

true        {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_TRUE:  ", yytext);
            return KEYWORD_TRUE;} 

false        {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_FALSE:  ", yytext);
            return KEYWORD_FALSE;} 

var         {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_VAR:  ", yytext);
            return KEYWORD_VAR;} 

const       {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_CONST: ", yytext);
            return KEYWORD_CONST;} 

for         {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_FOR:  ", yytext);
            return KEYWORD_FOR;} 

while       {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_WHILE:  ", yytext);
            return KEYWORD_WHILE;} 

function    {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_FUNCTION:  ", yytext);
            return KEYWORD_FUNCTION;} 

break       {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_BREAK:  ", yytext);
            return KEYWORD_BREAK;} 

continue    {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_CONTIMUE:  ", yytext);
            return KEYWORD_CONTIMUE;} 

not         {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_NOT:  ", yytext);
            return KEYWORD_NOT;}

start       {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_START:  ", yytext);
            return KEYWORD_START;}  

and         {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_AND:  ", yytext);
            return KEYWORD_AND;} 

or          {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_OR:  ", yytext);
            return KEYWORD_OR;} 

return      {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_RETURN:  ", yytext);
            return KEYWORD_RETURN;}

null        {if (debug == 1) printf("%-40s %s\n","Token KEYWORD_NULL:  ", yytext);
            return KEYWORD_NULL;} 

{ID}        {if (debug == 1) printf("%-40s %s\n","Token TK_IDENT:  ", yytext);yylval.crepr = strdup(yytext);//Shmasiologikh timh toy Id
             return TK_IDENT; }

"+"                 {if (debug == 1) printf("%-40s %s\n","Token PLUS_OP:  ", yytext);
                      return '+';}
"-"                 {if (debug == 1) printf("%-40s %s\n","Token MINUS_OP:  ", yytext);
                      return '-';}
"*"                 {if (debug == 1) printf("%-40s %s\n","Token MULT_OP:  ", yytext);
                      return '*';}
"/"                 {if (debug == 1) printf("%-40s %s\n","Token DIVISION_OP:  ", yytext);
                      return '/';}
"%"                 {if (debug == 1) printf("%-40s %s\n","Token MOD_OP:  ", yytext);
                      return '%';}
"**"               {if (debug == 1) printf("%-40s %s\n","Token POWER_OP:  ", yytext);
                      return POWER_OP;}
"=="                {if (debug == 1) printf("%-40s %s\n","Token RELATIONAL_ASSIGN_OP:  ", yytext);
                      return RELATIONAL_ASSIGN_OP;}
"!="                {if (debug == 1) printf("%-40s %s\n","Token NOTEQUAL_OP:  ", yytext);
                      return NOTEQUAL_OP;}
"<"	                {if (debug == 1) printf("%-40s %s\n","Token SMALLER_OP:  ", yytext);
                      return SMALLER_OP;}
"<="                {if (debug == 1) printf("%-40s %s\n","Token SMALLER_OR_EQ_OP:  ", yytext);
                      return SMALLER_OR_EQ_OP;}
"="	                {if (debug == 1) printf("%-40s %s\n","Token ASSIGN_OP:  ", yytext);
                      return ASSIGN_OP;}
";"	                {if (debug == 1) printf("%-40s %s\n","Token SEMICOLON:  ", yytext);
                      return ';';}
"("	                {if (debug == 1) printf("%-40s %s\n","Token LEFT_PARENTHESIS:  ", yytext);
                      return '(';}
")"	                {if (debug == 1) printf("%-40s %s\n","Token RIGHT_PARENTHESIS:  ", yytext);
                      return ')';}
","	                {if (debug == 1) printf("%-40s %s\n","Token COMMA:  ", yytext);
                      return ',';}
"["	                {if (debug == 1) printf("%-40s %s\n","Token LEFT_BRACKET:  ", yytext);
                      return '[';}
"]"	                {if (debug == 1) printf("%-40s %s\n","Token RIGHT_BRACKET:  ", yytext);
                      return ']';}
"{"	                {if (debug == 1) printf("%-40s %s\n","Token LEFT_CURLY_BRACKET:  ", yytext);
                      return '{';}
"}"	                {if (debug == 1) printf("%-40s %s\n","Token RIGHT_CURLY_BRACKET:  ", yytext);
                      return '}';}
":"	                {if (debug == 1) printf("%-40s %s\n","Token COLON:  ", yytext);
                      return ':';}

[ \r\t]			        /* skip whitespace */

"//"[^\n]*  		if (debug == 1) printf("Line comment at line: %d\n", lineNum);/* eat line comments */

"/*"                { BEGIN(comment); if (debug == 1) printf("comment started at line: %d\n", lineNum); }



<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*/\n]*   /* eat up '*'s not followed by '/'s */
<comment>\n             ++lineNum;
<comment>"*"+"/"        { BEGIN(INITIAL); if (debug == 1) printf("comment ended at line: %d\n", lineNum); }

<<EOF>> 		return EOF;

\n                  {++lineNum;}
.           { 
  if (debug == 1) printf("\033[1;31m"); /*SET COLOR RED*/
  if (debug == 1) printf("Line %d Lexical Error: Unrecognized literal %s\n", lineNum, yytext); 
  if (debug == 1) printf("\033[0m"); }  /*SET DEFAULT COLOR*/



