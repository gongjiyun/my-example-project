package com.learning.spring.cloud.redisconfig.annotation;

import java.lang.annotation.*;

@Target(ElementType.FIELD)
@Inherited
@Documented
@Retention(RetentionPolicy.RUNTIME)
public @interface ConfigVal {
    String key () default "";
}
