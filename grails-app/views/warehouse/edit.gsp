<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Edit Warehouse</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            color: #333;
        }
        h1, h2 {
            margin-top: 20px;
        }
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .button-container {
            text-align: center;
        }
        .button-container input {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px 15px;
        }
        .button-container input:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .remove-button {
            background-color: #dc3545;
            color: white;
            border: none;
            cursor: pointer;
            padding: 5px 10px;
        }
        .remove-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <g:if test="${flash.message}">
        <div class="alert">${flash.message}</div>
    </g:if>
    <h1>Edit Warehouse</h1>
    <g:form action="update">
        <g:hiddenField name="id" value="${warehouse?.id}"/>
        <div>
            <label for="code">Code</label>
            <g:textField name="code" value="${warehouse?.code}"/>
        </div>
        <div>
            <label for="name">Name</label>
            <g:textField name="name" value="${warehouse?.name}"/>
        </div>
        <div>
            <label for="address">Address</label>
            <g:textField name="address" value="${warehouse?.address}"/>
        </div>
        <div class="button-container">
            <g:submitButton name="update" value="Update"/>
        </div>
    </g:form>

    <h2>Items in Warehouse</h2>
    <table>
        <thead>
            <tr>
                <th>Item Name</th>
                <th>Item Code</th>
                <th>Price</th>
                <th>Count</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${warehouse.warehouseItems}" var="warehouseItem">
                <tr>
                    <td>${warehouseItem.item.name}</td>
                    <td>${warehouseItem.item.code}</td>
                    <td>${warehouseItem.item.price}</td>
                    <td>${warehouseItem.itemCount}</td>
                    <td>
                        <g:form action="removeItem" method="POST">
                            <g:hiddenField name="warehouseId" value="${warehouse.id}"/>
                            <g:hiddenField name="itemId" value="${warehouseItem.item.id}"/>
                            <input type="submit" class="remove-button" value="Remove Item"/>
                        </g:form>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>

    <h2>Add Item</h2>
    <g:form action="addItem">
        <g:hiddenField name="warehouseId" value="${warehouse.id}"/>
        <div>
            <label for="item">Item</label>
            <g:select name="item.id" from="${itemList}" optionKey="id" optionValue="name"/>
        </div>
        <div>
            <label for="itemCount">Item Count</label>
            <g:textField name="itemCount"/>
        </div>
        <div class="button-container">
            <g:submitButton name="create" value="Add"/>
        </div>
    </g:form>

    <h2>Deliver Item to Shop</h2>
    <g:form action="deliverItem" method="POST">
        <g:hiddenField name="warehouseId" value="${warehouse.id}"/>
        <div>
            <label for="shopId">Shop:</label>
            <g:select name="shopId" from="${shopList}" optionKey="id" optionValue="name"/>
        </div>
        <div>
            <label for="itemId">Item:</label>
            <g:select name="itemId" from="${warehouse.warehouseItems*.item}" optionKey="id" optionValue="name"/>
        </div>
        <div>
            <label for="itemCount">Item Count:</label>
            <g:textField name="itemCount"/>
        </div>
        <div class="button-container">
            <g:submitButton name="deliver" value="Deliver"/>
        </div>
    </g:form>

    <g:link action="list">Back to list</g:link>
</body>
</html>