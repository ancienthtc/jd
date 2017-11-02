<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <script src="../static/libs/jquery/jquery.min.js"></script>
    <!-- 时间选择器 -->
    <script src="../static/libs/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script src="../static/libs/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="../static/libs/file/ajaxfileupload.js"></script>
    <!-- 提示框的js -->
    <script src="../static/libs/messenger/js/messenger.min.js"></script>
    <script src="../static/util/imessenger.js"></script>
    <!-- 确认框的js -->
    <script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>

    <%--解析表单数据--%>
    <script src="../static/util/iform.js"></script>

    <%--<script type="text/javascript" src="<%=basePath%>js/admin/goodDetail.js" ></script>--%>

    <script>
        $('#datetimepicker').datetimepicker({
            language: 'zh-CN', //显示中文
            format: 'yyyy-mm-dd', //显示格式
            minView: "month", //设置只显示到月份
            initialDate: new Date(), //初始化当前日期
            autoclose: true, //选中自动关闭
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function() {

            $("#save").click(function () {
                var goodsid=$("#gid").find("option:selected").val();
                if(goodsid==null || goodsid.length<=0 )
                {
                    return false;
                }

                var fname=$("#fname").val();
                var fprice=$("#fprice").val();
                var fstock=$("#fstock").val();

                var json='{"goodsFormat":"'+goodsid+'","fname":"'+fname+'","fprice":'+fprice+',"fstock":"'+fstock+'"}';
                //var json={"goodsFormat":+goodsid+"fname":+goodsid+"fprice":+fprice+"fstock":+fstock};
                //JSON.stringify(dates)

                $.ajax({
                    type : 'POST',
                    data: json ,
                    contentType : 'application/json',
                    url:"../format/add",
                    dataType:"text",
                    success:function(data){
                        if(data=="true")
                        {
                            alert("添加成功");
                        }
                        else
                        {
                            alert("添加失败");
                        }
                    },
                    error:function(){
                        alert("请求失败");
                    }
                })

            });


        });

    </script>
</head>
<body>
<div class="location">
    <span class="title">编辑产品详情</span>
    <!-- 返回 -->
    <a href="javascript:void(0);" class="btnGreen addBtn" data-btn="backProduct">返回</a>
</div>
<div id="productDetail">
    <form id="goodDetailForm">
        <%--<span style="display: none" class="form-control" name="id" >${requestScope.goods.id}</span>--%>
        <%--<input type="hidden" class="form-control" name="id" value="${requestScope.goods.id}"/>--%>
        <%--<div class="btGroup">--%>
            <%--<label>产品名称：</label>--%>
            <%--<input type="text" class="form-control" name="name" value="${requestScope.goods.name}"/>--%>
            <%--<span class="tips"></span>--%>
        <%--</div>--%>
        <div class="btGroup">
            <label for="">选择商品:</label>
            <select class="form-control" id="gid">


                <c:if test="${not empty glist}">
                    <c:forEach var="item" items="${glist}">
                        <option value="${item.id}">${item.name}</option>
                    </c:forEach>
                </c:if>
                <c:if test="${empty glist}">
                    <option value="null">无数据</option>
                </c:if>

            </select>

        </div>
        <div class="btGroup">
            <label>规格名称：</label>
            <input type="text" class="form-control" id="fname" value=""/>
            <span class="tips"></span>
            <%--<select class="form-control" id="parentType">
                <option  selected="selected">请选择分类</option>
                <option >类别一</option>
            </select>
            <select class="form-control" name="productType.id" id="childType">
                <option >类别二</option>
                <option >请选择分类</option>
            </select>
            <span class="tips"></span>--%>
        </div>


        <div class="btGroup">
            <label>规格价格：</label>
            <input type="number" class="form-control" id="fprice" value=""/>
            <span class="tips"></span>
        </div>



        <div class="btGroup">
            <label>规格库存：</label>
            <input type="number" class="form-control" id="fstock" value=""/>
            <span class="tips"></span>
        </div>
        <%--<div class="btGroup">--%>
            <%--<label>折扣：</label>--%>
            <%--<input type="text" class="form-control" name="parameter1" value="${requestScope.goods.parameter1}"/>--%>
            <%--<span class="tips"></span>--%>
        <%--</div>--%>


        <p class="text-center">
            <a href="javascript:void(0);" class="btnGreen" id="save" data-btn="saveGood" >保存</a>
        </p>
    </form>
</div>
</body>

</html>
