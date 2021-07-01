<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<html>
<head>
    <script src="/web_lib/jquery/jquery-3.4.1.min.js"></script>
    <link href="/web_lib/bootstrap-4.3.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/web_lib/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
    <link type="text/css" rel="stylesheet" href="/web_lib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <script type="text/javascript" src="/web_lib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/web_lib/jquery-ui-1.12.1/ui/i18n/datepicker-ja.js"></script>
    <script type="text/javascript">
        $(function() {
            $.datepicker.setDefaults($.datepicker.regional['ja']);
            $('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });
            });
    </script>
    <script type="text/javascript" src="https://ajaxzip3.github.io/ajaxzip3.js" charset="utf-8"></script>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<div class="container">
    <h1>お客様情報</h1>
    <form method="post" name="form_name">
        <div class="row">
            <div class="col-md-4">
                <input class="btn btn-primary" type="submit" name="submit1" value="次へ" onclick="form_name.action='ns91_order_confirm.jsp'"/>
            </div>
        </div>
		<br>
        <div class="row">
            <label class="col-md-2 control-label">お名前</label>
            <div class="col-md-4">
                <input type="text" name="name" class="form-control"></input>
            </div>
        </div>
        <div class="row">
            <label class="col-md-2 control-label">電話番号</label>
            <div class="col-md-4">
                <input type="text" name="tel" class="form-control"></input>
            </div>
        </div>
        <div class="row">
            <label class="col-md-2 control-label">郵便番号</label>
            <div class="col-md-2">
                <input type="text" name="zip" class="form-control" onKeyUp="AjaxZip3.zip2addr(this,'','address','address');" ></input>
            </div>
        </div>
        <div class="row">
            <label class="col-md-2 control-label">住所</label>
            <div class="col-md-9">
                <input type="text" name="address" class="form-control"></input>
            </div>
        </div>
        <div class="row">
            <label class="col-md-2 control-label">納品希望日</label>
            <div class="col-md-2">
                <input type="text" name="date" class="form-control datepicker"></input>
            </div>
        </div>
    </form>   
</div>
</body>
</html>
