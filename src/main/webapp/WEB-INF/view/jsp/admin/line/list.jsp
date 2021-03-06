<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Olive Enterprise">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/img/favicon.ico">
<title>EGG流量管理系统</title>
<link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/bootstrap-reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/advanced-datatable/media/css/demo_page.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/advanced-datatable/media/css/demo_table.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/data-tables/DT_bootstrap.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/style-responsive.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/customer/common.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
</head>
<body>
	<section id="container">
		<%@ include file="/WEB-INF/view/jsp/header.jsp"%>
		<section id="main-content">
			<section class="wrapper">
				<div class="jumbotron">
					<h2>线路管理</h2>
					<pre>此处可以对线路进行编辑和删除</pre>
				</div>
				<c:choose>
					<c:when test="${error != null}">
						<div class="col-sm-12">
								<p class="text-danger text-center" style="font-size: 30px">${error}</p>
						</div>
					</c:when>
					<c:otherwise>
						<table class='table table-striped table-bordered table-hover dataTables-example table-condensed'>
							<thead>
								<tr>
									<th class='text-center' style='width: 50%'>线路名</th>
									<th class='text-center' style='width: 50%'>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="list">
									<tr>
										<td class='text-center'>【${list.type eq '0' ? "Tiny" : "Fmns3"}】${list.name}</td>
										<td class='text-center'>
											<button type=button class="btn btn-xs btn-danger" onclick="del(this, ${list.id})">
												<i class="fa fa-trash-o"></i> 删除
											</button>
											<button type=button class="btn btn-xs btn-primary" onclick="edit(${list.id})">
												<i class="fa fa-edit"></i> 编辑
											</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</section>
		</section>
		<%@ include file="/WEB-INF/view/jsp/footer.jsp"%>
	</section>
	<div class="modal fade" id="out" tabindex="-1" role="basic"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated">
				<section class="panel">
					<header class="panel-heading tab-bg-dark-navy-blue">
						<span class="label label-primary">线路编辑</span>
					</header>
					<div class="panel-body">
						<form action="" onsubmit="return jssubmit(this, '<%=request.getContextPath()%>/Admin/Line/editLine/update')">
							<input type="hidden" name="id" value="" />
							<div class="item">
								<div class="form-group text-center">
									<label for="name">线路名称</label>
									<input type="text" class="form-control" name="name" id="name" placeholder="输入线路名称">
								</div>
								<div class="form-group text-center">
									<label for="index">线路排序</label>
									<input type="text" class="form-control" name="index" id="index" placeholder="0-999(值越小越靠前)">
								</div>
								<div class="form-group text-center">
									<label for="value">线路内容</label>
									<textarea class="form-control" name="value" id="value" style="height: 80px;"></textarea>
								</div>
								<div class="form-group text-center">
									<button type="submit" class="btn btn-primary" type="button">保存</button>
									&nbsp;&nbsp;
									<button type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
								</div>
								<div class="form-group text-center backinfo" style='color: red'></div>
							</div>
						</form>
					</div>
				</section>
			</div>
		</div>
	</div>

	<script src="<%=request.getContextPath()%>/js/demo/dome.min.js"></script>
	
	<script src="<%=request.getContextPath()%>/assets/advanced-datatable/media/js/jquery.js"></script><!-- BASIC JQUERY JS  -->
	<script src="<%=request.getContextPath()%>/js/bootstrap.min.js" ></script><!-- BOOTSTRAP JS  -->
	<script src="<%=request.getContextPath()%>/js/jquery.dcjqaccordion.2.7.js"></script><!-- ACCORDING JS -->
	<script src="<%=request.getContextPath()%>/js/jquery.scrollTo.min.js" ></script><!-- SCROLLTO JS  -->
	<script src="<%=request.getContextPath()%>/js/jquery.nicescroll.js" > </script><!-- NICESCROLL JS  -->
	<script src="<%=request.getContextPath()%>/js/respond.min.js" ></script><!-- RESPOND JS  -->
	<script src="<%=request.getContextPath()%>/js/common-scripts.js" ></script><!-- BASIC COMMON JS  -->
	<script type="text/javascript">
	function edit(id) {
		$.post('<%=request.getContextPath()%>/Admin/Line/editLine/get', {id : id}, function(data) {
			if (data != null) {
				$("input[name='id']").attr("value", data.id);
				$("input[name='index']").val(data.index);
				$("input[name='name']").val(data.name);
				$("textarea").val(data.value);
			}
		}, "json");
		$("#out").modal('show');
	}
	function del(demo, id) {
		$.post("<%=request.getContextPath()%>/Admin/Line/delLine", {id : id}, function() {
			$(demo).parent().parent().remove();
		});
	}
	</script>
	<script>
		$(document).ready(function() {
			$(".modal").on("hide.bs.modal", function() {
				var text = $(".backinfo").text();
				$("#btn .btn-info").remove();
				$(".backinfo").text("");
				if (text.indexOf("改成功") > 0) {
					window.location.href = "<%=request.getContextPath()%>/Admin/Line/getLine";
				}
			});
		});
	</script>
</body>

</html>