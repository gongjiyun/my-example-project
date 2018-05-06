package com.learning.spring.cloud.redisconfig.annotation;

import com.learning.spring.cloud.redisconfig.RedisConfigurationRegister;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@Import(RedisConfigurationRegister.class)
public @interface EnableAutoRedisConfiguration {

    String[] value() default {};

    String[] basePackages() default {};

    Class<?>[] basePackageClasses() default {};

    ComponentScan.Filter[] includeFilters() default {};

    ComponentScan.Filter[] excludeFilters() default {};
}
