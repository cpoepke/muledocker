/**
 * (c) Copyright 2015 by CIME Software Labs.
 */

package       net.cime.mule.docker;


import        java.util.HashMap;
import        java.util.Map;


public class TestA {
    // *** Public methods ***
    
    public Map<String, String> service(Object  payload) {
        Map<String, String>  result = new HashMap<String, String>();
        
        result.put("application", "Mule Docker - Test A");
        result.put("language", "Java");
        result.put("version", System.getProperty("java.version"));
        
        return result;
    } // service
} // TestA class
