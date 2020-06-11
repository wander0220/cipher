<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쌍자치환</title>
<link rel="stylesheet" href="css/bootstrap.css">
<script>
	function check(){
		if(document.frm01.key.value==""){
			alert("(소문자)암호화에 쓰일 키를 입력해주세요");
			document.frm01.key.focus();
			return;
		}
		if(document.frm01.sentence.value==""){
			alert("(소문자)암호화 할 키를 입력해주세요");
			document.frm01.sentence.focus();
			return;			
		}
		
		frm01.submit();
	}
</script>
</head>
<body>
<!-- 선생님 구현은 제대로 하지 못했습니다만... 이거 하나만 알아주십쇼...저 정말 열심히 했습니다...하지만 머리가 안돌아갑니다....-->
<center>
<div class="col-xs-6">
	<form  name="frm01" action="mainProc2.jsp" method="post">
	<br><br>
	(소문자,공백없이) 암호화에 쓰일 키 입력 <br><input type="text" class="form-control" name="key"><br><br>
	(소문자) 암호화 할 문장 입력<br><input type="text" class="form-control" name="sentence">	<br><br>
	<input type="button" class="btn btn-warning" value="암호화 시키기 >>" onclick="check()"><br>

</form>
</div>
</center>
</body>
</html>