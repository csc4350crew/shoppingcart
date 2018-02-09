﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<EcommerceApplication.Models.Products>>" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Index</title>
    <script src="../../Scripts/jquery-1.6.2.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-ui-1.8.11.min.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            font-family: Arial, "Free Sans";
            margin: 0;
            padding: 0;
        }
        #main
        {
            background: #0099cc;
            margin-top: 0;
            padding: 2px 0 4px 0;
            text-align: center;
        }
        #main a
        {
            color: #ffffff;
            text-decoration: none;
            font-size: 12px;
            font-weight: bold;
            font-family: Arial;
        }
        #main a:hover
        {
            text-decoration: underline;
        }
        #item_container
        {
            width: 610px;
            margin: 0 auto;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .item
        {
            background: #fff;
            float: left;
            padding: 5px;
            margin: 5px;
            cursor: move;
            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.5);
            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.5);
            box-shadow: 0 1px 2px rgba(0,0,0,.5);
            -webkit-border-radius: .5em;
            -moz-border-radius: .5em;
            border-radius: .5em;
            z-index: 5;
        }
        .title, .price
        {
            display: block;
            text-align: center;
            font-size: 14px;
            letter-spacing: -1px;
            font-weight: bold;
            cursor: move;
        }
        .title
        {
            color: #333;
        }
        .price
        {
            color: #0099cc;
            margin-top: 5px;
            -webkit-border-radius: .5em;
            -moz-border-radius: .5em;
            border-radius: .5em;
        }
        .icart, .icart label
        {
            cursor: e-resize;
        }
        .divrm
        {
            text-align: right;
        }
        .remove
        {
            text-decoration: none;
            cursor: pointer;
            font-weight: bold;
            font-size: 20px;
            position: relative;
            top: -7px;
        }
        .remove:hover
        {
            color: #999;
        }
        .clear
        {
            clear: both;
        }
        #cart_container
        {
            margin: 0 auto;
            width: 495px;
        }
        #cart_title span
        {
            border: 8px solid #666;
            border-bottom-width: 0;
            background: #333;
            display: block;
            float: left;
            color: #fff;
            font-size: 11px;
            font-weight: bold;
            padding: 5px 10px;
            -webkit-border-radius: .5em .5em 0 0;
            -moz-border-radius: .5em .5em 0 0;
            border-radius: .5em .5em 0 0;
        }
        #cart_toolbar
        {
            overflow: hidden;
            border: 8px solid #666;
            height: 190px;
            z-index: -2;
            width: 483px;
            -webkit-border-radius: 0 .5em 0 0;
            -moz-border-radius: 0 .5em 0 0;
            border-radius: 0 .5em 0 0;
            background: #ffffff;
        }
        #cart_items
        {
            height: 190px;
            width: 483px;
            position: relative;
            padding: 0 0 0 2px;
            z-index: 0;
            cursor: e-resize;
            border-width: 0 2px;
        }
        .back
        {
            background: #e9e9e9;
        }
        #navigate
        {
            width: 463px;
            margin: 0 auto;
            border: 8px solid #666;
            border-top-width: 0;
            -webkit-border-radius: 0 0 .5em .5em;
            -moz-border-radius: 0 0 .5em .5em;
            border-radius: 0 0 .5em .5em;
            padding: 10px;
            font-size: 14px;
            background: #333;
            font-weight: bold;
        }
        #nav_left
        {
            float: left;
        }
        #nav_left a
        {
            padding: 4px 8px;
            background: #fff;
            -webkit-border-radius: .5em;
            -moz-border-radius: .5em;
            border-radius: .5em;
            text-decoration: none;
            color: #0099cc;
        }
        #nav_left a:hover
        {
            background: #666;
            color: #fff;
        }
        #nav_right
        {
            float: right;
        }
        .sptext
        {
            background: #ffffff;
            padding: 4px 8px;
            margin-left: 8px;
            -webkit-border-radius: .5em;
            -moz-border-radius: .5em;
            border-radius: .5em;
            color: #666;
        }
        .count
        {
            color: #0099cc;
        }
        .drop-active
        {
            background: #ffff99;
        }
        .drop-hover
        {
            background: #ffff66;
        }
    </style>
    <script type="text/javascript">
        var total_items = 0;
        var total_price = 0;
        $(document).ready(function () {

            $(".item").draggable({
                revert: true
            });
            $("#cart_items").draggable({
                axis: "x"
            });

            $("#cart_items").droppable({
                accept: ".item",
                activeClass: "drop-active",
                hoverClass: "drop-hover",
                drop: function (event, ui) {
                    var item = ui.draggable.html();
                    var itemid = ui.draggable.attr("id");
                    var html = '<div class="item icart">';
                    html = html + '<div class="divrm">';
                    html = html + '<a onclick="remove(this)" class="remove ' + itemid + '">&times;</a>';
                    html = html + '<div/>' + item + '</div>';
                    $("#cart_items").append(html);

                    // update total items
                    total_items++;
                    $("#citem").html(total_items);

                    // update total price
                    var price = parseInt(ui.draggable.find(".price").html().replace("$ ", ""));
                    total_price = total_price + price;
                    $("#cprice").html("$ " + total_price);

                    // expand cart items
                    if (total_items > 4) {
                        $("#cart_items").animate({ width: "+=120" }, 'slow');
                    }
                }
            });


            $("#btn_next").click(function () {
                $("#cart_items").animate({ left: "-=100" }, 100);
                return false;
            });
            $("#btn_prev").click(function () {
                $("#cart_items").animate({ left: "+=100" }, 100);
                return false;
            });
            $("#btn_clear").click(function () {
                $("#cart_items").fadeOut("2000", function () {
                    $(this).html("").fadeIn("fast").css({ left: 0 });
                });
                $("#citem").html("0");
                $("#cprice").html("$ 0");
                total_items = 0;
                total_price = 0;
                return false;
            });
        });
        function remove(el) {
            $(el).hide();
            $(el).parent().parent().effect("highlight", { color: "#ff0000" }, 1000);
            $(el).parent().parent().fadeOut('1000');
            setTimeout(function () {
                $(el).parent().parent().remove();
                // collapse cart items
                if (total_items > 3) {
                    $("#cart_items").animate({ width: "-=120" }, 'slow');
                }
            }, 1100);

            // update total item
            total_items--;
            $("#citem").html(total_items);

            // update totl price
            var price = parseInt($(el).parent().parent().find(".price").html().replace("$ ", ""));
            total_price = total_price - price;
            $("#cprice").html("$ " + total_price);
        }
    </script>
</head>
<body>
       
    <div id="item_container">
     <% foreach (var item in Model)
           { %>
          <div class="item" id="i<%:item.ProductID %>">
              <img src="<%: Url.Content("~/Images/"+item.ProductImage)%>"/>
              <label class="title"><%:item.ProductName%></label>
              <label class="price">$ <%:item.Price %></label>
          </div>
         <% } %>
          <div class="clear"></div>
      </div>
    <div id="cart_container">
          <div id="cart_title">
              <span>Shopping Cart</span>
              <div class="clear"></div>
          </div>
          <div id="cart_toolbar">
              <div id="cart_items" class="back"></div>
          </div>
          <div id="navigate">
              <div id="nav_left">
                  <a href="" id="btn_prev"><</a>
                  <a href="" id="btn_next">></a>
                  <a href="" id="btn_clear">Clear Cart</a>
              </div>
              <div id="nav_right">
                  <span class="sptext">
                      <label>Items </label><label class="count" id="citem">0</label>
                  </span>
                  <span class="sptext">
                      <label>Price </label><label class="count" id="cprice">$ 0</label>
                  </span>
              </div>
              <div class="clear"></div>
          </div>
      </div>
</body>
</html>
