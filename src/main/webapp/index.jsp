<html>
<script src="easyui/jquery.min.js"></script>
<body>
<h2>Hello World!</h2>
<a href="#" id="test">报错页面测试</a>
<script>
    $(function () {
        $.post('/test',function (data) {
            //把获取的JSON字符串转为JSON数据
            data = $.parseJSON(data);
            if(data.success){
                window.location.href="/static/jsp/index.jsp";
            }else {
                alert(data.msg);
            }
        });
    })
</script>
</body>
</html>
