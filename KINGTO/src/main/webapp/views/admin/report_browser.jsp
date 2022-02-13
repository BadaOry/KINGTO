<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KINGTO</title>
<style>
    div#report-container{
        background:white;
    }
    div#report-container-top{
        background:rgb(243, 176, 70);
        height:20px;
    }
    div#report-container-bottom{
        background:rgb(243, 176, 70);
        height:20px;
    }
    div#report-container table {
      margin:0 auto;
        border-spacing: 20px;
    }
    div#report-container table tr:last-of-type td {
        text-align:center;
    }
</style>
</head>
<body>
   <div id="report-container-top">
   </div>
   
   <div id="report-container">
      <form action="${ path }/report_browser method="post">
         <table >
            <tr>
               <th style="width:130px">신고자 아이디</th>
               <th style="width:130px">피신고자 아이디</th> 
            </tr>
            <tr>
               <td> <p id="reporter_id">${ loginMember.id }</p> </td>
               <td> <p id="reported_id" value="{ feed.writerId }">캉토</p> </td>
            </tr>
         </table>
         
         <br>
         
         <table>
            <tr>
               <th style="width:100px">피드 번호</th>
               <th style="width:600px">신고 내용</th>
            </tr>
            
            <tr>
               <td> <p id="rpd_feed_no">63</p> </td>
               <td> <input type="text" id="report_content" maxlength=100 
                        placeholder="100 글자 이내로 입력해주세요." style="width:580px; height:60px"></td>
            </tr>
         </table>
         
         <table>
            <tr>
               <td colspan="2">
                  <input type="submit" value="신고" onclick="return validate();"
                     style="background-color:rgb(243, 176, 70);border:white;">
                  &nbsp;
                  <input type="button" value="닫기" onclick="self.close();"
                     style="background-color:rgb(209, 209, 209);border:white;">
               </td>
            </tr>
         </table>
      </form>
   </div>
   
         <input type="hidden" name="reporter_no" value="${ loginMember.memberNo }">
         <input type="hidden" name="reported_no" value="${ feed.writerNo }">
   
   <div id="report-container-bottom">
   </div>
</body>
</html>