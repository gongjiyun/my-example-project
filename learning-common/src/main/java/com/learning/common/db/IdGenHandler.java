package com.learning.common.db;

import java.sql.Connection;

public interface IdGenHandler {
    public String generate(Connection conn) throws Exception;

}
