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
<jsp:directive.include file="default/ui/includes/top.jsp" />
        <header>
            <h1 class="title"><a href="#"><spring:message code="screen.page.title"/></a></h1>
        </header>

        <main class="center">
            <h2><spring:message code="screen.server.error.heading"/></h2>

            <p><spring:message code="screen.server.error.message"/></p>
        </main>
<jsp:directive.include file="default/ui/includes/bottom.jsp" />
