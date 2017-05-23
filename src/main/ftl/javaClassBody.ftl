
    <#list class.attributes as at>
    <#if !isAutoGeneratedAttribute(at)>
    <#if at.visibility != "package">${at.visibility} </#if>${(at.type)!"void"} ${at.name};
    </#if>
    </#list>

    <#list class.operations as op>
    <#if !isAutoGeneratedOperation(op)>
    <@compress single_line=true>
    <#if op.visibility != "package">
        ${op.visibility}
    </#if>
    <#if op.type??>
        <#if op.type != class.name> ${op.type} </#if>
    <#else>
        void 
    </#if>
    ${op.name} (<#list op.parameters as p>${p.type} ${p.name}<#sep>, </#sep></#list>) {
    </@compress>
        <#if op.isStartActivity>
            Intent intent = new Intent(this, ${op.getStartActivity.name}.class);
            intent.putExtra("fUmlActivityParams", params);
            startActivity(intent);
        <#else>

    	//TODO: implement operation
        <#if op.type?? && !op.isConstructor>
        return null;
        </#if>

        <#if !op.isConstructor>
    	<#assign activity = op.activity>
    	<#include "javaMethodBody.ftl">
        </#if>
        </#if>
    }

    </#if>
    </#list>

    <#list class.activities as ac>
    <#if ac.visibility != "package">${ac.visibility} </#if>${(ac.type)!"void"} ${ac.name} (<#list ac.parameters as p>${p.type} ${p.name}<#sep>, </#sep></#list>) {
    	//TODO: implement operation
        <#if ac.type??>
        return null;
        </#if>
    	<#assign activity = ac >
    	<#include "javaMethodBody.ftl" >
    }

    </#list>