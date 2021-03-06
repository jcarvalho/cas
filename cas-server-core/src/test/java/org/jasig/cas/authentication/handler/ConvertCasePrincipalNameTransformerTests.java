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
package org.jasig.cas.authentication.handler;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Tests for the switch-case transformer.
 *
 * @author Misagh Moayyed
 * @since 4.1
 */
public class ConvertCasePrincipalNameTransformerTests {

    @Test
    public void testUpperCaseTranformerWithTrimAndDelegate() {
        final PrefixSuffixPrincipalNameTransformer suffixTrans = new PrefixSuffixPrincipalNameTransformer();
        suffixTrans.setPrefix("a");
        suffixTrans.setSuffix("z");
        final ConvertCasePrincipalNameTransformer transformer = new ConvertCasePrincipalNameTransformer(suffixTrans);
        transformer.setToUpperCase(true);
        final String result = transformer.transform("   uid  ");
        assertEquals(result, "AUIDZ");
    }
    
    @Test
    public void testUpperCaseTranformerWithTrim() {
        final ConvertCasePrincipalNameTransformer transformer = new ConvertCasePrincipalNameTransformer();
        transformer.setToUpperCase(true);
        final String result = transformer.transform("   uid  ");
        assertEquals(result, "UID");
    }
    
    @Test
    public void testLowerCaseTranformerWithTrim() {
        final String result = new ConvertCasePrincipalNameTransformer().transform("   UID  ");
        assertEquals(result, "uid");
    }
}
