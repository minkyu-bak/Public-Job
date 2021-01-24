<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
			<table class="table table-bordered">
			<colgroup>
					<col style="width:20%">
					<col style="width:80%">
			</colgroup>
				<tr>
					<td><label for="formGroupExampleInput2">아이디</label></td>
					<td><span style="text-align: left;" id="adminId">${AdminInfo.adminId}</span></td>
					<%-- <td><input style="text-align: left;" id="adminId" name="adminId" value="${AdminInfo.adminId}"></td> --%>
					
				</tr>
				<tr>
				<td><label for="formGroupExampleInput2">이름</label></td>
				<td><span style="text-align: left;" id="adminName">${AdminInfo.adminName}</span></td>
					<%-- <td><input style="text-align: left;" id="adminName" name="adminName" value="${AdminInfo.adminName}"></td> --%>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">이메일</label></td>
					<td><input style="text-align: left;" id="adminEmail" name="adminEmail" value="${AdminInfo.adminEmail}"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">연락처</label></td>
					<td><input style="text-align: center;" size=4 maxlength=3 id="adminPhone1" name="adminPhone1" value="${AdminInfo.adminPhone1}"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="adminPhone2" name="adminPhone2" value="${AdminInfo.adminPhone2}"> - 
					<input style="text-align: center;" size=5 maxlength=4 id="adminPhone3" name="adminPhone3" value="${AdminInfo.adminPhone3}"></td>
				</tr>
				<tr>
					<td><label for="formGroupExampleInput2">권한</label></td>
					
					<c:choose>
						<c:when test="${AdminInfo.adminPermission eq 'S'}">
						<td><span>슈퍼관리자</span><input type="hidden" name="adminPermission" value='S'></td>
						</c:when>
						<c:when test="${AdminInfo.adminPermission ne 'S'}">
						<td><select id="adminPermission" name="adminPermission">
							<option value="A"
								<c:if test="${AdminInfo.adminPermission eq 'A'}">selected</c:if>>최고관리자</option>
							<option value="B"
								<c:if test="${AdminInfo.adminPermission eq 'B'}">selected</c:if>>일반관리자</option>
							<%-- <option value="C"
								<c:if test="${AdminInfo.adminPermission eq 'C'}">selected</c:if>>임시관리자</option> --%>
							</select></td>
						</c:when>
					</c:choose>
				</tr>
	
			</table>