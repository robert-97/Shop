<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Create Warehouse</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            margin: 0;
            padding: 20px;
        }
        h1 {
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
        input[type="text"] {
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
        .link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <g:if test="${flash.message}">
        <div>${flash.message}</div>
    </g:if>
    <h1>Create Warehouse</h1>
    <g:form action="save" method="POST">
        <div>
            <label for="code">Code:</label>
            <g:textField name="code" required=""/>
        </div>
        <div>
            <label for="name">Name:</label>
            <g:textField name="name" required=""/>
        </div>
        <div>
            <label for="address">Address:</label>
            <g:textField name="address" required=""/>
        </div>
        <div>
            <g:submitButton name="create" value="Create Warehouse"/>
        </div>
    </g:form>
    <g:link action="list">Back to Warehouse List</g:link>
</body>
</html>