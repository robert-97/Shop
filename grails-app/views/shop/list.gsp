<!DOCTYPE html>
<html>
<head>
    <title>Shop List</title>
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
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px 0;
            color: #fff;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table th, table td {
            border: 1px solid #dee2e6;
            padding: 10px;
            text-align: left;
        }
        table th {
            background-color: #343a40;
            color: #fff;
        }
        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .action-links a {
            margin-right: 10px;
        }
        .action-links form {
            display: inline;
        }
        .action-links input[type="submit"] {
            background: none;
            border: none;
            color: #007bff;
            cursor: pointer;
            padding: 0;
            font: inherit;
        }
        .action-links input[type="submit"]:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Shops</h1>
    <g:link action="create" class="btn">Create New Shop</g:link>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Code</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${shopList}" var="shop">
                <tr>
                    <td>${shop.name}</td>
                    <td>${shop.code}</td>
                    <td>${shop.address}</td>
                    <td class="action-links">
                        <g:link action="edit" id="${shop.id}">Edit</g:link>
                        <g:form action="delete" id="${shop.id}">
                            <g:hiddenField name="id" value="${shop.id}"/>
                            <g:submitButton name="delete" value="Delete" />
                        </g:form>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <a href="../index">Go to Main Index</a>
</body>
</html>