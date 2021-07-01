<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <script src="/web_lib/jquery/jquery-3.4.1.min.js"></script>
    <link href="/web_lib/bootstrap-4.3.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/web_lib/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        @media print {
            #non_print {
                 display: none;
             }
            #print {
                zoom: 70%;
                width: 150% ;
             }
        }
    </style>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>

	<%
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String zip = request.getParameter("zip");
	String address = request.getParameter("address");
	String date = request.getParameter("date");
	String val[] = new String[10];
	String message1 = "";
	String message2 = "";
	String message3 = "";
	String message4 = "";
	String message5 = "";
	String message6 = "";

	if(name != "" && tel != "" && zip != "" && address != "" && date != ""){
		message1 = "ご購入ありがとうございます<br>宜しければ、購入ボタンをクリック頂ければ、確定致します<br>このページはブラウザの印刷で印刷が可能です<br>";
	}if(name == ""){
		message2 = "お名前が入力されていません";
	}if(tel == ""){
		message3 = "電話番号が入力されていません";
	}if(zip == ""){
		message4 = "郵便番号が入力されていません";
	}if(address == ""){
		message5 = "住所が入力されていません";
	}if(date == ""){
		message6 = "納品希望日が入力されていません";
	}

	session.setAttribute("name_var", name);
	session.setAttribute("tel_var", tel);
	session.setAttribute("zip_var", zip);
	session.setAttribute("address_var", address);
	session.setAttribute("date_var", date);

    if((String [])session.getAttribute("name_var[]")!=null){
        val = (String [])session.getAttribute("name_var[]");
    }
	%>

<div class="container">
	<div id="non_print">
		<br>
		<p class='bg-info'><%= message1 %></p>
		<p class='bg-danger'><%= message2 %></p>
		<p class='bg-danger'><%= message3 %></p>
		<p class='bg-danger'><%= message4 %></p>
		<p class='bg-danger'><%= message5 %></p>
		<p class='bg-danger'><%= message6 %></p>
    	<form method="post" name="form_name">
		<div class="row">
			<div class="col-md-3">
				<div class="col-md-8">
					<input class="btn btn-primary" type="submit" name="submit1" value="戻る" onclick="form_name.action='ns91_order.jsp'"/>
<%
					if(name != "" && tel != "" && zip != "" && address != "" && date != ""){
						out.print("<input class=\"btn btn-danger\" type=\"submit\" name=\"submit2\" value=\"購入\" onclick=\"form_name.action='ns91_order_decision.jsp'\"/>");
					}
%>				
				</div>
			</div>
		</div>
	</div>
	</form>
	<h1>請求書</h1>
	<br>

	<caption><h1>1.お客様情報</h1></caption>

	<table class="table table-condensed table-hover table-striped"">
	<tbody>
	<tr>
		<th>お名前</th><td><%out.print(name);%>様</td>
	</tr>
	<tr>
		<th>電話番号</th><td><%out.print(tel);%></td>
	</tr>
	<tr>
		<th>郵便番号</th><td><%out.print(zip);%></td>
	</tr>
	<tr>
		<th>住所</th><td><%out.print(address);%></td>
	</tr>
	<tr>
		<th>納品希望日</th><td><%out.print(date);%></td>
	</tr>
	</tbody>
	</table>

	<caption><h1>2.ご購入DVD一覧</h1></caption>

	<table class="table table-condensed table-hover table-striped"">
    <thead>
        <tr>
            <th >NO</th>
            <th >画像</th>
            <th >分類</th>
            <th >タイトル</th>
            <th >説明</th>
            <th >価格</th>
        </tr>
    </thead>
    <tbody>

    <%
    String url = "jdbc:mysql://localhost/ns91_db?useUnicode=true&characterEncoding=utf8&serverTimezone=JST";
    String user = "jsp_user";
    String password = "jsp_pass";
    Connection conn = null;
    Statement st = null;
    ResultSet res = null;
    String sql ;
	int sum = 0;
     
    Class.forName("com.mysql.jdbc.Driver");
    try {
        conn = DriverManager.getConnection(url,user,password);
 
        st=conn.createStatement();

		for(int i=0;i<val.length;i++){
        	sql="select *, class_name from dvd_product p inner join dvd_class c on p.dvd_class_id = c.dvd_class_id where dvd_product_id ="+val[i];
        	res = st.executeQuery(sql);

        	while(res.next()){
            	out.print("<tr>");
                	out.print("<td>" + res.getString("dvd_product_id") + "</td>");
                	out.print("<td><img src='image/"+ res.getString("image") + "' width='150'></td>");
                	out.print("<td>" + res.getString("class_name") + "</td>");
                	out.print("<td>" + res.getString("title") + "</td>");
                	out.print("<td>" + res.getString("description") + "</td>");
                	out.print("<td>" + res.getString("price") + "</td>");
            	out.print("</tr>");

				sum += Integer.parseInt(res.getString("price"));

        	}
		}

        out.print("<td></td>");
        out.print("<td></td>");
        out.print("<td></td>");
        out.print("<td></td>");
     	out.print("<td>ご請求金額</td>");
        out.print("<td>" + sum + "</td>");

    } catch (SQLException e) {
        out.print("<p class='bg-danger'>ERROR:"+e.getErrorCode()+":"+e.getSQLState()+":"+e.getMessage()+"</p>");
    } finally {
        try { res.close(); } catch (Exception e) {}
        try { st.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }

    %>
</table>
</div>
</body>
</html>
