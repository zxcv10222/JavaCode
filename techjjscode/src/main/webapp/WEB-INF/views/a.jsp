<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>clipboard.js simple example</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!--1. clipboard.js 파일 cdn을 통해서 로드-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/clipboard.min.js"></script>

    <!--2. 스크림트 파일 작성-->
    <script>
        // 3. 웹 문서가 로드되면 클립보드 객체 생성
        $(document).ready(function(){
            var clipboard = new Clipboard('.btn');
            clipboard.on('success', function(e) {
                console.log("Success");
                /*
                아래 함수를 통해서 블록지정을 없앨 수 있습니다.
                */
                var selection = window.getSelection();
                selection.removeAllRanges();
            });
            clipboard.on('error', function(e) {
                console.log("Fail");
            });
            // 아래와 같이 button 태그만 가져오는 방법도 가능하다.
            /*
            var btns = document.querySelectorAll('button');
            var clipboard = new Clipboard(btns);
            */
            
        });
    </script>
</head>



<body>
    <!--data-clipboard-target 예제-->
    <input id="foo" value="This is Value">
    <button class="btn" data-clipboard-target="#foo">data-clipboard-target example</button>

    <br/>

    <!--data-clipboard-text 예제-->
    <button class="btn" data-clipboard-text="data-clipboard-text test">data-clipboard-text example</button>


</body>
</html>