/* C Language Compiler Lexer Created by Vincent Lin (https://github.com/vincnttt/) on 2021.06.11  */

%{
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "y.tab.h"

extern int err_count;
void comment();
%}

%option yylineno

L			[a-zA-Z]
D			[0-9]	

%%
	/* Preprocessor */
"#include <stdio.h>"			{ /* Ignore Preprocessor */ }
"#include <stdlib.h>"			{ /* Ignore Preprocessor */ }

	/* Data types */
"void"							{ return VOID; }
"int"							{ return INT; }
"short"							{ return SHORT; }
"long"							{ return LONG; }
"long long"						{ return LLONG; }
"char"							{ return CHAR; }
"float"							{ return FLOAT; }
"double"						{ return DOUBLE; }
"signed"						{ return SIGNED; }
"unsigned"						{ return UNSIGNED; }

	/* Statements*/
"if"							{ return IF; }
"else"							{ return ELSE; }
"for"							{ return FOR; }
"while"							{ return WHILE; }
"switch"						{ return SWITCH; }
"case"							{ return CASE; }
"default"						{ return DEFAULT; }
"break"							{ return BREAK; }
"continue"						{ return CONTINUE; }
"return"						{ return RETURN; }

	/* Functions */
"printf"						{ return PRINTF; }
"scanf"							{ return SCANF; }

	/* Constants */
'({L}|{D})'						{ return CHAR_CONST; }
[+\-]?{D}+[lLuU]?				{ return DEC_CONST; }
[+\-]?{D}*\.{D}+				{ return FLOAT_CONST; }
(_|{L})({L}|{D}|_){0,31}		{ return IDENTIFIER; }
\"[^\"\n]*\"					{
									return STRING;
								}

	/* Operators */
"+"								{ return '+'; }
"-"								{ return '-'; }
"*"								{ return '*'; }
"/"								{ return '/'; }
"%"								{ return '%'; }
"^"								{ return '^'; }
"="								{ return '='; }
"<"								{ return '<'; }
">"								{ return '>'; }
"++"							{ return INCR; }
"--"							{ return DECR; }
"+="							{ return ADD_ASSIGN; }
"-="							{ return SUB_ASSIGN; }
"*="							{ return MUL_ASSIGN; }
"/="							{ return DIV_ASSIGN; }
"%="							{ return MOD_ASSIGN; }
"^="							{ return XOR_ASSIGN; }
"&&"							{ return LOGIC_AND; }
"||"							{ return LOGIC_OR; }
"=="							{ return EQ; }
"<="							{ return LS_EQ; }
">="							{ return GR_EQ; }
"!="							{ return NOT_EQ; }

	/* Symbols */
"{"								{ return '{'; }
"}"								{ return '}'; }
"("								{ return '('; }
")"								{ return ')'; }
"["								{ return '['; }
"]"								{ return ']'; }
","								{ return ','; }
";"								{ return ';'; }

	/* Unexpected and Illegal characters */
\"[^\"\n]*$						{ 
									printf("[ERROR]: unterminated string %s, in line %d\n", yytext, yylineno); ++err_count;
								}
{D}+({L}|_)+					{ printf("[ERROR]: illegal identifier name '%s', in line %d\n", yytext, yylineno); ++err_count; }
\n                              { /* Ignore newline */ }

	/* Whitespaces and Comments */
"//"[^\n]*    					{ /* Discard comments. */ }
[ \t\r\f\v]+ 	 				{ /* Ignore whitespace */ }
"/*"          					{ comment(); }
\n								{ yylineno++; }
.								{ return yytext[0]; }
%%

#define INPUT_EOF 0

void comment(void) {
    /* Consume characters up to the closing comment marker. */
    char c, prev = 0;
  
    while ((c = input()) != INPUT_EOF) {
        if (c == '/' && prev == '*')
            return;
        prev = c;
    }
    printf("[ERROR]: unexpected comment in line %d\n", yylineno);
    ++err_count;
}

int yywrap() {
	return 1;
}

