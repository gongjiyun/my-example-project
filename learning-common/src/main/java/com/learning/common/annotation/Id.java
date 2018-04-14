package com.learning.common.annotation;

import com.learning.common.db.SampleIdGenHandler;

import java.lang.annotation.*;

@Target({ElementType.TYPE,ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Id {

	String[] combineColumns() default "";
	
	String sequence() default "SQ_ISN.NEXTVAL";
	
	String idGenStrage() default "sequence";

	Class<?> idGenHandler() default SampleIdGenHandler.class;
}
