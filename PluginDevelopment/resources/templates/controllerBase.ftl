package com.example.demo.generated.controllers;

import com.example.demo.user.services.${class.name}Service;
import com.example.demo.generated.models.${class.name};
import com.example.demo.generated.dtos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

public class ${class.name}ControllerBase {

@Autowired
private ${class.name}Service ${class.name?uncap_first}Service;

@GetMapping
public ResponseEntity<?> getAll${class.name}s() {
return new ResponseEntity<>(${class.name?uncap_first}Service.findAll(), HttpStatus.OK);
}

@GetMapping(value="{id}")
public ResponseEntity<?> get${class.name}(@PathVariable Long id) {
return new ResponseEntity<>(${class.name?uncap_first}Service.getOne(id), HttpStatus.OK);
}

@PostMapping
public ResponseEntity<?> add${class.name}(@RequestBody ${class.name}DTO ${class.name?uncap_first}DTO) {
return new ResponseEntity<>(${class.name?uncap_first}Service.save(${class.name?uncap_first}DTO), HttpStatus.CREATED);
}

@PutMapping
public ResponseEntity<?> update${class.name}(@RequestBody ${class.name}DTO ${class.name?uncap_first}DTO) {
return new ResponseEntity<>(${class.name?uncap_first}Service.update(${class.name?uncap_first}DTO.getId(), ${class.name?uncap_first}DTO), HttpStatus.OK);
}

@DeleteMapping(value="{id}")
public ResponseEntity<?> delete${class.name}(@PathVariable Long id) {
${class.name?uncap_first}Service.delete(id);
return new ResponseEntity<>(HttpStatus.OK);
}
}