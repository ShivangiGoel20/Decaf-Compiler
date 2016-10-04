%{ 
	#define YY_NO_UNPUT
	#include<bits/stdc++.h>
	#include <iostream>
	#include <stdio.h>
	#include <string>
	#include "code.tab.h"
	using namespace std;
	int yyerror(char *s);
%}
%option warn noyywrap noinput nounput yylineno
%%

"class"  				    			{cout<<"CLASS\n";return CLASS;}

"Program" 								{cout<<"PROGRAM\n";return PROGRAM;}

"int"									{cout<<"INT\n";return INT;}

"boolean"								{cout<<"BOOL\n";return BOOL;}

"void"									{cout<<"VOID\n";return VOID;}

"true"									{cout<<"BOOL_LITERAL\n";return BOOL_LITERAL;}

"false"									{cout<<"BOOL_LITERAL\n";return BOOL_LITERAL;}

"for"									{cout<<"FOR\n";return FOR;} 

"if"									{cout<<"IF\n";return IF;}

"else"									{cout<<"ELSE\n";return ELSE;}

"break"									{cout<<"BREAK\n";return BREAK;}

"continue"								{cout<<"CONTINUE\n";return CONTINUE;}

"return"								{cout<<"RETURN\n";return RETURN;}

"callout"								{cout<<"CALLOUT\n";return CALLOUT;}

";"										{cout<<"SEMI_COLON\n";return SEMI_COLON;}

"("										{cout<<"OPEN_PARENTHESES\n";return OPEN_PARENTHESES ;}

")"										{cout<<"CLOSE_PARENTHESES\n";return CLOSE_PARENTHESES;}

"["										{cout<<"OPEN_SQR_BRACKET\n";return OPEN_SQR_BRACKET;}

"]"										{cout<<"CLOSE_SQR_BRACKET\n";return CLOSE_SQR_BRACKET;}

"{" 	 								{cout<<"OPEN_BRACE\n";return OPEN_BRACE;}

"}"										{cout<<"CLOSE_BRACE\n";return CLOSE_BRACE;}

"null" 									{cout<<"NULL_TOKEN\n";return NULL_TOKEN;}

","										{cout<<"COMMA\n";return COMMA;}

"+"										{cout<<"PLUS\n";return PLUS;}

"-"										{cout<<"MINUS\n";return MINUS;}

"*"										{cout<<"MULTIPLY\n";return MULTIPLY;}

"%"										{cout<<"MOD\n";return MOD;}

"/"										{cout<<"DIVIDE\n";return DIVIDE;}

"<"										{cout<<"LESS\n";return LESS;}

">"										{cout<<"GREATER\n";return GREATER;}

[_a-zA-Z]+[_a-zA-Z0-9]*					{yylval=strdup(yytext);cout<<"IDENTIFIER\n";return IDENTIFIER;}

[0-9]+								    {yylval=atoi(yytext);cout<<"DECIMAL_LITERAL\n";return DECIMAL_LITERAL;}

0x[0-9a-fA-F]+							{cout<<"HEX_LITERAL\n";return HEX_LITERAL;}

"="|"+="|"-="							{cout<<"ASSIGNMENT_OPERATOR\n";return ASSIGNMENT_OPERATOR;}

'(\\.|[^\\'])+'             			{cout<<"CHAR_LITERAL\n";return CHAR_LITERAL;}

"=="									{cout<<"EQUAL_EQUAL\n";return EQUAL_EQUAL;}

"<="									{cout<<"LESS_EQUAL\n";return LESS_EQUAL;}

">="									{cout<<"GREATER_EQUAL\n";return GREATER_EQUAL;}

"!="									{cout<<"NOT_EQUAL\n";return NOT_EQUAL;}

"||"									{cout<<"OR\n";return OR;}

"&&"									{cout<<"AND\n";return AND;}

\/\/.*$  														

[ \t\n]*		

\"(\\.|[^\\"])*\"                   	{cout<<"STRING: "<<yytext<<endl;return STRING_LITERAL;}

[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] 	{}

"//".*		  {}/* discard comments */

.	                        			{return *yytext;}

%%

