<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>

<head>
	<title>API</title>
</head>

<body>

<h1>API Documentation</h1>

<h3>API Context Roots</h3>
<ul>
	<c:forEach var="entry" items="${apiRequestsByURI}">
	  <li><a href="api<c:out value="${entry.key}" />">api<c:out value="${entry.key}"/></a></li>
	</c:forEach>
</ul>

</body>

</html>
