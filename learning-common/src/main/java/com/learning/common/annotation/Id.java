package com.learning.common.annotation;

import com.learning.common.db.SeqIdGenHandler;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.TYPE,ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Id {

	String[] combineColumns() default "";
	
	String sequence() default "SQ_ISN.NEXTVAL";
	
	String idGenStrage() default "sequence";

	Class<?> idGenHandler() default SeqIdGenHandler.class;
}
