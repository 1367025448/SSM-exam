package com.fq.controller;

import org.springframework.web.bind.annotation.*;

@RestController
public class test {
    @RequestMapping("/test")
    public String test(){

        int a =1/0;
        return "ss";
    }
}
