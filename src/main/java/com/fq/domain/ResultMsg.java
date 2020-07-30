package com.fq.domain;

import lombok.Data;
import org.springframework.stereotype.Component;

@Data
@Component
public class ResultMsg {
    private Boolean success;
    private String msg;
}
