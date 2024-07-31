<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Temperature Converter</title>
    <style>
        body{
            font-family: Arial, Helvetica, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(to right, #3494e6, #ec6ead);
        }

        .converter{
            text-align: center;
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);

        }
        select, input{
            width: 99%;
            padding: 10px;
            margin: 20px 0px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
        }

         input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
        #result{
            width: 50%;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            font-weight: bold;
            color: #333;
        }

        @media screen and (max-width:500px){
            .converter{
                width: 90%;
            }
        }

        @keyframes fadeIn{
            from{
                opacity: 0;
            }
            to{
                opacity: 1;
            }
            h2{
                color: #333;
                animation: fadeIn 1s ease-in-out;
            }
        }
    </style>
</head>
<body>
     <div class="converter">
    <form method="post">
        <h2>Temperature Converter</h2>
        <label for="fromUnit">From:</label>
        <select id="fromUnit" name="fromUnit" required>
            <option value="C">Celsius</option>
            <option value="F">Fahrenheit</option>
            <option value="K">Kelvin</option>
            <option value="R">Rankine</option>
        </select> 
        <label for="toUnit">To:</label>
        <select id="toUnit" name="toUnit" required>
            <option value="C">Celsius</option>
            <option value="F">Fahrenheit</option>
            <option value="K">Kelvin</option>
            <option value="R">Rankine</option>
        </select> 
        <label for="temperature">Temperature:</label>
        <input type="text" id="temperature" name="temperature" placeholder="Enter Temperature" required>
        <input type="submit" value="Convert" >
    </form>

    <%
        String fromUnit = request.getParameter("fromUnit");
        String toUnit = request.getParameter("toUnit");
        String temp = request.getParameter("temperature");
        double temperature = 0.0;
        boolean validInput = true;

        if (temp != null && !temp.isEmpty()) {
            try {
                temperature = Double.parseDouble(temp);
            } catch (NumberFormatException e) {
                validInput = false;
                out.println("<p style='color:red;'>Invalid temperature input. Please enter a valid number.</p>");
            }
        } else {
            validInput = false;
        }

        if (validInput) {
            double convertedValue = 0.0;
            String resultUnit = "";
            switch (fromUnit) {
                case "C":
                    if (toUnit.equals("F")) {
                        convertedValue = (temperature * 9 / 5) + 32;
                        resultUnit = "F";
                    } else if (toUnit.equals("K")) {
                        convertedValue = temperature + 273.15;
                        resultUnit = "K";
                    } else if (toUnit.equals("R")) {
                        convertedValue = (temperature + 273.15) * 9 / 5;
                        resultUnit = "R";
                    } else {
                        convertedValue = temperature;
                        resultUnit = "C";
                    }
                    break;
                case "F":
                    if (toUnit.equals("C")) {
                        convertedValue = (temperature - 32) * 5 / 9;
                        resultUnit = "C";
                    } else if (toUnit.equals("K")) {
                        convertedValue = (temperature - 32) * 5 / 9 + 273.15;
                        resultUnit = "K";
                    } else if (toUnit.equals("R")) {
                        convertedValue = temperature + 459.67;
                        resultUnit = "R";
                    } else {
                        convertedValue = temperature;
                        resultUnit = "F";
                    }
                    break;
                case "K":
                    if (toUnit.equals("C")) {
                        convertedValue = temperature - 273.15;
                        resultUnit = "C";
                    } else if (toUnit.equals("F")) {
                        convertedValue = (temperature - 273.15) * 9 / 5 + 32;
                        resultUnit = "F";
                    } else if (toUnit.equals("R")) {
                        convertedValue = temperature * 9 / 5;
                        resultUnit = "R";
                    } else {
                        convertedValue = temperature;
                        resultUnit = "K";
                    }
                    break;
                case "R":
                    if (toUnit.equals("C")) {
                        convertedValue = (temperature - 491.67) * 5 / 9;
                        resultUnit = "C";
                    } else if (toUnit.equals("K")) {
                        convertedValue = temperature * 5 / 9;
                        resultUnit = "K";
                    } else if (toUnit.equals("F")) {
                        convertedValue = temperature - 459.67;
                        resultUnit = "F";
                    } else {
                        convertedValue = temperature;
                        resultUnit = "R";
                    }
                    break;
            }
            out.println(" <label for=\"result\">Result:</label><input type=\"text\" id=\"result\" value="+convertedValue+">");
            //out.println("<h3>Converted Value: " + convertedValue + " " + resultUnit + "</h3>");
        }
    %></div>

</body>
</html>
