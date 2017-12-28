<%@ page import="bean.User" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/4
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<%@include file="templates/headers.jsp" %>

<header>
    <title>用户管理</title>
</header>

<body class="body-wrapper">
<div class="page-loader" style="background: url(img/preloader.gif) center no-repeat #fff;"></div>
<div class="main-wrapper">

    <script>
        var PAGEID = "adp4";
    </script>
    <header id="pageTop" class="header">
        <%@include file="templates/adminNavbar.jsp" %>
    </header>


    <!-- DASHBOARD ORDERS SECTION -->
    <section class="clearfix bg-dark dashboardOrders">
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <div class="dashboardPageTitle text-center">
                        <h2><b>HC</b>用户管理</h2>
                    </div>
                    <div class="dashboardBoxBg mb30">
                        <div class="profileIntro">
                            <form action="/UserController" method="POST" class="row" id="userSearchForm">
                                <input type="hidden" name="command" value="ADMIN_USER"/>
                                <div class="form-group col-md-4 col-sm-6 col-xs-12">
                                    <label for="userName">用户名</label>
                                    <input type="text" class="form-control" id="userName" placeholder="请输入用户名"
                                           name="user_name">
                                </div>
                                <div class="form-group col-md-4 col-sm-6 col-xs-12">
                                    <label for="userStatus">用户状态</label>
                                    <div class="contactSelect">
                                        <select id="userStatus" class="select-drop" name="user_status" size="1"
                                                multiple="false">
                                            <option value="2">不限</option>
                                            <option value="1">已激活</option>
                                            <option value="0">已冻结</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-4 col-sm-6 col-xs-12" style="padding-top: 2.3%;">
                                    <button type="button" class="btn btn-primary btn-lg" onclick="user_submit()"><i
                                            class="fa fa-search" aria-hidden="true"></i>搜索
                                    </button>
                                    <button type="button" class="btn btn-primary btn-lg" onclick="re_set()"><i
                                            class="fa fa-circle-o" aria-hidden="true"></i>清空
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>


                <p style="height: 0px; padding-top: 10px; padding-left: 2%">共搜索到了<span style="font-weight: bold;">
                    <%
                        List<User> result = null;
                        if (!empty) {
                            result = (List<User>) request.getAttribute("user_list");
                            out.print(result.size());
                        } else {
                            out.print(0);
                        }
                    %></span> 条记录</p>
                <div class="col-xs-12">
                    <div class="table-responsive bgAdd" data-pattern="priority-columns">
                        <table id="ordersTable" class="table table-small-font table-bordered table-striped"
                               cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th data-priority="">用户名</th>
                                <th data-priority="">用户密码</th>
                                <th data-priority="">用户分数</th>
                                <th data-priority="">用户状态</th>
                                <th data-priority="2">操作</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <th>用户名</th>
                                <th>用户密码</th>
                                <th>用户分数</th>
                                <th>用户状态</th>
                                <th>操作</th>
                            </tr>
                            </tfoot>
                            <tbody>
                            <%
                                for (User mUser : result) { %>
                            <td name="resultUserName"><%=mUser.getUserName()%>
                            </td>
                            <td name="resultUserPsw"><%=mUser.getUserPsw()%>
                            </td>
                            <td name="resultScore"><%=mUser.getScore()%></td>
                            <td name="resultUserStatus">
                                <%
                                    if (mUser.isValid()) {
                                        out.print("<span class=\"label label-success\">已激活</span>");
                                    }
                                    else {
                                        out.print("<span class=\"label label-danger\">已冻结</span >");
                                    }
                                %>
                            </td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" name="editUser"
                                            value="<%=mUser.getUserName()%>">修改
                                    </button>
                                    <button type="button" class="btn btn-primary" name="activateUser"
                                            value="<%=mUser.getUserName()%>">激活
                                    </button>
                                    <button type="button" class="btn btn-primary" name="suspendUser"
                                            value="<%=mUser.getUserName()%>">冻结
                                    </button>
                                </div>
                            </td>
                            </tr>
                            <%
                                }
                            %>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@include file="/templates/footers.jsp" %>

<div class="modal fade" tabindex="-1" role="dialog" id="userModal" style="padding-top: 10%">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="height: 265px;width: 675px;">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">编辑用户</h4>
            </div>
            <div class="modal-body">
                <div style="padding-left: 20px;padding-right: 20px">
                    <div class="input-group input-group-sm" style="padding-right: 20px;float:left;width: 300px">
                        <span class="input-group-addon" style="width: 80px">用户姓名</span>
                        <input type="text" class="form-control" disabled="disabled" id="modalUserName"
                               style="background-color: white; color:dimgrey">
                    </div>
                    <div class="input-group input-group-sm"
                         style="width: 300px;padding-bottom: 30px;padding-left: 20px">
                        <span class="input-group-addon" style="width: 80px">用户密码</span>
                        <input type="text" class="form-control" placeholder="请输入用户密码" id="modalUserPsw">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" style="width: 70px" id="modalReset">重置</button>
                <button type="button" class="btn btn-primary" style="width: 70px" id="modalConfirm">确认</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
<script>

    var userId = $("#result" + this.value).find("td[name='resultUserId']").text();

    $("#modalReset").click(
        function () {
            var userPsw = $("#result" + $("#modalUserId").val()).find("td[name='resultUserPsw']").text();
            var userCell = $("#result" + $("#modalUserId").val()).find("td[name='resultUserCell']").text();
            $("#modalUserCell").val(userCell);
            $("#modalUserPsw").val(userPsw);
        }
    );
    $("button[name='editUser']").click(
        function () {
            $("#userModal").modal('show');
            var userName = $("#result" + this.value).find("td[name='resultUserName']").text();
            var userPsw = $("#result" + this.value).find("td[name='resultUserPsw']").text();

            $("#modalUserName").val(userName);
            $("#modalUserPsw").val(userPsw);

            $("#result" + this.value).find("td[name='resultUserPsw']").text($("#modalUserPsw").val());
        }
    );
    $("button[name='activateUser']").click(
        function () {
            var userId = this.value;
            $.get("/UserController?command=ACTIVATE_USER", {
                user_id: userId
            }, function (data, textStatus) {
                if (data == "true") {
                    var status = $("#result" + userId).find("td[name='resultUserStatus']").find("span");
                    status.attr("class", "label label-success");
                    status.html("已激活");
                }
                else {
                    alert("用户状态更改失败");
                }
            })
        }
    );
    $("button[name='suspendUser']").click(
        function () {
            var userId = this.value;
            $.get("/UserController?command=SUSPEND_USER", {
                user_id: userId
            }, function (data, textStatus) {
                if (data == "true") {
                    var status = $("#result" + userId).find("td[name='resultUserStatus']").find("span");
                    status.attr("class", "label label-danger");
                    status.html("已冻结");
                }
                else {
                    alert("用户状态更改失败");
                }
            });
        }
    );

</script>
</html>