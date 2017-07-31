<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<div class="location">
  <span class="title">编辑产品详情</span>
  <!-- 返回 -->
  <a href="javascript:void(0);" class="btnGreen addBtn" data-btn="backProduct">返回</a>
</div>
<div id="productDetail">
  <form id="goodDetailForm">
      <span style="display: none" class="form-control" name="id" >${requestScope.goods.id}</span>
    <div class="btGroup">
      <label>产品名称：</label>
      <input type="text" class="form-control" name="name" value="${requestScope.goods.name}"/>
      <span class="tips"></span>
    </div>
  <div class="btGroup">
      <label for="">板块:</label>
      <select class="form-control" name="part">
          <option >板块1</option>
          <option >板块2</option>
      </select>

  </div>
    <div class="btGroup">
      <label>单价：</label>
        <input type="text" class="form-control" name="price" value="${requestScope.goods.price}"/>
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
      <label>计量单位：</label>
        <input type="text" class="form-control" name="gclass" value="${requestScope.goods.gclass}"/>
        <span class="tips"></span>
    </div>
    <div class="btGroup">
      <label>参数1：</label>
        <input type="text" class="form-control" name="parameter1" value="${requestScope.goods.parameter1}"/>
        <span class="tips"></span>
    </div>
    <div class="btGroup">
      <label>参数2：</label>
        <input type="text" class="form-control" name="parameter2" value="${requestScope.goods.parameter2}"/>
        <span class="tips"></span>
    </div>
    <div class="btGroup">
      <label>参数3：</label>
      <input type="text" class="form-control" name="parameter3" value="${requestScope.goods.parameter3}"/>
      <span class="tips"></span>
    </div>
    <div class="btGroup">
      <label>运费：</label>
      <input type="text" class="form-control" name="freight" value="${requestScope.goods.freight}"/>
      <span class="tips"></span>
    </div>
    <div class="btGroup">
      <label for="">销量:</label>
        <input type="text" class="form-control" name="sales" value="${requestScope.goods.sales}" readonly="readonly"/>
        <span class="tips"></span>
    </div>
    <div class="btGroup">
      <label for="">库存:</label>
        <input type="text" class="form-control" value="${requestScope.goods.stock}" name="stock" />
        <span class="tips"></span>

    </div>
    <div id="cover" class="btGroup">
      <label for="">上架日期:</label>
        <input type="text" class="form-control" name="shelf"  id="datetimepicker" value="${requestScope.goods.shelf}"/>
   <%--   <div class="photos">
        <div class="img" ></div>
        <i class="iconfont icon-add" style="line-height: 150px;"></i>
        <input type="file" name="ossImg1" id="ossImg1"/>
        <input type="hidden" name="ossImg" id="ossImg" />
        <span class="tips"></span>
      </div>--%>
    </div>
    <div id="bigCover" class="desGroup">
      <label for="">详情</label>
        <textarea type="text" class="form-control" name="detail"  style="width: 72.4%">${requestScope.goods.detail}</textarea>
        <span class="tips"></span>
      <%--<div class="photos">
        <div class="img" ></div>
        <i class="iconfont icon-add" style="line-height: 230px;"></i>
        <input type="file" name="bigImg1" id="bigImg1"/>
        <input type="hidden" name="bigImg" id="bigImg" />
        <span class="tips"></span>
      </div>--%>
    </div>
 <%--   <div id="imgBox" class="photoGroup" >
      <label for="">轮播图集合</label>
      <!-- 上限6张 -->
      <div class="photos">
      <div class="img" style="background-image: none"></div>
      <div class="mask"></div>
      <i class="iconfont icon-add"></i>
      <input type="file" name="listImg1" id="listImg1"/>
      <div class="btnBox">
        <i class="iconfont icon-del"></i>
        <i class="iconfont icon-sort"></i>
      </div>
    </div>
        <input type="hidden" class="listImg2" id="listImg12"/>

      <!--<input type="hidden" name="listImg" id="listImg" />-->
      <span class="tips"></span>
    </div>--%>
      <div id="imgBox" class="photoGroup" >
          <label for="">轮播图集合</label>
          <!-- 上限6张 -->
          <c:forEach items="${requestScope.imgs}"  var="item">
             <%-- <p>${item.filename}</p>--%>
              <div class="photos canSort"  >
                  <div class="img" style="background-image: url('<%=basePath%>picture/show?pic=${item.title}')"></div>
                  <span  style="display: none">${item.id}</span>
                  <div class="mask"></div>
                  <i class="iconfont icon-add"></i>
                  <input type="file" name="file" id="listImg1"/>
                  <div class="btnBox" style="display: block">
                      <i class="iconfont icon-del"></i>
                    <%--  <i class="iconfont icon-sort"></i>--%>
                  </div>
              </div>
              <input  type="hidden" class="listImg2" />
          </c:forEach>
          <c:if test="${requestScope.imgs.size()!=6}">
              <div class="photos" >
                  <div class="img" style="background-image: none"></div>
                  <i class="iconfont icon-add"></i>
                  <input type="file" name="file" id="listImg2"/>
                  <div class="btnBox">

                      <i class="iconfont icon-del"></i>
                      <%--<i class="iconfont icon-sort"></i>--%>
                  </div>
              </div>
              <input  type="hidden" class="listImg2" />
          </c:if>
          <span class="tips"></span>
      </div>
    <%--<div class="btGroup" id="productDetailTime">
      <label>最晚取消时间：</label>
<!--       <input type="text" id="lastTime" name="lastCancel" class="form-control"  /> -->
    <select name="lastCancelHour" class="form-control selectLeft" id="lastCancelHourSel"  onmousedown="if(this.options.length>6){this.size=7}" onblur="this.size=0" onchange="this.size=0">
        <option value="0">00</option>
        <option value="1">01</option>
        <option value="2">02</option>
        <option value="3">03</option>
        <option value="4">04</option>
        <option value="5">05</option>
        <option value="6">06</option>
        <option value="7">07</option>
        <option value="8">08</option>
        <option value="9">09</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        <option value="13">13</option>
        <option value="14">14</option>
        <option value="15">15</option>
        <option value="16">16</option>
        <option value="17">17</option>
        <option value="18">18</option>
        <option value="19">19</option>
        <option value="20">20</option>
        <option value="21">21</option>
        <option value="22">22</option>
        <option value="23">23</option>
    </select>
    <select name="lastCancelMin" class="form-control selectRight" id="lastCancelMinSel"  onmousedown="if(this.options.length>6){this.size=7}" onblur="this.size=0" onchange="this.size=0">
        <option value="00">00</option>
        <option value="05">05</option>
        <option value="10">10</option>
        <option value="15">15</option>
        <option value="20">20</option>
        <option value="25">25</option>
        <option value="30">30</option>
        <option value="35">35</option>
        <option value="40">40</option>
        <option value="45">45</option>
        <option value="50">50</option>
        <option value="55">55</option>
    </select>
    <span class="tips"></span>
    </div>
      <input type="hidden"  id="lastCancelHour"/>
      <input type="hidden"  id="lastCancelMin"/>
    <div class="btGroup">
      <label>配送费：</label>
      <input type="text" name="logisticsPrice" class="form-control" />
      <span class="tips"></span>
    </div>--%>
    <!-- 添加产品 -->
    <p class="text-center">
      <a href="javascript:void(0);" class="btnGreen" data-btn="addNewProduct">保存</a>
    </p>
  </form>
</div>


<!-- 时间选择器 -->
<script src="../static/libs/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script src="../static/libs/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="../static/libs/file/ajaxfileupload.js"></script>
<!-- 提示框的js -->
<script src="../static/libs/messenger/js/messenger.min.js"></script>
<script src="../static/util/imessenger.js"></script>
<!-- 确认框的js -->
<script src="../static/libs/jquery-confirm/jquery-confirm.js"></script>

<script type="text/javascript" src="<%=basePath%>js/goodDetail.js" ></script>

<script>
    $('#datetimepicker').datetimepicker({
        language: 'zh-CN', //显示中文
        format: 'yyyy-mm-dd', //显示格式
        minView: "month", //设置只显示到月份
        initialDate: new Date(), //初始化当前日期
        autoclose: true, //选中自动关闭
    });
</script>
</html>
