<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<script src="easyui/jquery.min.js"></script>
<script src="layui/layui.js"></script>
<link href="layui/css/layui.css" type="text/css" rel="stylesheet" >
<style>
    .title{
        width: 100%;
        font-size: 30px;
        font-weight: 400;
        text-align: center;
    }
    .layui-table td, .layui-table th {
        position: relative;
        padding: 9px 15px;
        min-height: 20px;
        line-height: 20px;
        font-size: 14px;
        text-align: center;
    }
    .oper{
        width: 160px;
    }
    .layui-form-label{
        width:30px;
    }
</style>
<body>
<p class="title">员工信息表</p>
<a class="layui-btn " onclick="addEmp()">新增</a>
<table class="layui-table">
    <thead>
        <tr>
            <th>姓名</th>
            <th>年龄</th>
            <th>性别</th>
            <th>地址</th>
            <th>操作</th>

        </tr>
    </thead>
    <tbody id="data"></tbody>
</table>

<form action="" method="post" id="form_delete">
    <input type="hidden" name="_method" value="DELETE">
</form>

</body>
<script>

    $(function () {
       $.get("/EmployeeList",function (data) {
           $('#data').empty();
           for (let i=0;i<data.length;i++){
               let info=JSON.stringify(data[i]);
               $('#data').append('<tr>' +
                   '        <td>'+data[i].name+'</td>' +
                   '        <td>'+data[i].age+'</td>' +
                   '        <td>'+data[i].gender+'</td>' +
                   '        <td>'+data[i].address+'</td>' +
                   '        <td class="oper">' +
                   "       <a class='layui-btn' info='"+info+"' onclick='updateEmp(this)'>修改</a>" +
                   "       <a class='layui-btn layui-btn-danger' _href='/deleteEmployee/"+data[i].id+"'  onclick='del(this)'>删除</a>" +
                   '        </td>' +
                   '    </tr>')
           }
           layui.use('table', function(){
               let table = layui.table;
               table.render();
           });
       },"json")


    });


    //添加员工
    function addEmp() {
        layer.open({
            title: '添加员工'
            ,content: '<form class="layui-form" action=""  id="dataForm">' +
                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">姓名</label>' +
                '    <div class="layui-input-inline">' +
                '      <input type="text" name="name" required id="name" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">' +
                '    </div>' +
                '  </div>' +
                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">年龄</label>' +
                '    <div class="layui-input-inline">' +
                '      <input type="text" name="age" required  id="age" lay-verify="required" placeholder="请输入年龄" autocomplete="off" class="layui-input">' +
                '    </div>' +
                '  </div>' +

                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">地址</label>' +
                '    <div class="layui-input-inline">' +
                '      <input type="text" name="address" required lay-verify="required"   id="address" placeholder="请输入地址" autocomplete="off" class="layui-input">' +
                '    </div>' +

                '  </div>' +
                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">性别</label>' +
                '    <div class="layui-input-inline">' +
                '      <input type="text" name="gender" required lay-verify="required"   id="gender" placeholder="请输入性别" autocomplete="off" class="layui-input">' +
                '    </div>' +
                '  </div>' +
                ' 	 <div id="tip" style="margin-left:25px;color: red" ></div>'+
                '</form>'
            ,yes:function () {
                let age=$("#age").val();
                let gender=$("#gender").val();
                if(!(age>0&&age<100)){
                    $("#tip").text("请输入正确年龄");
                    $("#tip").show();
                }
                else{
                    $.ajax({
                        url: "addEmployee",
                        type : "post",    // 此处发送的是PUT请求
                        data : $("#dataForm").serialize(),
                        success : function(res){
                            if(res.success) {
                                layer.msg(res.msg, {
                                    icon: 1,
                                    time: 1000
                                });
                            }
                        else {
                                layer.msg(res.msg, {
                                    icon: 2,
                                    time: 1000
                                });
                            }
                            }


                        });
                }
                    }
                });
        layui.use('form', function(){
            let form = layui.form;
            form.render();
        });
        $("#tip").hide();
    }
    //更新员工
    function updateEmp(obj) {
        let data=$(obj).attr("info");
        let jsonData=JSON.parse(data);
        layer.open({
            title: '更新员工'
            ,content: '<form class="layui-form" action="" method="post" id="dataForm">' +
                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">姓名</label>' +
                '    <div class="layui-input-inline">' +
                '<input type="hidden" name="_method" value="PUT">'+
                '<input type="hidden" name="id" value="'+jsonData.id+'">'+
                '      <input type="text" value="'+jsonData.name+'" name="name" required id="name" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">' +
                '    </div>' +
                '  </div>' +
                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">年龄</label>' +
                '    <div class="layui-input-inline">' +
                '      <input type="text" value="'+jsonData.age+'" name="age" required  id="age" lay-verify="required" placeholder="请输入年龄" autocomplete="off" class="layui-input">' +
                '    </div>' +
                '  </div>' +

                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">地址</label>' +
                '    <div class="layui-input-inline">' +
                '      <input type="text" value="'+jsonData.address+'" name="address" required lay-verify="required"   id="address" placeholder="请输入地址" autocomplete="off" class="layui-input">' +
                '    </div>' +

                '  </div>' +
                '  <div class="layui-form-item">' +
                '    <label class="layui-form-label">性别</label>' +
                '    <div class="layui-input-inline">' +
                '      <input type="text" value="'+jsonData.gender+'" name="gender" required lay-verify="required"   id="gender" placeholder="请输入性别" autocomplete="off" class="layui-input">' +
                '    </div>' +
                '  </div>' +
                ' 	 <div id="tip" style="margin-left:25px;color: red" ></div>'+
                '</form>'
            ,yes:function () {
                    $.ajax({
                        url: "updateEmployee",
                        type : "put",    // 此处发送的是PUT请求
                        data : $("#dataForm").serialize(),
                        success : function(res){
                            if(res.success) {
                                layer.msg(res.msg, {
                                    icon: 1,
                                    time: 1000
                                });
                            }
                            else {
                                layer.msg(res.msg, {
                                    icon: 2,
                                    time: 1000
                                });
                            }
                        }


                    });
                }

        });
        layui.use(['form','layer'], function(){
            let form = layui.form;
            let layer =layui.layer;
            form.render();
        });
        $("#tip").hide();

    }

    function del(obj) {
        let href =$(obj).attr("_href");
        $("#form_delete").attr("action",href);
        $.ajax({
            url: href,
            type : "delete",    // 此处发送的是DELETE请求
            data : $("#form_delete").serialize(),
            success : function(res){
                if(res.success) {
                    layer.msg(res.msg, {
                        icon: 1,
                        time: 1000
                    },function () {
                      location.reload();
                    });
                }
                else {
                    layer.msg(res.msg, {
                        icon: 2,
                        time: 1000
                    });
                }
    }
    })
    }

</script>
</html>
