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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        </main>
        <c:set var="locale" value='<%= org.springframework.web.servlet.support.RequestContextUtils.getLocale(request) %>' />

        <c:set var='query' value='${pageContext.request.queryString.replaceAll("&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]", "")}' />
        <c:set var="xquery" value="${fn:escapeXml(query)}" />
        <c:set var="loginUrl" value="login?${xquery}${not empty xquery ? '&' : ''}locale=" />

        <footer>
            <nav>
                <ul>
                    <li><a href="security.jsp">Segurança</a></li>
                    <li><a href="https://suporte.dsi.tecnico.ulisboa.pt/categorias/autenticacao-e-acesso/">Suporte</a></li>
                    <c:choose>
                      <c:when test="${locale.language == 'en'}">
                        <li class="right"><a href="${loginUrl}pt" class="active icon-globe">Português</a></li>
                      </c:when>
                      <c:otherwise>
                        <li class="right"><a href="${loginUrl}en" class="active icon-globe">English</a></li>
                      </c:otherwise>
                    </c:choose>
                </ul>
            </nav>
        </footer>

        <span class="clearfix"></span>
    </div>
    <!-- end #container -->

    <!-- Scripts -->
    <script src="<c:url value="/js/cas.js" />"></script>
</body>

</html>
