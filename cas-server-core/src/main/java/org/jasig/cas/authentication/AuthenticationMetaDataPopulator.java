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
package org.jasig.cas.authentication;

/**
 * An extension point to the Authentication process that allows CAS to provide
 * additional attributes related to the overall Authentication (such as
 * authentication type) that are specific to the Authentication request versus
 * the Principal itself.
 *
 * @author Scott Battaglia
 * @author Marvin S. Addison
 *
 * @since 3.0
 */
public interface AuthenticationMetaDataPopulator {

    /**
     * Adds authentication metadata attributes on successful authentication of the given credential.
     *
     * @param builder Builder object that temporarily holds authentication metadata.
     * @param credential Successfully authenticated credential.
     */
    void populateAttributes(AuthenticationBuilder builder, Credential credential);

    /**
     * Determines whether the populator has the capability to perform tasks on the given credential.
     * In practice, the {@link #populateAttributes(AuthenticationBuilder, Credential)} needs to be able
     * to operate on said credentials only if the return result here is <code>true</code>.
     *
     * @since 4.1
     * @param credential The credential to check.
     * @return True if populator supports the Credential, false otherwise.
     */
    boolean supports(Credential credential);
}
