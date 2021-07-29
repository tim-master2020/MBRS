package com.example.demo.generated.services;

import com.example.demo.generated.models.*;
import com.example.demo.generated.dtos.*;
import com.example.demo.user.repositories.*;
import com.example.demo.user.interfaces.I${class.name}Service;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * [${.now}]
 * This file was generated based on the template "${.current_template_name}".
 * Changes to this file may cause incorrect behavior and will be lost if the code is regenerated.
 */
@Service
public class ${class.name}BaseService implements I${class.name}Service {
	
	@Autowired
	private ${class.name}Repository ${class.name?uncap_first}Repository;

	<#list class.FMLinkedProperty as property>
	@Autowired
	private ${property.name?cap_first}Repository ${property.name?uncap_first}Repository;
	</#list>
	
	@Override
	public List<${class.name}DTO> findAll() {
		List<${class.name}DTO> list = new ArrayList<>();
        List<${class.name}> all = (ArrayList<${class.name}>)${class.name?uncap_first}Repository.findAll();
        all.forEach(${class.name?uncap_first} -> {
            list.add(${class.name?uncap_first}.toDTO());
        });
        return list;
	}
	
	@Override
	public ${class.name}DTO getOne(Long id) {
		${class.name} ${class.name?uncap_first} = this.${class.name?uncap_first}Repository.findById(id);
		return ${class.name?uncap_first}.get().toDTO();
	}
	
	@Override
	public ${class.name}DTO save(${class.name}DTO ${class.name?uncap_first}DTO) {
		${class.name} ${class.name?uncap_first} = new ${class.name}(
		<#list properties as property>
		${class.name?uncap_first}DTO.get${property.name?cap_first}()
		</#list>
		<#list class.FMLinkedProperty as property>
		, ${property.type?uncap_first}Repository.get${property.type}ById(${class.name?uncap_first}DTO.get${property.name?cap_first}())
		</#list>);
		
		this.${class.name?uncap_first}Repository.save(${class.name?uncap_first});
		return ${class.name?uncap_first}.toDTO();
	}
	
	@Override
	public ${class.name}DTO update(Long id, ${class.name}DTO ${class.name?uncap_first}) {
		${class.name}DTO ${class.name} = this.getOne(id);
		
		if(${class.name} == null) {
			return null;
		}
		<#list properties as property>
  		${class.name}.set${property.name?cap_first}(${class.name?uncap_first}.get${property.name?cap_first}());
		</#list>
		return this.save(old${class.name});
	}
	
	@Override
	public void delete(Long id) {
		${class.name}DTO ${class.name?uncap_first} = this.getOne(id);
		this.${class.name?uncap_first}Repository.deleteById(id);
	}
	
	
}