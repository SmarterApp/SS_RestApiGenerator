<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>

<head>
    <title>API</title>
</head>

<body>

<h1>API Documentation</h1>

<a href="../api">Back to API context list</a>
<h2>Example Requests</h2>
<br/>
<hr/>
<c:forEach var="example" items="${examples}">
    <h2>Example URI: <c:out value="${example.requestUri}"/></h2>
    <h3>Request Data</h3>
    <b>Method:</b> <c:out value="${example.requestMethod}"/>
    <br/>
    <b>Query String:</b> <c:out value="${example.requestQueryString}"/>
    <br/>
    <b>Request Data:</b> <pre><c:out value="${example.requestData}"/></pre>
    
    <br/>
    
    <h3>Response</h3>
    <b>Content Type:</b> <c:out value="${example.requestContentType}"/>
    <br/>
    <b>Response Code:</b> <c:out value="${example.responseCode}"/>
    <br/>
    <b>Response Content:</b>
         <pre><c:out value="${example.responseContent}"/></pre>
    <hr/>
    <br><br/>
    <br><br/>
  </c:forEach>
</body>

</html>
