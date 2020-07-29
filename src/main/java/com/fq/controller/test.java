package com.fq.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class test {
    @PostMapping ("/test")
    public String test(){
        return "ss";
    }
}
