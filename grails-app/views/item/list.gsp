<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>List Items</title>
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
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #856404;
            background-color: #fff3cd;
            border-color: #ffeeba;
        }
        a {
            text-decoration: none;
            color: #007bff;
            padding: 5px 10px;
            border: 1px solid #007bff;
            border-radius: 3px;
            margin-right: 5px;
        }
        a:hover {
            background-color: #007bff;
            color: #fff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            border: 1px solid #dee2e6;
            text-align: left;
        }
        th {
            background-color: #343a40;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <g:if test="${flash.message}">
        <div class="alert">${flash.message}</div>
    </g:if>
    <h1>List of Items</h1>
    <g:link controller="item" action="create">Create New Item</g:link>
    <table>
        <thead>
            <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Price</th>
                <th>Created Date</th>
                <th>Deadline</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${itemList}" var="item">
                <tr>
                    <td>${item.code}</td>
                    <td>${item.name}</td>
                    <td>${item.price}</td>
                    <td>${item.createdDate}</td>
                    <td>${item.deadline != null ? item.deadline : "No deadline" }</td>
                    <td>
                        <g:link controller="item" action="edit" id="${item.id}">Edit</g:link>
                        <g:link controller="item" action="delete" id="${item.id}" onclick="return confirm('Are you sure?')">Delete</g:link>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
     <a href="../index">Go to Home Page</a>
</body>
</html>