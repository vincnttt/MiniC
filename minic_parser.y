/* C Language Compiler Parser Created by Vincent Lin (https://github.com/vincnttt/) on 2021.06.11  */

%{
#include "lex.yy.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YYERROR_VERBOSE 1

extern int yylineno;
int err_count = 0;
int yyerror(char *msg);
%}

%locations

%token IDENTIFIER STRING 
%token CHAR_CONST DEC_CONST FLOAT_CONST

%token VOID INT SHORT LONG LLONG CHAR FLOAT DOUBLE SIGNED UNSIGNED
%token IF ELSE FOR WHILE SWITCH CASE DEFAULT BREAK CONTINUE RETURN
%token PRINTF SCANF

%token INCR DECR
%token ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN XOR_ASSIGN

%left '+' '-' '*' '/' '%' '^'
%left '<' '>' ',' LS_EQ GR_EQ 
%left LOGIC_AND LOGIC_OR EQ NOT_EQ

%right '=' '!'

%nonassoc UMINUS
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start program

%%
program
: program builder
| builder
;

builder
: function
| declaration
;

function
: type IDENTIFIER '(' arg_list ')' compound_stmt
| type IDENTIFIER '(' arg_list error compound_stmt
| type IDENTIFIER error arg_list ')' compound_stmt
| type IDENTIFIER '(' VOID ')' compound_stmt
;

type
: datatype pointer
| datatype
;

pointer
: '*' pointer
| '*'
;

datatype
: sign_spec type_spec
| type_spec
;

sign_spec
: SIGNED
| UNSIGNED
;

type_spec
: VOID
| INT
| SHORT
| SHORT INT
| LONG
| LONG INT
| LLONG
| LLONG INT
| CHAR
| FLOAT
| DOUBLE
;

arg_list
: arguments
| /* Could be empty */
;

arguments
: arguments ',' arg
| arg
;

arg
: type identifier
;

stmt
: compound_stmt
| single_stmt
;

compound_stmt
: '{' statements '}'
;

statements
: statements stmt
| /* Could be empty */
;

output
: PRINTF '(' STRING ')' ';'
| PRINTF error STRING ')' ';'
| PRINTF '(' STRING error ';'
| PRINTF '(' STRING ')' error
| PRINTF '(' STRING ',' out_data ')' ';'
| PRINTF error STRING ',' out_data ')' ';'
| PRINTF '(' STRING error out_data ')' ';'
| PRINTF '(' STRING ',' out_data error ';'
| PRINTF '(' STRING ',' out_data ')' error
;

out_data
: IDENTIFIER
| out_data ',' arr_access
| out_data ',' IDENTIFIER
;

input
: SCANF '(' STRING ',' '&' IDENTIFIER ')' ';'
| SCANF error STRING ',' '&' IDENTIFIER ')' ';'
| SCANF '(' STRING error '&' IDENTIFIER ')' ';'
| SCANF '(' STRING ',' error IDENTIFIER ')' ';'
| SCANF '(' STRING ',' '&' IDENTIFIER error ';'
| SCANF '(' STRING ',' '&' IDENTIFIER ')' error
;

single_stmt
: declaration
| if_stmt
| for_stmt
| while_stmt
| switch_stmt
| output
| input
| func_call ';'
| func_call error
| BREAK ';'
| BREAK error
| CONTINUE ';'
| CONTINUE error
| RETURN ';'
| RETURN error
| RETURN sub_expr ';'
| RETURN sub_expr error
;

if_stmt
: IF '(' expr ')' stmt %prec LOWER_THAN_ELSE
| IF '(' expr ')' stmt ELSE stmt
;

for_stmt
: FOR '(' expr_stmt expr_stmt ')' stmt
| FOR '(' expr_stmt expr_stmt expr ')' stmt
;

while_stmt
: WHILE '(' expr ')' stmt
;

switch_stmt
: SWITCH '(' IDENTIFIER ')' '{' switch_expr '}'
;

switch_expr
: struct_case
;

struct_case
: cases
| CASE constant ':' stmt BREAK ';' struct_case
;

cases
: CASE constant ':' switch_expr
| end_case
;

end_case
: DEFAULT ':' stmt
;

declaration
: type decl_list ';'
| decl_list ';'
| unary_expr ';'
;

decl_list
: decl_list ',' sub_decl
| sub_decl
;

sub_decl
: assignment_expr
| identifier
| arr_access
;

arr_in
: single_arr
| multi_arr
;

single_arr
: '{' sub_arr '}'
;

sub_arr
: arr_index
| sub_arr ',' arr_index
;

multi_arr
: '{' sub_multi_arr '}'
;

sub_multi_arr
: single_arr
| sub_multi_arr ',' single_arr
;

expr_stmt
: expr ';'
| expr error
| ';'
;

expr
: expr ',' sub_expr
| sub_expr
;

sub_expr
: sub_expr '>' sub_expr
| sub_expr '<' sub_expr
| sub_expr LS_EQ sub_expr
| sub_expr GR_EQ sub_expr
| sub_expr EQ sub_expr
| sub_expr NOT_EQ sub_expr
| sub_expr LOGIC_AND sub_expr
| sub_expr LOGIC_OR sub_expr
| '!' sub_expr
| arithmetic_expr
| assignment_expr
| unary_expr
;

/* Left Hand Side of the equation*/
lhs
: identifier
| arr_access
;

identifier
: IDENTIFIER
;

assign_op
: '='
| ADD_ASSIGN
| SUB_ASSIGN
| MUL_ASSIGN
| DIV_ASSIGN
| MOD_ASSIGN
| XOR_ASSIGN
;

arithmetic_expr
: arithmetic_expr '+' arithmetic_expr
| arithmetic_expr '-' arithmetic_expr
| arithmetic_expr '*' arithmetic_expr
| arithmetic_expr '/' arithmetic_expr
| arithmetic_expr '%' arithmetic_expr
| arithmetic_expr '^' arithmetic_expr
| '(' arithmetic_expr ')'
| '-' arithmetic_expr %prec UMINUS
| identifier
| constant
;

assignment_expr
: lhs assign_op arithmetic_expr
| lhs assign_op arr_access
| lhs assign_op arr_in
| lhs assign_op func_call
| lhs assign_op unary_expr
| unary_expr assign_op unary_expr
;

unary_expr
: identifier INCR
| identifier DECR
| INCR identifier
| DECR identifier
;

constant
: CHAR_CONST
| DEC_CONST
| FLOAT_CONST
;

arr_access
: identifier '[' arr_index ']'
| identifier '[' arr_index ']' '[' arr_index ']'
;

arr_index
: constant
| identifier
;

func_call
: identifier '(' param_list ')'
| identifier '(' ')'
;

param_list
: param_list ',' param
| param
;

param
: sub_expr
| STRING
;
%%

int main(int argc, char *argv[]) {
	yyin = fopen(argv[1], "r");
	
	/* Display project logo */
	printf("===========================================\n");
  	printf("\t  __  __ _       _  _____ \n");
  	printf("\t |  \\/  (_)     (_)/ ____|\n");
  	printf("\t | \\  / |_ _ __  _| |     \n");
  	printf("\t | |\\/| | | '_ \\| | |     \n");
  	printf("\t | |  | | | | | | | |____ \n");
  	printf("\t |_|  |_|_|_| |_|_|\\_____|\n");
  	printf("===========================================\n\n");
  	
  	if(!parsing_res()) {
  		printf("[SUCCESS]: No error(s) found.\n");	
	}
	
	fclose(yyin);
	return 0;
}

int parsing_res() {
	err_count;
	int status = yyparse();
	
	if(status || err_count) {
		printf("[FOUND]: %d error(s)\n", err_count);
		return 3;	/* yyparse will returns 0, 1 or 2 */
	}
	return 0;
}

int yyerror(char *msg) {
	++err_count;
	printf("[ERROR]: %s, in line %d\n", msg, yylineno);
}

