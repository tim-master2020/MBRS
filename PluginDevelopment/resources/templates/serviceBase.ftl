package com.example.demo.generated.services;

import com.example.demo.generated.models.*;
import com.example.demo.generated.dto.*;
import com.example.demo.user.repositories.*;
import com.example.demo.generated.enumeration.*;
import com.example.demo.generated.interfaces.*;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * [${.now}]
 * This file was generated based on the template "${.current_template_name}".
 * Changes to this file may cause incorrect behavior and will be lost if the code is regenerated.
 */
@Service
public class ${class.name}BaseService implements ${class.name}BaseInterface {
	
	@Autowired
	private ${class.name}Repository ${class.name?uncap_first}Repository;

	<#list class.FMLinkedProperty as property>
	@Autowired
	private ${property.type?cap_first}Repository ${property.type?uncap_first}Repository;
	</#list>
	
	@Override
	public List<${class.name}DTO> findAll() {
		List<${class.name}DTO> list = new ArrayList<>();
        List<${class.name}> all = ${class.name?uncap_first}Repository.findAll();
        all.forEach(${class.name?uncap_first} -> {
            list.add(${class.name?uncap_first}.toDTO());
        });
        return list;
	}
	
	@Override
	public ${class.name}DTO getOne(Long id) {
		Optional<${class.name}> ${class.name?uncap_first} = this.${class.name?uncap_first}Repository.findById(id);
		return ${class.name?uncap_first}.get().toDTO();
	}
	
	@Override
	public ${class.name}DTO save(${class.name}DTO ${class.name?uncap_first}DTO) {
		${class.name} ${class.name?uncap_first} = new ${class.name}();
		<#list properties as property>
		${class.name?uncap_first}.set${property.name?cap_first}(${class.name?uncap_first}DTO.get${property.name?cap_first}());
		</#list>
		<#list class.FMLinkedProperty as property>
		${class.name?uncap_first}.set${property.name?cap_first}(${property.type?uncap_first}Repository.get${property.type}ById(${class.name?uncap_first}DTO.get${property.name?cap_first}()));
		</#list>
		
		this.${class.name?uncap_first}Repository.save(${class.name?uncap_first});
		return ${class.name?uncap_first}.toDTO();
	}
	
	@Override
	public ${class.name}DTO update(Long id, ${class.name}DTO ${class.name?uncap_first}) {
		${class.name} new${class.name?uncap_first}Model = ${class.name?uncap_first}Repository.getOne(id);
		if(new${class.name?uncap_first}Model == null) {
			return null;
		}
		<#list properties as property>
		new${class.name?uncap_first}Model.set${property.name?cap_first}(${class.name?uncap_first}.get${property.name?cap_first}());
		</#list>

		<#list class.FMLinkedProperty as fmProp>
			new${class.name?uncap_first}Model.set${fmProp.name?cap_first}(${fmProp.name?uncap_first}Repository.get${fmProp.name?cap_first}ById(${class.name?uncap_first}.get${fmProp.name?cap_first}()));
		</#list>

		${class.name?uncap_first}Repository.save(new${class.name?uncap_first}Model);
		return new${class.name?uncap_first}Model.toDTO();
	}
	
	@Override
	public boolean delete(Long id) {
		this.${class.name?uncap_first}Repository.deleteById(id);
		return true;
	}
	
	
}