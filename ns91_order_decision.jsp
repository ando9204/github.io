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
	<br>
	<p class='bg-info'>
	ご購入ありがとうございました
</div>
    <%
    String url = "jdbc:mysql://localhost/ns91_db?useUnicode=true&characterEncoding=utf8&serverTimezone=JST";
    String user = "jsp_user";
    String password = "jsp_pass";
    Connection conn = null;
    Statement st = null;
	ResultSet res = null;
    String sql ;
	String name = null;
	String tel = null;
	String zip = null;
	String address = null;
	String date = null;
	String dvd_order_id = null;
	String val[] = new String[10];

    if((String [])session.getAttribute("name_var[]")!=null){
        val = (String [])session.getAttribute("name_var[]");
    }

    name = (String)session.getAttribute("name_var");
    tel = (String)session.getAttribute("tel_var");
    zip = (String)session.getAttribute("zip_var");
    address = (String)session.getAttribute("address_var");
    date = (String)session.getAttribute("date_var");

    Class.forName("com.mysql.jdbc.Driver");
         
        try {
            conn = DriverManager.getConnection(url,user,password);
                     
            st=conn.createStatement();
             
            sql="insert into dvd_order (name, tel, zip, address, delivery_date) values ('"+name+"',"+tel+","+zip+",'"+address+"','"+date+"')" ;
            st.executeUpdate(sql);

            sql="select last_insert_id() as id from dvd_order";
        	res = st.executeQuery(sql);

			if(res.next() == true){
				dvd_order_id = res.getString("id");
        	}

			for(int i=0;i<val.length;i++){
				if(val[i] != null){
        			sql="insert into dvd_order_detail (dvd_order_id, dvd_product_id) values ("+dvd_order_id+", "+val[i]+")";
	            	st.executeUpdate(sql);
				}
			}

        } catch (SQLException e) {
            out.print("<br>ERROR:"+e.getErrorCode()+":"+e.getSQLState()+":"+e.getMessage());
        } finally {
            try { st.close(); } catch (Exception e) {}
            try { conn.close(); } catch (Exception e) {}
        }
 
    %>
</body>
</html>
