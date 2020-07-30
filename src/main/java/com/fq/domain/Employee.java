package com.fq.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

@Data
@Component
public class Employee {
    private Integer id;

    private String name;

    private Integer age;

    private String gender;

    private String address;


}
