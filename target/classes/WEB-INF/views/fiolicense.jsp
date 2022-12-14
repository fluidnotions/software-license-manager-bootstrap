<%@ page language="java" contentType="text/html; utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Cache-Control"
	content="no-store, no-cache, must-revalidate, max-age=0">
<script
	src='<c:url value="http://code.jquery.com/jquery-1.11.1.min.js" />' type="text/javascript"></script>
<script
	src='<c:url value="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" />' type="text/javascript"></script>
<script
	src='<c:url value="http://cdn.datatables.net/1.10.3/js/jquery.dataTables.js" />' type="text/javascript"></script>
<link
	href='<c:url value="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />'
	rel="stylesheet">
<link
	href='<c:url value="http://cdn.datatables.net/plug-ins/380cb78f450/integration/jqueryui/dataTables.jqueryui.css" />'
	rel="stylesheet">
<link href='<c:url value="/resources/common/main.css" />'
	rel="stylesheet">
<link
	href='<c:url value="/resources/lib/bootstrap/css/bootstrap.css" />'
	rel="stylesheet">


<title>License Manager</title>
<script type="text/javascript">
	$(document).ready(function() {
		var table = $('#licenses').DataTable({
			"ajax" : {
				"url" : "getAllFioLicense.json",
				"dataSrc" : ""
			},
			"columns" : [ {
				"data" : "serialNumber"
			}, {
				"data" : "appVersion"
			}, {
				"data" : "activationDate"
			}, {
				"data" : "expirationDate"
			}, {
				"data" : "lastAgentComActionResult"
			}, {
				"data" : "lastAgentComTime"
			}, {
				"data" : "enabled"
			}

			]
		});

		setInterval(function() {
			table.ajax.reload();
		}, 5000);
		
		/* $( "#" ).accordion({ collapsible: true }); */
		
	});

	$(function() {
		$("#datepicker").datepicker();
	});
	
	

	$(function() {
		$(".btn").button().click(function(event) {
			event.preventDefault();
			window.location.href = "logout.html";
		});
	});
</script>
</head>
<body>


	<div class="container">
		<div id="heading" class="masthead">
			<div class="pull-right">
				<span class="text-info"><em></em></span>&nbsp;
				<button class="btn">
					<i class="icon-off"></i>
				</button>
			</div>
			<h3 class="muted">License Manager</h3>
		</div>
		<div id="main-content">
			<div id="left">
				<div id="form">
					<form:form action="fioLicense.do" method="POST"
						commandName="fioLicense">
						<table>
							<tr>
								<td>Serial Number</td>
								<!-- TODO:auto generate on create  -->
								<td><form:input path="serialNumber" /></td>
							</tr>
							<tr>
								<td>Contact Name</td>
								<td><form:input path="contactName" /></td>
							</tr>
							<tr>
								<td>Email</td>
								<td><form:input path="email" /></td>
							</tr>
							<tr>
								<td>Application Version</td>
								<td><form:input path="appVersion" /></td>
							</tr>
							<tr>
								<td>Period (initial/extension)</td>
								<!-- period selector -->
								<td><form:select path="validityPeriodString">
										<form:option value="NONE" label="--- Select ---" />
										<form:options items="${validityPeriodOptionList}" />
									</form:select></td>
							</tr>
							<tr>
								<td>Activation Date</td>
								<!-- calander selector -->
								<td><form:input path="activationDateString" id="datepicker" /></td>
							</tr>
							<tr>
								<td>File Byte Size</td>
								<td><form:input path="licfileByteSize" /></td>
							</tr>
							<tr>
								<td>Checksum</td>
								<td><form:input path="licfileCheckSum" /></td>
							</tr>
							<tr>
								<td>Suspend (now)</td>
								<td></td>
								<td align="right"><form:checkbox path="suspend" /></td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2"><input type="submit" name="action"
									value="Search" /> <input type="submit" name="action"
									value="Create" /> <input type="submit" name="action"
									value="Update" /> <input type="submit" name="action" value="Delete" />
								</td>
							</tr>
						</table>
					</form:form>
				</div>
				<div id="right">
					<c:if test="${!empty fioLicenseAdminEvents}">
						<table table id="evs" cellspacing="0"  border="1" width="100%">
							<thead>
								<tr>
									<td>Type</td>
									<td>Details</td>
									<td>Application</td>
									<td>User</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="ev" items="${fioLicenseAdminEvents}">
									<tr>
										<td>${ev.eventType}</td>
										<td>${ev.eventDetails}</td>
										<td>${ev.applicationTimestamp}</td>
										<td>${ev.byUsername}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
				</div>
			</div>
		</div>


		<div id="main-content">
			<div id="list">
				<h3 class="muted">License Table</h3>
				<table id="licenses" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>Serial Number</th>
							<th>Version</th>
							<th>Activation Date</th>
							<th>Expiration Date</th>
							<th>Result</th>
							<th>Last Activity</th>
							<th>Enabled</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

</body>
</html>