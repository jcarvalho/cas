/*
 * Licensed to Apereo under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Apereo licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License.  You may obtain a
 * copy of the License at the following location:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.jasig.cas.support.saml.authentication.principal;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.UnsupportedEncodingException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.DataFormatException;
import java.util.zip.Inflater;
import java.util.zip.InflaterInputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.jasig.cas.authentication.principal.AbstractWebApplicationService;
import org.jasig.cas.authentication.principal.Response;
import org.jasig.cas.services.RegisteredService;
import org.jasig.cas.services.ServicesManager;
import org.jasig.cas.support.saml.util.SamlUtils;
import org.jasig.cas.util.ISOStandardDateFormat;
import org.jdom.Document;
import org.springframework.util.StringUtils;

/**
 * Implementation of a Service that supports Google Accounts (eventually a more
 * generic SAML2 support will come).
 *
 * @author Scott Battaglia
 * @since 3.1
 */
public class GoogleAccountsService extends AbstractWebApplicationService {

    private static final long serialVersionUID = 6678711809842282833L;

    private static SecureRandom RANDOM_GENERATOR = new SecureRandom();

    private static final char[] CHAR_MAPPINGS = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
    'p'};

    private static final String CONST_PARAM_SERVICE = "SAMLRequest";

    private static final String CONST_RELAY_STATE = "RelayState";

    private static final String TEMPLATE_SAML_RESPONSE =
            "<samlp:Response ID=\"<RESPONSE_ID>\" IssueInstant=\"<ISSUE_INSTANT>\" Version=\"2.0\""
            + " xmlns=\"urn:oasis:names:tc:SAML:2.0:assertion\""
            + " xmlns:samlp=\"urn:oasis:names:tc:SAML:2.0:protocol\""
            + " xmlns:xenc=\"http://www.w3.org/2001/04/xmlenc#\">"
            + "<samlp:Status>"
            + "<samlp:StatusCode Value=\"urn:oasis:names:tc:SAML:2.0:status:Success\" />"
            + "</samlp:Status>"
            + "<Assertion ID=\"<ASSERTION_ID>\""
            + " IssueInstant=\"2003-04-17T00:46:02Z\" Version=\"2.0\""
            + " xmlns=\"urn:oasis:names:tc:SAML:2.0:assertion\">"
            + "<Issuer>https://www.opensaml.org/IDP</Issuer>"
            + "<Subject>"
            + "<NameID Format=\"urn:oasis:names:tc:SAML:2.0:nameid-format:emailAddress\">"
            + "<USERNAME_STRING>"
            + "</NameID>"
            + "<SubjectConfirmation Method=\"urn:oasis:names:tc:SAML:2.0:cm:bearer\">"
            + "<SubjectConfirmationData Recipient=\"<ACS_URL>\" NotOnOrAfter=\"<NOT_ON_OR_AFTER>\" InResponseTo=\"<REQUEST_ID>\" />"
            + "</SubjectConfirmation>"
            + "</Subject>"
            + "<Conditions NotBefore=\"2003-04-17T00:46:02Z\""
            + " NotOnOrAfter=\"<NOT_ON_OR_AFTER>\">"
            + "<AudienceRestriction>"
            + "<Audience><ACS_URL></Audience>"
            + "</AudienceRestriction>"
            + "</Conditions>"
            + "<AuthnStatement AuthnInstant=\"<AUTHN_INSTANT>\">"
            + "<AuthnContext>"
            + "<AuthnContextClassRef>"
            + "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
            + "</AuthnContextClassRef>"
            + "</AuthnContext>"
            + "</AuthnStatement>"
            + "</Assertion></samlp:Response>";

    private final String relayState;

    private final PublicKey publicKey;

    private final PrivateKey privateKey;

    private final String requestId;

    private final ServicesManager servicesManager;
    
    /**
     * Instantiates a new google accounts service.
     *
     * @param id the id
     * @param relayState the relay state
     * @param requestId the request id
     * @param privateKey the private key
     * @param publicKey the public key
     * @param servicesManager the services manager
     */
    protected GoogleAccountsService(final String id, final String relayState, final String requestId,
            final PrivateKey privateKey, final PublicKey publicKey, final ServicesManager servicesManager) {
        this(id, id, null, relayState, requestId, privateKey, publicKey, servicesManager);
    }

    /**
     * Instantiates a new google accounts service.
     *
     * @param id the id
     * @param originalUrl the original url
     * @param artifactId the artifact id
     * @param relayState the relay state
     * @param requestId the request id
     * @param privateKey the private key
     * @param publicKey the public key
     * @param servicesManager the services manager
     */
    protected GoogleAccountsService(final String id, final String originalUrl,
            final String artifactId, final String relayState, final String requestId,
            final PrivateKey privateKey, final PublicKey publicKey,
            final ServicesManager servicesManager) {
        super(id, originalUrl, artifactId);
        this.relayState = relayState;
        this.privateKey = privateKey;
        this.publicKey = publicKey;
        this.requestId = requestId;
        this.servicesManager = servicesManager;
    }

    /**
     * Creates the service from request.
     *
     * @param request the request
     * @param privateKey the private key
     * @param publicKey the public key
     * @param servicesManager the services manager
     * @return the google accounts service
     */
    public static GoogleAccountsService createServiceFrom(
            final HttpServletRequest request, final PrivateKey privateKey,
            final PublicKey publicKey, final ServicesManager servicesManager) {
        final String relayState = request.getParameter(CONST_RELAY_STATE);

        final String xmlRequest = decodeAuthnRequestXML(request.getParameter(CONST_PARAM_SERVICE));

        if (!StringUtils.hasText(xmlRequest)) {
            return null;
        }

        final Document document = SamlUtils.constructDocumentFromXmlString(xmlRequest);

        if (document == null) {
            return null;
        }

        final String assertionConsumerServiceUrl = document.getRootElement().getAttributeValue("AssertionConsumerServiceURL");
        final String requestId = document.getRootElement().getAttributeValue("ID");

        return new GoogleAccountsService(assertionConsumerServiceUrl,
                relayState, requestId, privateKey, publicKey, servicesManager);
    }

    @Override
    public Response getResponse(final String ticketId) {
        final Map<String, String> parameters = new HashMap<String, String>();
        final String samlResponse = constructSamlResponse();
        final String signedResponse = SamlUtils.signSamlResponse(samlResponse,
                this.privateKey, this.publicKey);
        parameters.put("SAMLResponse", signedResponse);
        parameters.put("RelayState", this.relayState);

        return Response.getPostResponse(getOriginalUrl(), parameters);
    }

    /**
     * Return true if the service is already logged out.
     *
     * @return true if the service is already logged out.
     */
    @Override
    public boolean isLoggedOutAlready() {
        return true;
    }

    /**
     * Construct SAML response.
     *
     * @return the SAML response
     */
    private String constructSamlResponse() {
        String samlResponse = TEMPLATE_SAML_RESPONSE;

        final Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.YEAR, 1);
        
        final RegisteredService svc = this.servicesManager.findServiceBy(this);
        final String userId = svc.getUsernameAttributeProvider().resolveUsername(getPrincipal(), this);

        final String currentDateTime = new ISOStandardDateFormat().getCurrentDateAndTime();
        samlResponse = samlResponse.replace("<USERNAME_STRING>", userId);
        samlResponse = samlResponse.replace("<RESPONSE_ID>", createID());
        samlResponse = samlResponse.replace("<ISSUE_INSTANT>", currentDateTime);
        samlResponse = samlResponse.replace("<AUTHN_INSTANT>", currentDateTime);
        samlResponse = samlResponse.replaceAll("<NOT_ON_OR_AFTER>", currentDateTime);
        samlResponse = samlResponse.replace("<ASSERTION_ID>", createID());
        samlResponse = samlResponse.replaceAll("<ACS_URL>", getId());
        samlResponse = samlResponse.replace("<REQUEST_ID>", this.requestId);

        return samlResponse;
    }

    /**
     * Creates the SAML id.
     *
     * @return the id
     */
    private static String createID() {
        final byte[] bytes = new byte[20]; // 160 bits
        RANDOM_GENERATOR.nextBytes(bytes);

        final char[] chars = new char[40];

        for (int i = 0; i < bytes.length; i++) {
            final int left = bytes[i] >> 4 & 0x0f;
            final int right = bytes[i] & 0x0f;
            chars[i * 2] = CHAR_MAPPINGS[left];
            chars[i * 2 + 1] = CHAR_MAPPINGS[right];
        }

        return String.valueOf(chars);
    }

    /**
     * Decode authn request xml.
     *
     * @param encodedRequestXmlString the encoded request xml string
     * @return the request
     */
    private static String decodeAuthnRequestXML(
            final String encodedRequestXmlString) {
        if (encodedRequestXmlString == null) {
            return null;
        }

        final byte[] decodedBytes = base64Decode(encodedRequestXmlString);

        if (decodedBytes == null) {
            return null;
        }

        final String inflated = inflate(decodedBytes);

        if (inflated != null) {
            return inflated;
        }

        return zlibDeflate(decodedBytes);
    }

    /**
     * Deflate the given bytes using zlib.
     *
     * @param bytes the bytes
     * @return the converted string
     */
    private static String zlibDeflate(final byte[] bytes) {
        final ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
        final ByteArrayOutputStream baos = new ByteArrayOutputStream();
        final InflaterInputStream iis = new InflaterInputStream(bais);
        final byte[] buf = new byte[1024];

        try {
            int count = iis.read(buf);
            while (count != -1) {
                baos.write(buf, 0, count);
                count = iis.read(buf);
            }
            return new String(baos.toByteArray());
        } catch (final Exception e) {
            return null;
        } finally {
            IOUtils.closeQuietly(iis);
        }
    }

    /**
     * Base64 decode.
     *
     * @param xml the xml
     * @return the byte[]
     */
    private static byte[] base64Decode(final String xml) {
        try {
            final byte[] xmlBytes = xml.getBytes("UTF-8");
            return Base64.decodeBase64(xmlBytes);
        } catch (final Exception e) {
            return null;
        }
    }

    /**
     * Inflate the given byte array.
     *
     * @param bytes the bytes
     * @return the string
     */
    private static String inflate(final byte[] bytes) {
        final Inflater inflater = new Inflater(true);
        final byte[] xmlMessageBytes = new byte[10000];

        final byte[] extendedBytes = new byte[bytes.length + 1];
        System.arraycopy(bytes, 0, extendedBytes, 0, bytes.length);
        extendedBytes[bytes.length] = 0;

        inflater.setInput(extendedBytes);

        try {
            final int resultLength = inflater.inflate(xmlMessageBytes);
            inflater.end();

            if (!inflater.finished()) {
                throw new RuntimeException("buffer not large enough.");
            }

            inflater.end();
            return new String(xmlMessageBytes, 0, resultLength, "UTF-8");
        } catch (final DataFormatException e) {
            return null;
        } catch (final UnsupportedEncodingException e) {
            throw new RuntimeException("Cannot find encoding: UTF-8", e);
        }
    }
   
}
