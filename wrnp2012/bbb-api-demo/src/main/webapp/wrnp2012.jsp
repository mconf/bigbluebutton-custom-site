<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%
  request.setCharacterEncoding("UTF-8");
  response.setCharacterEncoding("UTF-8");

  //
  // CONFIGURATIONS
  //
  String meetingID = "WRNP-2012";
  String moderatorPW = "CHANGE-ME";
  String attendeePW = "CHANGE-ME-TOO";
  Integer maxUsers = 100;
  String logoutURL = "https://docs.google.com/spreadsheet/viewform?formkey=dDRSYUFBUmZocEtscnhkUzB6VzNNVkE6MA#gid=0";
  String welcomeMsg = "Esta é uma transmissão experimental realizada no contexto do projeto GT-MCONF2 - Multiconferência WEB e dispositivos móveis.<br><br>A gravação dessa sessão (áudio + bate-papo + apresentação) estará disponível posteriormente em <a href=\"event:http://wrnp2012.mconf.org\"><u>wrnp2012.mconf.org</u></a>.";

  boolean userIsMod = false;
  boolean userValid = false;

  // calls getMeetingInfo to get the number of users in the meeting
  Integer usersNow = 0;
  Document doc = null;
  try {
    String data = getMeetingInfo(meetingID, moderatorPW);
    doc = parseXml(data);
     if (doc.getElementsByTagName("returncode").item(0).getTextContent().trim().equals("SUCCESS")) {
       String tmp = doc.getElementsByTagName("participantCount").item(0).getTextContent().trim();
       usersNow = Integer.parseInt(tmp);
    }
  } catch (Exception e) {
    e.printStackTrace();
  }

  // gets the user role and sets userValid if everything is ok
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

<div id="main"><div id="main_content" class="container">

<%
  if (usersNow >= maxUsers && !userIsMod) {
%>

<div class="alert alert-warning">
  Desculpe, o sistema alcançou o número máximo de usuários. Tente novamente mais tarde.
</div>
<a href="/">Voltar...</a>


<%
  // user invalid == wrong moderator password
  } else if (!userValid) {
%>

<div class="alert alert-error">
  Senha de moderador inválida.
</div>
<a href="/">Voltar...</a>

<%
  // user invalid == wrong moderator password
  } else if (request.getParameter("username").trim() == "") {
%>

<div class="alert alert-error">
  Você precisa especificar o seu nome para entrar na sessão.
</div>
<a href="/">Voltar...</a>

<%
  } else {

    // don't let a normal user create the room
    if (!userIsMod) {
      if (!isMeetingRunning(meetingID).equals("true")) {
%>

<div class="alert alert-warning">
  A sessão ainda não foi iniciada. Por favor espere o moderador iniciar a sessão e tente novamente.
</div>
<a href="/">Voltar...</a>

<%
        return;
      }
    }

    String joinURL = wrnpJoinURL(request.getParameter("username"), meetingID,
                                 "true", welcomeMsg, null, null, moderatorPW, attendeePW,
                                 userIsMod, logoutURL);
    if (joinURL.startsWith("http://")) {

      if (request.getParameter("mobile").equals("1")) {
        joinURL = joinURL.replace("http://", "bigbluebutton://");
      }
%>

<div class="alert alert-success">
  Se você não for redirecionado, <a href="<%=joinURL%>">clique aqui</a> para entrar.
</div>
<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
    } else { // wrong url
%>

<div class="alert alert-error">
  URL inválida. Verifique se seus dados de entrada.
</div>
<a href="/">Voltar...</a>

<%
    }
  }
%>

</div></div>
</body>
</html>
