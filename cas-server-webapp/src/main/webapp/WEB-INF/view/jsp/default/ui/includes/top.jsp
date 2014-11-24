<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<!DOCTYPE html>

<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<!--[if lt IE 7]><html class="no-js lt-ie9 lt-ie8 lt-ie7"><![endif]-->
<!--[if IE 7]><html class="no-js lt-ie9 lt-ie8"><![endif]-->
<!--[if IE 8]><html class="no-js lt-ie9"><![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <title>Autenticação no Técnico Lisboa</title>
    <meta name="author" content="">
    <meta name="description" content="">
    <meta name="keywords" content="">

    <!-- Favicon to work in all desktop browsers: -->
    <link rel="shortcut icon" href="//static.tecnico.ulisboa.pt/favicon.png" type="image/png">
    <!-- Touch icon for iOS 2.0+: -->
    <link rel="apple-touch-icon-precomposed" sizes="180x180" href="//static.tecnico.ulisboa.pt/apple-touch-icon-180x180-precomposed.png">
    <!-- Touch icon for Android -->
    <link rel="apple-touch-icon-precomposed" href="//static.tecnico.ulisboa.pt/apple-touch-icon-144x144-precomposed.png">

    <!-- Google web fonts -->
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700,400italic,600italic,700italic' rel='stylesheet' type='text/css'>

    <spring:theme code="standard.custom.css.file" var="customCssFile" />
    <link rel="stylesheet" href="<c:url value="${customCssFile}" />" />
    <link rel="icon" href="<c:url value="/favicon.ico" />" type="image/x-icon" />

    <!-- HTML5 elements and Media queries support IE8 and below -->
    <!--[if lt IE 9]>
          <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7/html5shiv.js"></script>
          <script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.js"></script>
        <![endif]-->
</head>

<body>
<!--[if lt IE 9]>
    <p class="outdatedbrowser">Está a usar uma versão <strong>desatualizada</strong> do seu browser. Por favor <a href="//http://outdatedbrowser.com/">atualize-o</a> para melhorar a sua experiência.</p>
<![endif]-->

    <c:if test="${empty requestScope['isMobile']}">
        <div id="bg" style="background: url(images/bg-0<%= (int) (Math.random() * 5) + 1 %>-blur.jpg)"></div>
    </c:if>

    <!-- Page Container -->
    <div class="center-container container-sm">

