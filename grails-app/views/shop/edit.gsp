<!DOCTYPE html>
<html>
<head>
    <title>Edit Shop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            margin: 0;
            padding: 20px;
        }
        h1, h2, h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
        }
        div {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .item-list div {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #fff;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .item-list span {
            flex: 1;
        }
        .item-list form {
            margin: 0;
        }
    </style>
</head>
<body>
<g:if test="${flash.message}">
        <div>${flash.message}</div>
</g:if>
    <h1>Edit Shop: ${shop.name}</h1>
    <g:form action="update" method="POST">
        <g:hiddenField name="id" value="${shop.id}"/>
        <div>
            <label for="name">Name:</label>
            <g:textField name="name" value="${shop.name}" required=""/>
        </div>
        <div>
            <label for="code">Code:</label>
            <g:textField name="code" value="${shop.code}" required=""/>
        </div>
        <div>
            <label for="address">Address:</label>
            <g:textField name="address" value="${shop.address}" required=""/>
        </div>
        <div>
            <g:submitButton name="update" value="Update Shop"/>
        </div>
     </g:form>

    <h2>Manage Items</h2>
    <div class="item-list">
        <g:each in="${shop.shopItems}" var="shopItem">
            <div>
                <span>${shopItem.item.name} (Count: ${shopItem.itemCount})</span>
                <g:form action="removeItem" method="POST">
                    <g:hiddenField name="shopId" value="${shop.id}"/>
                    <g:hiddenField name="itemId" value="${shopItem.item.id}"/>
                    <g:submitButton name="remove" value="Remove Item"/>
                </g:form>
            </div>
        </g:each>
    </div>

    <h3>Send Item to Warehouse</h3>
    <g:form action="sendItemToWarehouse">
        <g:hiddenField name="shopId" value="${shop.id}"/>
        <div>
            <label for="item">Item:</label>
            <g:select name="itemId" from="${shop.shopItems*.item}" optionKey="id" optionValue="name"/>
         </div>
        <div>
            <label for="warehouseId">Select Warehouse:</label>
            <g:select name="warehouseId" from="${warehouseList}" optionKey="id" optionValue="name" />
        </div>
        <div>
            <label for="itemCount">Item Count:</label>
            <g:textField name="itemCount" value=""/>
        </div>
        <div>
            <g:submitButton name="send" value="Send"/>
        </div>
    </g:form>
     <g:form controller="shop" action="sellItem" method="POST">
            <input type="hidden" name="shopId" value="${shop.id}"/>
            <div>
                <label for="item">Select Item:</label>
                 <g:select name="itemId" from="${shop.shopItems*.item}" optionKey="id" optionValue="name"/>
            </div>
            <div>
                <label for="itemCount">Quantity:</label>
                <g:textField name="itemCount" type="number" min="1" required=""/>
            </div>
            <div>
                <g:submitButton name="sell" value="Sell Item"/>
            </div>
        </g:form>
    <div style="text-align:center; margin-top:20px;">
        <g:link action="list">Back to Shop List</g:link>
    </div>
</body>
</html>