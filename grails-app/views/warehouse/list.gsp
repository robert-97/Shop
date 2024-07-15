<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Warehouse List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            color: #333;
        }
        h1 {
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .button {
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            margin-right: 5px; /* Added margin for spacing */
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <g:if test="${flash.message}">
        <div class="alert">${flash.message}</div>
    </g:if>
    <h1>Warehouse List</h1>
    <g:link action="create" class="button">Create New Warehouse</g:link>
    <table>
        <thead>
            <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${warehouses}" var="warehouse">
                <tr>
                    <td><g:link action="edit" id="${warehouse.id}">${warehouse.code}</g:link></td>
                    <td>${warehouse.name}</td>
                    <td>${warehouse.address}</td>
                    <td>
                        <g:link action="edit" id="${warehouse.id}" class="button">Edit</g:link>
                        <g:form action="delete" method="post" style="display: inline;">
                            <g:hiddenField name="id" value="${warehouse.id}"/>
                            <input type="submit" class="button" value="Delete"/>
                        </g:form>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <a href="../index">Go to Home Page</a>
</body>
</html>