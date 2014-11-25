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
            <nav id="auth-box">
                <ul>
                    <li>
                        <spring:message code="screen.login.auth.method"/>: <span id="auth-method"><spring:message code="screen.login.auth.method.tecnicoid"/></span>
                        <i class="icon-down-open">&nbsp;</i>
                        <ul id="auth-modes">
                            <li data-toggle-auth-method="istid"><a href="#"><spring:message code="screen.login.auth.method.tecnicoid"/></a></li>
                            <li data-toggle-auth-method="kerberos"><a href="#"><spring:message code="screen.login.auth.method.kerberos"/></a></li>
                            <li data-toggle-auth-method="cartaocidadao"><a href="#"><spring:message code="screen.login.auth.method.citizencard"/></a></li>
                            <li data-toggle-auth-method="eideuropeu"><a href="#"><spring:message code="screen.login.auth.method.stork"/></a></li>
                        </ul>
                    </li>
                </ul>
            </nav>

            <form:form method="post" id="loginForm" commandName="${commandName}" htmlEscape="true">
                <!-- Técnico ID -->
                <fieldset data-auth-method="istid">
                    <form:input cssClass="required" cssErrorClass="error" id="username" size="10" tabindex="1" path="username" htmlEscape="true" placeholder="Técnico ID" autofocus="autofocus" />
                    <form:password cssClass="required" cssErrorClass="error" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" placeholder="Password" required="required" />

                    <label for="mem-istid" class="mem-authentication">
                        <input type="checkbox" name="mem-istid"  id="mem-istid" checked="checked"/>
                        <span></span>
                        <spring:message code="screen.login.agreement"/>
                    </label>

                    <c:set var="errors"><form:errors/></c:set>
                    <c:if test="${not empty errors}">
                        <div class="error-message">
                            <p><span class="icon-attention">&nbsp;</span><spring:message code="screen.login.error"/></p>
                        </div>
                    </c:if>

                    <input type="submit" value='<spring:message code="screen.login.button"/>' class="action" name="submit-istid" id="submit-istid">
                </fieldset>
                <!-- end fieldset Técnico ID -->

                <!-- KERBEROS -->
                <fieldset data-auth-method="kerberos">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-1">
                                <i class="icon-lock active"></i>
                            </div>
                            <div class="col-xs-11">
                                <p><spring:message code="screen.login.requirements"/>
                                    <a href="https://suporte.dsi.tecnico.ulisboa.pt/categorias/autenticacao-e-acesso/" class="underline"><spring:message code="screen.login.requirements.kerberos"/></a>:</p>
                                <ul class="block">
                                    <span class="icon-right-open-mini"> </span><li><spring:message code="screen.login.requirements.kerberos.support"/></li>
                                    <span class="icon-right-open-mini"> </span><li><spring:message code="screen.login.requirements.kerberos.tgt"/></li>
                                </ul>
                            </div>
                        </div>

                    </div>

                    <label for="mem-kerberos" class="mem-authentication">
                        <input type="checkbox" name="mem-kerberos"  id="mem-kerberos" checked="checked"/>
                        <span></span>
                        <spring:message code="screen.login.agreement"/>
                    </label>

                    <input type="button" value="<spring:message code="screen.login.continue"/>" name="submit-kerberos" id="submit-kerberos">
                </fieldset>
                <!-- end KERBEROS -->

                <!-- CARTÃO CIDADÃO -->
                <fieldset data-auth-method="cartaocidadao">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-2">
                                <span class="ccidadao"></span>
                            </div>
                            <div class="col-xs-10">
                                <p><spring:message code="screen.login.requirements"/>
                                    <a href="https://suporte.dsi.tecnico.ulisboa.pt/categorias/autenticacao-e-acesso/" class="underline"><spring:message code="screen.login.requirements.citizencard"/></a>:</p>
                                <ul class="block">
                                    <span class="icon-right-open-mini"> </span><li><spring:message code="screen.login.requirements.reading.system"/></li>
                                    <span class="icon-right-open-mini"> </span><li><spring:message code="screen.login.requirements.card.in.reader"/></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <label for="mem-cartaocidadao" class="mem-authentication">
                        <input type="checkbox" name="mem-cartaocidadao"  id="mem-cartaocidadao" checked="checked"/>
                        <span></span>
                        <spring:message code="screen.login.agreement"/>
                    </label>

                    <input type="button" value="<spring:message code="screen.login.continue"/>" name="submit-ccidadao" id="submit-ccidadao">
                </fieldset>
                <!-- end CARTÃO CIDADÃO -->

                <!-- E-ID EUROPEU -->
                <fieldset data-auth-method="eideuropeu">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-2">
                                <i class="eid-europeu"></i>
                            </div>
                            <div class="col-xs-10">
                                <p><spring:message code="screen.login.requirements"/>
                                    <a href="https://suporte.dsi.tecnico.ulisboa.pt/categorias/autenticacao-e-acesso/" class="underline"><spring:message code="screen.login.requirements.stork"/></a>:</p>
                                <ul class="block">
                                    <span class="icon-right-open-mini"> </span><li><spring:message code="screen.login.requirements.reading.system"/></li>
                                    <span class="icon-right-open-mini"> </span><li><spring:message code="screen.login.requirements.card.in.reader"/></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <label for="mem-eideuropeu" class="mem-authentication">
                        <input type="checkbox" name="mem-eideuropeu"  id="mem-eideuropeu" checked="checked"/>
                        <span></span>
                        <spring:message code="screen.login.agreement"/>
                    </label>

                    <input type="button" value="<spring:message code="screen.login.continue"/>" name="submit-eideuropeu" id="submit-eideuropeu">
                </fieldset>
                <!-- end E-ID EUROPEU -->

                <input type="hidden" name="lt" value="${loginTicket}" />
                <input type="hidden" name="execution" value="${flowExecutionKey}" />
                <input type="hidden" name="_eventId" value="submit" />

                <!-- Recuperar pass / Nao tenho ISTID -->
                <ul>
                    <li class="centered-xs"><a href="https://id.tecnico.ulisboa.pt/password/recover.php"><spring:message code="screen.login.recover.password"/></a>
                    </li>
                    <li class="right hidden-xs"><a href="https://suporte.dsi.tecnico.ulisboa.pt/faq/como-e-que-uma-pessoa-externa-ou-convidada-pode-ter-acesso-temporario-aos-servicos-informaticos"><spring:message code="screen.login.create.tecnico.id"/></a>
                    </li>
                </ul>

            </form:form>
          </main>

        <script src="<c:url value="/js/cas.js" />"></script>
<jsp:directive.include file="includes/bottom.jsp" />
