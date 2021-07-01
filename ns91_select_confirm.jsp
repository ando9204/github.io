<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <script src="/web_lib/jquery/jquery-3.4.1.min.js"></script>
    <link href="/web_lib/bootstrap-4.3.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/web_lib/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String val[] = new String[10];
	int sum = 0;
	String[] val_d ;
    val_d = request.getParameterValues("id");
	String message = "";

    if((String [])session.getAttribute("name_var[]")!=null){
        val = (String [])session.getAttribute("name_var[]");
    }
%>
<div class="container">
	<h1>購入DVD一覧</h1>
    <form method="post" name="form_name">

	<div class="row">
		<div class="col-md-4">
			<div class="col-md-8 offset-md-2">
				<input class="btn btn-primary" type="submit" name="submit1" value="戻る" onclick="form_name.action='ns91_select.jsp'"/>
<%
				if(val_d != null){
				out.print("<input class=\"btn btn-primary\" type=\"submit\" name=\"submit2\" value=\"次へ\" onclick=\"form_name.action='ns91_order.jsp'\"/>");
				}
%>
			</div>
		</div>
	</div>
	<br>

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

	if(val_d != null){
    Class.forName("com.mysql.jdbc.Driver");
    try {
        conn = DriverManager.getConnection(url,user,password);
 
        st=conn.createStatement();

		for(int i=0;i<val_d.length;i++){
        	sql="select *, class_name from dvd_product p inner join dvd_class c on p.dvd_class_id = c.dvd_class_id where dvd_product_id ="+val_d[i];
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

				val[i] = res.getString("dvd_product_id");
				sum += Integer.parseInt(res.getString("price"));

        	}
		}

		session.setAttribute("name_var[]", val);

	out.print("<tr>");
        out.print("<td></td>");
        out.print("<td></td>");
        out.print("<td></td>");
        out.print("<td></td>");
     	out.print("<td>ご請求金額</td>");
        out.print("<td>" + sum + "</td>");
	out.print("<tr>");

    } catch (SQLException e) {
        out.print("<p class='bg-danger'>ERROR:"+e.getErrorCode()+":"+e.getSQLState()+":"+e.getMessage()+"</p>");
    } finally {
        try { res.close(); } catch (Exception e) {}
        try { st.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }
	}else{
		message = "商品を選択してください";
	}
    %>
	<p class='bg-danger'><%= message %></p>
    </tbody>
	</div>
</form>
</body>
</html>
