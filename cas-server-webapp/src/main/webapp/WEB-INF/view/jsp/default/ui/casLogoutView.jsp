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
            <h2><spring:message code="screen.logout.header"/></h2>
            <p id="waiting"><spring:message code="screen.logout.please.wait"/></p>
            <p id="logout-error" class="hide"><spring:message code="screen.logout.error"/></p>
            <p id="logout-success" class="hide"><spring:message code="screen.logout.success"/></p>

            <div class="progress">
                <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
            </div>

            <iframe id="logout_iframe" width="0" height="0" class="hide" frameborder="0"></iframe>

            <aside class="horizontal" id="service-list">
            </aside>

            <p id="finish-message" class="hide"><spring:message code="screen.logout.finish.message"/></p>
        </main>

      <script>
      window.services = [
        {'name': 'Sistema Fenix', 'url': 'https://fenix.tecnico.ulisboa.pt/logoff.do?logoutFromCAS=true'},
        {'name': 'Barra do IST', 'url': 'https://barra.tecnico.ulisboa.pt/logout'},
        {'name': 'Erro', 'url': 'http://fenix.tecnico.ulisboa.pt/notFound.jsp'}];
      </script>
      <script src="<c:url value="/js/logout.js" />"></script>
<jsp:directive.include file="includes/bottom.jsp" />