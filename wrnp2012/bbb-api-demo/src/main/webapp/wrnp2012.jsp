<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
  request.setCharacterEncoding("UTF-8"); 
  response.setCharacterEncoding("UTF-8"); 

  String roomName = "WRNP-2012";
  String moderatorPW = "CHANGE-ME";
  String attendeePW = "CHANGE-ME-TOO";
  boolean userIsMod = false;
  Integer maxUsers = 100;

  boolean userValid = false;

  Integer usersNow = 0;
  Document doc = null;
  try {
    String data = getMeetingInfo(roomName, moderatorPW);
    doc = parseXml(data);
     if (doc.getElementsByTagName("returncode").item(0).getTextContent().trim().equals("SUCCESS")) {
       String tmp = doc.getElementsByTagName("participantCount").item(0).getTextContent().trim();
       usersNow = Integer.parseInt(tmp);
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="text/javascript" src="/js/mconf-wrnp2012.js"></script>
  <link rel="stylesheet" href="/css/mconf-bootstrap.min.css" type="text/css" />
  <link rel="stylesheet" href="/css/style.css" type="text/css" />
  <title>Join WRNP 2012</title>
</head>

<body>

<%@ include file="bbb_api.jsp"%>

<div id="header" class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
      <div class="pull-left">
        <a class="brand" href="http://mconf.org">Mconf.org</a>
      </div>
    </div>
  </div>
</div>

<div id="main"><div id="main_content">

<%
  if (usersNow >= maxUsers) {
%>

Desculpe, o sistema alcançou o número máximo de usuários. Tente novamente mais tarde.

<%
  } else if (request.getParameter("action").equals("create")) {
    String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
    // String preUploadPDF = "<?xml version='1.0' encoding='UTF-8'?><modules><module name='presentation'><document url='"+url+"pdfs/sample.pdf'/></module></modules>";

    String role = request.getParameter("role");
    if (role.equals("moderator")) {
      String password = request.getParameter("password");
      if (password.equals(moderatorPW)) {
        userIsMod = true;
        userValid = true;
      }
    } else {
      userIsMod = false;
      userValid = true;
    }

    if (userValid) {
      String joinURL = wrnpJoinURL(request.getParameter("username"), roomName, "true", null, null, null, moderatorPW, attendeePW, userIsMod);
      if (joinURL.startsWith("http://")) { 
%>

<div class="alert alert-success">
  Se você não for redirecionado, <a href="<%=joinURL%>">clique aqui</a> para entrar.
</div>
<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
      } else {
%>

<div class="alert alert-error">
  URL inválida. Verifique se seus dados de entrada.
</div>
<a href="/">Voltar...</a>

<% 
      }
    }  else {
%>

<div class="alert alert-error">
  Senha de moderador inválida.
</div>
<a href="/">Voltar...</a>

<%
    }
  }
%>

</div></div>
</body>
</html>
