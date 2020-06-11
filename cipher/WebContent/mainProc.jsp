<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍자치환</title>
<link rel="stylesheet" href="css/bootstrap.css">
<style>
	table {
		width: 500px;
	}
	td {
		padding: 10px;
		border: 1px solid #666666;
		text-align:center;
	}
</style>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String key = request.getParameter("key");
	String sentence = request.getParameter("sentence");
%>
<%!
public static char alphabet[][] = new char[5][5];
public static String zCheck="";
//암호판 만들기
private static char[][] setBoard(String key) {
	String temp = "";
	boolean duplicationFlag = false;	
	key += "abcdefghijklmnopqrstuvwxyz";
	
	for( int i = 0 ; i < key.length(); i++ ) {
		for( int j = 0 ; j < temp.length(); j++ ){
			if(key.charAt(i)==temp.charAt(j)){
				duplicationFlag = true;
				break;
			}
		}
		if(!(duplicationFlag)) temp += key.charAt(i);
		else duplicationFlag = false;
	}
	
	int count=0;
	for( int i = 0 ; i < alphabet.length ; i++ ){
		for( int j = 0; j <alphabet[i].length ; j++ ){
			alphabet[i][j] = temp.charAt(count++);
		}
	}		
	
	return alphabet;	
}
//암호화 할 문장을 공백 제거하고 z를 q로 바꾸고 연달아 나오는 글자는 사이에 x를 넣어준다.
public static String setSentence(String sentence){
	
	for(int i=0;i<sentence.length();i++){
		if(sentence.charAt(i) == ' '){
			sentence = sentence.substring(0,i)+sentence.substring((i+1),sentence.length());
		}
		if(sentence.charAt(i)=='z'){
			sentence = sentence.substring(0,i)+'q'+sentence.substring((i+1),sentence.length());
			zCheck += 1;
		}
		else zCheck += 0;
	}
	
	String temp= ""+sentence.charAt(0);
	
	for(int i=1;i<sentence.length();i++){
		if(sentence.charAt(i) == sentence.charAt(i-1)){
			temp += "x" + sentence.charAt(i);
		}
		else {
			temp += sentence.charAt(i);
		}
	}
	
	if(temp.length()%2!=0){
		temp += 'x';
	}
	
	return temp;
}

private static ArrayList<char[]> mapping(String sentence,char board[][]){
	ArrayList<char[]> before = new ArrayList<char[]>();
	ArrayList<char[]> after = new ArrayList<char[]>();

	int x1=0, x2=0, y1=0, y2=0;
	int count=0;
	//char char01[][] = new char[5][6];
	
	for(int i=0;i<sentence.length();i+=2){
		char[] temp = new char[2];
		temp[0] = sentence.charAt(i);
		temp[1] = sentence.charAt(i+1);
		before.add(temp);
	}
	
	
	
	for(int i=0;i<before.size();i++){
		char[] temp = new char[2];
		for(int j=0;j<alphabet.length;j++){
			for(int a=0;a<alphabet[j].length;a++){
				if(alphabet[j][a] == before.get(i)[0]){
					x1 =j;
					y1 = a;
				}//if
				if(alphabet[j][a] == before.get(i)[1]){
					x2 =j;
					y2 = a;
				}//if
			}//for a
		}//for j
		
		/*
		for(int j=0;j<zCheck.length();j++){
			if( zCheck.charAt(j) == '1' && temp[0]==temp[1]){
				
			}
		}
		*/
		
		if(x1==x2){
			temp[0] = alphabet[x1][(y1+4+2)%5];
			temp[1] = alphabet[x2][(y2+4+2)%5];
		}
		else if(y1==y2){
			temp[0] = alphabet[(x1+4+2)%5][y1];
			temp[1] = alphabet[(x2+4+2)%5][y2];
		}
		else{
			temp[0] = alphabet[x2][y1];
			temp[1] = alphabet[x1][y2];
		}
		
		after.add(temp);
	}//for i
	
	return after;
		
}
%>
<%
char board[][] = setBoard(key); 
String newValue =  setSentence(sentence);
ArrayList<char[]> result = mapping(newValue,board);
%>
<center>
<div class="col-xs-6">
<table border="1" class="table table-striped">
<h2>암호판</h2>
<%for(int i = 0; i <board.length; i++){%>
	<tr><% for(int j = 0; j <board[i].length; j++){%>
		<td><%= board[i][j] %>
		<% if(board[i][j]=='q') {%>
			/z
		<%}%>
		</td>
<%	}%></tr>
<%}%>
</table>

<h2 class="text-right col-xs-6">암호화 된 문장</h2>
<h2 class="btn btn-warning btn-lg col-xs-6" disabled="disabled">
<%for(int i=0;i<result.size();i++){%>
		<%= result.get(i)%>
<%}%>
</h2>


</div>
</center>


<body>


</body>
</html>