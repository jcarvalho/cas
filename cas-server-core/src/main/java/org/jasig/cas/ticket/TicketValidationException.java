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
package org.jasig.cas.ticket;

import org.jasig.cas.authentication.principal.Service;

/**
 * Exception to alert that there was an error validating the ticket.
 *
 * @author Scott Battaglia

 * @since 3.0
 */
public class TicketValidationException extends TicketException {

    /** Unique Serial ID. */
    private static final long serialVersionUID = 3257004341537093175L;

    /** The code description. */
    private static final String CODE = "INVALID_SERVICE";

    private final Service service;

    /**
     * Constructs a TicketValidationException with the default exception code
     * and the original exception that was thrown.
     * @param service original service
     */
    public TicketValidationException(final Service service) {
        super(CODE);
        this.service = service;
    }

    public Service getOriginalService() {
        return this.service;
    }

}
