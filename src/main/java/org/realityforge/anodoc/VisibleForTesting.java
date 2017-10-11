package org.realityforge.anodoc;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Mark an element only is more widely visible so it can be called from testing code.
 * This is primarily used for documentation but may be enforced by a static analysis tool in the future.
 */
@Documented
@Retention( RetentionPolicy.SOURCE )
@Target( { ElementType.TYPE, ElementType.CONSTRUCTOR, ElementType.METHOD, ElementType.FIELD } )
public @interface VisibleForTesting
{
}
