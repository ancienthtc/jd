<%--
  Created by IntelliJ IDEA.
  User: ThinkPad
  Date: 2017/10/18
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>PayPal</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://www.paypalobjects.com/api/checkout.js"></script>
    <script type='text/javascript' src='<%=basePath%>js/jquery-1.7.2.min.js'></script>
    <style>
        .tijiao{width:100px;height: 40px;background: black;color: white;border-radius: 12px;}
    </style>
</head>
<body>
    <input type="hidden" id="account" value="${account}">
    <input type="hidden" id="user_id" value="${user_id}">
    <input type="hidden" id="uuid" value="${uuid}">

    <div id="paypal-button-container">
        <%--<input type="button" class="tijiao" value="paypal" >--%>
    </div>

    <script>
            paypal.Button.render({

                env: 'production', // sandbox | production

                // PayPal Client IDs - replace with your own
                // Create a PayPal app: https://developer.paypal.com/developer/applications/create
                client: {
                    //sandbox:   'AZDxjDScFpQtjWTOUtWKbyN_bDt4OgqaF4eYXlewfBP4-8aqX3PiV8e1GWU6liB2CUXlkA59kJXE7M6R' //,
                    //production: '<insert production client id>'
                    production:'AVe6ZzDdGVl5yDXVHyjL0u_2li3djZ_X8DpLLh9pbqQBHbSYqLP7QzRTUbw5wf9-I83x9fpVlfskntQa'
                },

                // Show the buyer a 'Pay Now' button in the checkout flow
                commit: true,

                // payment() is called when the button is clicked
                payment: function(data, actions) {

                    // Make a call to the REST api to create the payment
                    return actions.payment.create({
                        payment: {
                            transactions: [
                                {
                                    amount: { total: $("#account").val() , currency: 'USD' }
                                }
                            ]
                        }
                    });
                },

                // onAuthorize() is called when the buyer approves the payment
                onAuthorize: function(data, actions) {

                    // Make a call to the REST api to execute the payment
                    return actions.payment.execute().then(function() {
                        window.alert('Payment Complete!');
                        send($("#user_id").val(),$("#uuid").val());
                    });
                }

            }, '#paypal-button-container');
    </script>

    <script>
        function send(userid,uuid) {
            var json='{"uid":"'+userid+'","uuid":"'+uuid+'"}';
            $.ajax( {
                type : 'POST',
                contentType : 'application/json; charset=UTF-8',
                url : '<%=basePath%>order/pay',
                data : json,
                dataType : 'text',
                success : function(data) {
                    if(data=="true")
                    {
                        alert("成功");
                        window.location.href="<%=basePath%>user/toMember_index";
                    }
                    else
                    {
                        alert("失败");
                        window.location.href="<%=basePath%>user/toMember_index";
                    }
                },
                error : function(data) {
                    alert("错误");
                }
            });
        }
    </script>

</body>
</html>
