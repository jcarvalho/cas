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
<%@ page pageEncoding="UTF-8" %>
<jsp:directive.include file="includes/top.jsp" />
        <header>
            <h1 class="title"><a href="#"><spring:message code="screen.page.title"/></a></h1>
        </header>

        <main>
            <c:set var="registry" value='<%= org.springframework.web.servlet.support.RequestContextUtils.getWebApplicationContext(request).getBean(org.jasig.cas.ticket.registry.TicketRegistry.class) %>' />
            <c:set var="authentication" value="${registry.getTicket(ticketGrantingTicketId).authentication}" />
            <div class="welcome-user" align="center">
                <img src="https://fenix.tecnico.ulisboa.pt/user/photo/${authentication.principal.id}" alt="${authentication.principal.id}">
                <h2><spring:message code="screen.success.hello"/> <a href="#">${authentication.principal.id}</a>!</h2>

                <div class="row row-no-padding">
                    <ul class="group-button">
                            <li><a href="http://tecnico.ulisboa.pt/"><spring:message code="screen.success.tecnico.website"/></a></li>
                            <li><a href="https://fenix.tecnico.ulisboa.pt">Fénix</a></li>
                            <li><a href="https://webmail.tecnico.ulisboa.pt">Webmail</a></li>
                            <li><a href="https://ciist.ist.utl.pt/servicos/">Self-service</a></li>
                    </ul>
                </div>

                <div class="container-fluid">
                    <div class="row">
                        <a href="https://id.ist.utl.pt/password/index.php" class="light-gray col-xs-12 col-sm-6"><spring:message code="screen.success.change.password"/></a>
                        <a href="logout" class="active col-xs-12 col-sm-6"><spring:message code="screen.success.logout"/></a>
                    </div>
                </div>

            </div>
        </main>
<jsp:directive.include file="includes/bottom.jsp" />
