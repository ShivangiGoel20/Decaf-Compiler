%{
#define YY_NO_UNPUT
#include <iostream>
#include<bits/stdc++.h>
#include <stdio.h>
#include <string>
#include <stdlib.h>
using namespace std;
int yyerror(char *s);
int yylex(void);
string * temp;
int t_size,inte;
int flag;
FILE * fp= fopen ("bison_output.txt", "w");
%}



%token CLASS
%token PROGRAM
%token FOR
%token IF
%token ELSE
%token CONTINUE
%token BREAK
%token RETURN
%token CALLOUT
%token ASSIGNMENT_OPERATOR
%token IDENTIFIER
%token VOID INT BOOL
%token HEX_LITERAL
%token DECIMAL_LITERAL
%token CHAR_LITERAL
%token BOOL_LITERAL
%token STRING_LITERAL
%token SEMI_COLON
%token OPEN_PARENTHESES 
%token CLOSE_PARENTHESES
%token OPEN_SQR_BRACKET
%token CLOSE_SQR_BRACKET
%token OPEN_BRACE
%token CLOSE_BRACE
%token NULL_TOKEN
%token COMMA
%token NOT
%left INT BOOL
%nonassoc ELSE
%nonassoc '='
%left OR
%left AND
%nonassoc EQUAL_EQUAL NOT_EQUAL
%nonassoc LESS GREATER GREATER_EQUAL LESS_EQUAL 
%left PLUS MINUS 
%left MULTIPLY DIVIDE MOD
%nonassoc '!' UMINUS
%nonassoc '[' '.'


%%


program: 					CLASS PROGRAM  OPEN_BRACE field_decl_multiple method_decl_multiple CLOSE_BRACE
							{fprintf(fp,"PROGRAM ENCOUNTERED\n");}
							;
																		
field_decl_multiple:				/*epsilon*/  				                
							|field_decl_multiple field_decl_single SEMI_COLON 	
							;

field_decl_single: 			type idList
							;

type: 						INT {flag=1;}
							| BOOL{flag=0;} 
							;
idList:                 	IDENTIFIER id_single  
							{
							
							if(flag)fprintf(fp,"INT DECLARATION ENCOUNTERED \n");
							else if(flag==0)fprintf(fp,"BOOLEAN DECLARATION ENCOUNTERED \n");
							fprintf(fp,"ID=%s\n",$1);
							if(t_size!=0)fprintf(fp,"SIZE=%d\n",t_size);						
							}                      
							|IDENTIFIER OPEN_SQR_BRACKET int_literal CLOSE_SQR_BRACKET id_single {
							if(flag)fprintf(fp,"INT DECLARATION ENCOUNTERED \n");
							else if(flag==0)fprintf(fp,"BOOLEAN DECLARATION ENCOUNTERED \n");
							fprintf(fp,"ID=%s\n",$1);
							fprintf(fp,"Size=%d\n",$3);
							} 
							;
							
id_single: 					/*epsilon*/  								
							|COMMA IDENTIFIER id_single
							{fprintf(fp,"ID=%s\n",$2);
							}
							|COMMA IDENTIFIER OPEN_SQR_BRACKET int_literal CLOSE_SQR_BRACKET id_single
							{
							fprintf(fp,"ID=%s\n",$2);
							fprintf(fp,"Size=%d\n",$4);
							
							}
							;
							
						
method_decl_multiple:				/*epsilon*/ 								
						|method_decl_single method_decl_multiple
						{fprintf(fp,"method\n");} 
						;

method_decl_single: 				type IDENTIFIER argumentList block 
						{if(flag)fprintf(fp,"METHOD WITH RETURN TYPE INT ENCOUNTERED\n");
						else if(flag==0)fprintf(fp,"METHOD WITH RETURN TYPE BOOLEAN ENCOUNTERED\n");
						fprintf(fp,"METHOD NAME: %s\n",$2);
						}
                          |VOID IDENTIFIER argumentList block 
						{fprintf(fp,"METHOD WITH RETURN TYPE VOID ENCOUNTERED\n");
						fprintf(fp,"METHOD NAME: %s\n",$2);}	   
						;

argumentList:               			OPEN_PARENTHESES CLOSE_PARENTHESES                                    
                            			|OPEN_PARENTHESES type IDENTIFIER arg CLOSE_PARENTHESES 
										{
										if(flag)
										fprintf(fp,"ARGUEMENT OF TYPE INT ENCOUNTERED\n");
										else if(!flag)fprintf(fp,"ARGUEMENT OF TPE BOOLEAN ENCOUNTERED\n");
										fprintf(fp,"Arguement Value: %s\n",$3);
										}
						;							

arg:					    	/*epsilon*/ 								
						|COMMA type IDENTIFIER arg
						{fprintf(fp,"Arguement ID: %s\n",$3);}
						;

block:						OPEN_BRACE var_decl_multiple statement_multiple CLOSE_BRACE
						{fprintf(fp,"block begins\n");}
						;

var_decl_multiple:				/*epsilon*/ 								
						|var_decl_single SEMI_COLON var_decl_multiple
						;							

var_decl_single:		type IDENTIFIER variableList{
						if(flag)fprintf(fp,"INT DECLARATION ENCOUNTERED\n");
						else if(flag==0)fprintf(fp,"BOOLEAN DECLARATION ENCOUNTERED\n");
						fprintf(fp,"ID=%s\n",$2);
											
						}	
						;

variableList:					/*epsilon*/ 								
						|COMMA IDENTIFIER variableList 	
						{if(flag)fprintf(fp,"INT DECLARATION ENCOUNTERED\n");
						else if(flag==0)fprintf(fp,"BOOLEAN DECLARATION ENCOUNTERED\n");
						fprintf(fp,"ID=%s\n",$2);}
						;

statement_multiple: 				/*epsilon*/ 								
						|statement_multiple statement_single
						;

statement_single: 				location ASSIGNMENT_OPERATOR expr SEMI_COLON 
						{fprintf(fp,"ASSIGNMENT ENCOUNTERED\n");}		
						|method_call SEMI_COLON 							
						|IF condition block else_block 		    	
						|FOR IDENTIFIER ASSIGNMENT_OPERATOR expr COMMA expr block 	
						|RETURN return_expr SEMI_COLON 					
						|BREAK SEMI_COLON 									
						|CONTINUE SEMI_COLON 								
						|block 					
						;

else_block:                			/*epsilon*/                  
                            			|ELSE block      
						;

condition:                  			OPEN_PARENTHESES expr CLOSE_PARENTHESES                                

return_expr:                			/*epsilon*/                                   
                            			|expr         
						;

expr:					location 							
						|method_call 							
						|literal 									
						|arith_expr 							
						|rel_expr 					              
						|equal_expr 						       
						|condition_expr 					
						|MINUS expr 								
						|'!' expr 								
						|OPEN_PARENTHESES expr CLOSE_PARENTHESES
						;
							
location:					IDENTIFIER {fprintf(fp,"LOCATION ENCOUNTERED %s\n",$1);}							
						|IDENTIFIER OPEN_SQR_BRACKET expr CLOSE_SQR_BRACKET
						;

method_call:			    		method_name OPEN_PARENTHESES parameterList CLOSE_PARENTHESES 			
						|CALLOUT OPEN_PARENTHESES STRING_LITERAL  callout_arg CLOSE_PARENTHESES
						;
							
method_name:                			IDENTIFIER     
						;

parameterList:              /*epsilon*/                                 
                           | expr parameter 
							;

parameter:			    	/*epsilon*/ 							
					    	|COMMA expr parameter 
							;

literal:                    int_literal 								
							|CHAR_LITERAL {fprintf(fp,"CHAR ENCOUNTERED=%s\n",$1);} 								
							|BOOL_LITERAL {fprintf(fp,"BOOL ENCOUNTERED=%s\n",$1);}
							;

int_literal:				DECIMAL_LITERAL {fprintf(fp,"INT ENCOUNTERED=%d\n",$1);}							
							|HEX_LITERAL	{fprintf(fp,"INT ENCOUNTERED=%s\n",$1);}
							;

arith_expr:					expr MULTIPLY expr 	{fprintf(fp,"MULTIPLICATION ENCOUNTERED\n",$1);}							
							|expr DIVIDE expr {fprintf(fp,"DIVISON ENCOUNTERED\n");}								
							|expr MOD expr 	{fprintf(fp,"MOD ENCOUNTERED\n");}							
							|expr PLUS expr {fprintf(fp,"ADDITION ENCOUNTERED\n");}								
							|expr MINUS expr{fprintf(fp,"SUBTRACTION ENCOUNTERED\n");}
							|'-' expr %prec UMINUS	{fprintf(fp,"UNARY MINUS ENCOUNTERED\n");}		
							;

rel_expr:					expr LESS expr 	{fprintf(fp,"LESS THAN ENCOUNTERED\n");}							
							|expr GREATER expr 	{fprintf(fp,"GREATER THAN ENCOUNTERED\n");}						
							|expr LESS_EQUAL expr 	{fprintf(fp,"LESS THAN EQUAL ENCOUNTERED\n");}					
							|expr GREATER_EQUAL expr {fprintf(fp,"GREATER THAN ENCOUNTERED\n");}
							;

equal_expr:					expr EQUAL_EQUAL expr 	{fprintf(fp,"EQUAL EQUAL ENCOUNTERED\n");}					
							|expr NOT_EQUAL expr 	{fprintf(fp,"NOT EQUAL ENCOUNTERED\n");}
							;

condition_expr:				expr AND expr 		{fprintf(fp,"AND ENCOUNTERED\n");}						
							|expr OR expr 		{fprintf(fp,"OR ENCOUNTERED\n");}
							;

callout_arg:			    		/*epsilon*/ 								
							|callout_arg COMMA expr   			
							|callout_arg COMMA STRING_LITERAL {fprintf(fp,"CALLOUT TO %s ENCOUNTERED\n",$3);}
							;

%%


int yyerror(string s)
{
  extern int yylineno;	// defined and MAINtained in lex.c
  extern char *yytext;	// defined and MAINtained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  cerr << "Syntax error\n";
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}
							

