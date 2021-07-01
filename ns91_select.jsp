<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<html>
<head>
    <script src="/web_lib/jquery/jquery-3.4.1.min.js"></script>
    <link href="/web_lib/bootstrap-4.3.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/web_lib/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<div class="container">
	<h1>販売DVD一覧</h1>

	<%
	String word;
	word = request.getParameter("word");
	if(word==null) word="";
	%>

    <form method="post" name="form_name">
	<div class="row">
		<div class="col-md-4">
        	<label class="control-label">キーワード検索：</label>
            <input type="text" name="word" class="form-control" value="<%= word %>"/>
			<br>
			<div class="col-md-8 offset-md-2">
				<input class="btn btn-primary" type="submit" name="submit1" value="一覧表示"/>
				<input class="btn btn-primary" type="submit" name="submit2" value="購入へ" onclick="form_name.action='ns91_select_confirm.jsp'"/>
			</div>
		</div>
	</div>
	<br>

	<table class="table table-condensed table-hover table-striped"">
    <thead>
        <tr>
            <th ><input type='checkbox' id='all' /></th>
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
    String sql;

	word = request.getParameter("word");

	if(word==null) word="" ;
     
    Class.forName("com.mysql.jdbc.Driver");
    try {
        conn = DriverManager.getConnection(url,user,password);
 
        st=conn.createStatement();
         
        sql="select *, class_name from dvd_product p inner join dvd_class c on p.dvd_class_id = c.dvd_class_id where title like '%"+word+"%' or description like '%"+word+"%'";
        res = st.executeQuery(sql);

        while(res.next()){
            out.print("<tr>");
                out.print("<td><input type='checkbox' name='id' value='"+res.getString("dvd_product_id")+"'></td>");
                out.print("<td><img src='image/"+ res.getString("image") + "' width='150'></td>");
                out.print("<td>" + res.getString("class_name") + "</td>");
                out.print("<td>" + res.getString("title") + "</td>");
                out.print("<td>" + res.getString("description") + "</td>");
                out.print("<td>" + res.getString("price") + "</td>");
            out.print("</tr>");
        }
    } catch (SQLException e) {
        out.print("<p class='bg-danger'>ERROR:"+e.getErrorCode()+":"+e.getSQLState()+":"+e.getMessage()+"</p>");
    } finally {
        try { res.close(); } catch (Exception e) {}
        try { st.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }
    %>
    </tbody>
	</div>
</form>
<script>
	$('#all').on('change', function() {
	$('input[name=id]').prop('checked', this.checked);
	});
</script>
</body>
</html>
