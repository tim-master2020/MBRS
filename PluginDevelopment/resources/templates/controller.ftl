package com.example.demo.user.controllers;

import com.example.demo.generated.controllers.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

@CrossOrigin("http://localhost:3000")
@Controller
@RequestMapping("/api/${class.name}")
public class ${class.name}Controller extends ${class.name}BaseController {
}