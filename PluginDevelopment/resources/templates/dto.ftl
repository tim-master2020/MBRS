package ${class.typePackage};

${class.visibility} class ${class.name}DTO {

<#list properties as property>
    <#if property.upper == 1>
    private ${property.type} ${property.name};
    </#if>
</#list>

<#list class.FMLinkedProperty as linkedP>
    <#if linkedP.upper == 1>
        ${linkedP.visibility} Long ${linkedP.name};
    <#else>
        ${linkedP.visibility} Set<<#rt>Long<#lt>> = new HashSet<<#rt>Long<#lt>>();
    </#if>
</#list>


    public ${class.name}DTO(){}

    <#list properties as p>
        public ${p.type} get${p.name?cap_first}(){
            return this.${p.name};
        }

        public void set${p.name?cap_first}(${p.type} ${p.name}){
            this.${p.name} = ${p.name};
        }
    </#list>

    <#list class.FMLinkedProperty as linkedP>
        <#if linkedP.upper == 1>
        public <#rt>Long<#lt> get${linkedP.name?cap_first}(){
           return this.${linkedP.name};
        }

        public void set${p.name?cap_first}(<#rt>Long<#lt> ${linkedP.name}){
            this.${linkedP.name} = ${linkedP.name};
        }
        </#if>

        <#if linkedP.upper == -1>
        <#rt>public Set<Long> get${linkedP.name?cap_first}(){
            return this.${linkedP.name};
        }
            <#lt>

        public void set${p.name?cap_first}(Set<<#rt>Long<#lt>> ${p.name}){
            this.${p.name} = ${p.name};
         }
        </#if>
    </#list>


}