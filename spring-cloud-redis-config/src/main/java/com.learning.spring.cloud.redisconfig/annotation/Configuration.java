package com.learning.spring.cloud.redisconfig.annotation;

import java.lang.annotation.*;

@Target(ElementType.TYPE)
@Inherited
@Documented
@Retention(RetentionPolicy.RUNTIME)
public @interface Configuration {
    String prefix() default "";
}
