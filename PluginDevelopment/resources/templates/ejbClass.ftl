package com.example.demo.generated.models;
import com.example.demo.generated.dto.*;
import javax.persistence.*;

${class.visibility} class ${class.name} {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

<#--GENERATING PERSISTANT PROPERTIES-->
<#list properties as property>
<#--	<#if property.upper == 1 -->
@Column
<#if (property.columnName)?? || (property.precision)?? || (property.length)??  || (property.unique)?? || property.lower == 0>(<#rt><#if (property.columnName)??>
<#lt>name = "${property.columnName}"<#rt></#if>
<#if (property.unique)??><#lt><#if (property.columnName)??>, </#if>unique = ${property.unique?c}<#rt></#if>
<#if property.lower == 0><#lt><#if (property.columnName)?? || (property.unique)??>, </#if>nullable = true<#rt></#if><#lt>)
</#if>
${property.visibility} ${property.type} ${property.name};
</#list>

<#--GENERATING LINKED PROPERTIES-->
<#list  class.FMLinkedProperty as linkedP>
    <#if linkedP.upper == -1 && linkedP.oppositeEnd == -1>
        @ManyToMany
    <#elseif linkedP.upper == -1 && linkedP.oppositeEnd == 1>
     @OneToMany
    <#elseif linkedP.upper == 1 && linkedP.oppositeEnd== -1>
     @ManyToOne
    <#else>
     @OneToOne
    </#if>
    <#rt>
    <#lt>
<#if (linkedP.fetch)?? || (linkedP.cascade)?? || (linkedP.mappedBy)??>(<#rt><#if (linkedP.cascade)??>
<#lt>cascade = CascadeType.${linkedP.cascade}<#rt>
</#if><#if (linkedP.fetch)??><#lt><#if (linkedP.cascade)??>, </#if>
 fetch = FetchType.${linkedP.fetch}<#rt>
</#if><#if (linkedP.mappedBy)??><#lt><#if (linkedP.cascade)?? || (linkedP.fetch)??>, </#if>
mappedBy = "${linkedP.mappedBy}"<#rt></#if><#lt>)
</#if>
        ${linkedP.visibility} <#rt><#if linkedP.upper == -1> <#lt>Set<<#rt></#if><#lt>${linkedP.type?cap_first}<#rt><#if linkedP.upper == -1><#lt>><#rt></#if><#lt> ${linkedP.name};<#if !linkedP?is_last>${'\n'}</#if>
</#list>

<#--GENERATING EMPTY CONSTRUCTOR-->
public ${class.name}() {}

<#--GENERATING GETTERS AND SETTERS-->
<#list class.FMLinkedProperty as linkedP>
    public <#rt>
    <#if linkedP.upper == -1>
        <#lt>Set<<#rt>
    </#if>
    <#lt>${linkedP.type?cap_first}<#rt>
    <#if linkedP.upper == -1>
        <#lt>><#rt>
    </#if>
    <#lt> get${linkedP.name?cap_first}() {
    return ${linkedP.name};
    }

    public void set${linkedP.name?cap_first}(<#rt>
    <#if linkedP.upper == -1>
        <#lt>Set<<#rt>
    </#if>
    <#lt>${linkedP.type}<#rt>
    <#if linkedP.upper == -1>
        <#lt>><#rt>
    </#if>
    <#lt> ${linkedP.name}) {
    this.${linkedP.name} = ${linkedP.name};
    }
</#list>

<#list properties as p>
    <#if p.upper == 1 >
        public ${p.type} get${p.name?cap_first}(){
        return ${p.name};
        }

        public void set${p.name?cap_first}(${p.type} ${p.name}){
        this.${p.name} = ${p.name};
        }
    <#else>
        <#list 1..p.upper as i>
            public ${p.type} get${p.name?cap_first}${i}(){
            return ${p.name}${i};
            }

            public void set${p.name?cap_first}${i}(${p.type} ${p.name}${i}){
            this.${p.name}${i} = ${p.name}${i};
            }
        </#list>
    </#if>
</#list>

    public Long getId(){
    return id;
    }

    public void setId(Long id){
    this.id = id;
    }

    public ${class.name}DTO toDTO{
        ${class.name}DTO ${class.name?uncap_first}DTO =  new ${class.name}DTO();
        <#list properties as property>
         ${class.name?uncap_first}.set${property.name?cap_first}(this.${property.name});
        </#list>
        <#list class.FMLinkedProperty as linkedP>
            <#if linkedP.upper == 1>
        ${class.name?uncap_first}.set${linkedP.name?cap_first}(this.${linkedP.name}.getId());
            </#if>
            <#if linkedP.upper == -1>
                Set<Long> ${linkedP.name}longList = new Set<Long>();
                for(${linkedP.type} ${linkedP.name?uncap_first} : this.${linkedP.name}){
            ${linkedP.name}longList.add(${linkedP.name?uncap_first}.getId())
                }
        ${class.name?uncap_first}DTO.set${linkedP.name?cap_first}(${linkedP.name}longList);
            </#if>
        </#list>
        return ${class.name?uncap_first}DTO;
    }

}






