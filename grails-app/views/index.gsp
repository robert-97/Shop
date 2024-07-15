<!DOCTYPE html>
<html>
<head>
    <title>Navigation Menu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        h1 {
            margin-bottom: 40px;
        }
        .nav-menu {
            list-style-type: none;
            padding: 0;
        }
        .nav-menu li {
            display: inline;
            margin: 10px;
        }
        .nav-menu a {
            background-color: #007bff;
            color: white;
            padding: 15px 20px;
            text-decoration: none;
            border-radius: 5px;
        }
        .nav-menu a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Navigation Menu</h1>
    <ul class="nav-menu">
        <li><a href="${createLink(action: 'list', controller: 'item')}">Item List</a></li>
        <li><a href="${createLink(action: 'list', controller: 'warehouse')}">Warehouse List</a></li>
        <li><a href="${createLink(action: 'list', controller: 'shop')}">Shop List</a></li>
    </ul>
</body>
</html>