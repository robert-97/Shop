<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Create Item</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
            color: #343a40;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ffeeba;
            border-radius: 4px;
            background-color: #fff3cd;
            color: #856404;
        }
        fieldset {
            border: 1px solid #dee2e6;
            padding: 20px;
            border-radius: 5px;
        }
        legend {
            font-weight: bold;
        }
        .fieldcontain {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], select, .date-picker {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="checkbox"] {
            margin-right: 10px;
        }
        .button-container {
            text-align: center;
        }
        .button-container input {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            padding: 10px 20px;
            border-radius: 4px;
        }
        .button-container input:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function toggleDeadline() {
            var checkbox = document.getElementById("hasDeadline");
            var deadlineField = document.getElementById("deadlineField");
            if (checkbox.checked) {
                deadlineField.style.display = "block";
            } else {
                deadlineField.style.display = "none";
                document.getElementById("deadline").value = ""; // Clear the field
            }
        }
    </script>
</head>
<body>
    <g:if test="${flash.message}">
        <div class="alert">${flash.message}</div>
    </g:if>
    <h1>Create Item</h1>
    <g:form controller="item" action="save">
        <fieldset>
            <legend>Item Details</legend>
            <div class="fieldcontain">
                <label for="code">Code:</label>
                <g:textField name="code" required="" value="${item?.code}"/>
            </div>
            <div class="fieldcontain">
                <label for="name">Name:</label>
                <g:textField name="name" required="" value="${item?.name}"/>
            </div>
            <div class="fieldcontain">
                <label for="price">Price:</label>
                <g:field name="price" required="" type="number" min="0" value="${item?.price}"/>
            </div>
            <div class="fieldcontain">
                <label for="createdDate">Created Date:</label>
                <g:datePicker name="createdDate" precision="day" required="" value="${item?.createdDate}"/>
            </div>
            <div class="fieldcontain">
                <label>
                    <input type="checkbox" id="hasDeadline" name="hasDeadline" onclick="toggleDeadline()"/> Has Deadline
                </label>
            </div>
            <div class="fieldcontain" id="deadlineField" style="display: none;">
                <label for="deadline">Deadline (optional):</label>
                <g:datePicker name="deadline" id="deadline" precision="day"/>
            </div>
            <div class="button-container">
                <g:submitButton name="create" value="Create"/>
            </div>
        </fieldset>
    </g:form>
    <g:link controller="item" action="list">Back to list</g:link>
</body>
</html>